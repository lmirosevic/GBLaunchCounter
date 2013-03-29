//
//  GBLaunchCounter.m
//  GBLaunchCounter
//
//  Created by Luka Mirosevic on 29/03/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBLaunchCounter.h"

#import <GBStorageController/GBStorageController.h>
#import <GBToolbox/GBToolbox.h>

static NSString * const kLaunchCountKey = @"kGBLaunchCounterLaunchCountKey";

@interface GBLaunchCounter ()

@property (strong, nonatomic) NSMutableArray    *deferredLaunchHandlers;

@end

@implementation GBLaunchCounter

#pragma mark - storage

#define _GBLaunchCounter [GBLaunchCounter sharedObject]
_singleton(GBLaunchCounter, sharedObject)
_lazy(NSMutableArray, deferredLaunchHandlers, _deferredLaunchHandlers)

#pragma mark - public API

+(void)trackLaunch {
    [self _incrementLaunchCount];
    [self _callPotentialDeferredLaunchHandlers];
}

+(NSUInteger)launchCount {
    return [self _readLaunchCountNumber];
}


+(void)callHandler:(Handler)handler onLaunchNumber:(NSUInteger)number {
    if (handler) {
        //if we're not there yet, then store it until we get there
        if ([self launchCount] < number) {
            [_GBLaunchCounter.deferredLaunchHandlers addObject:@{@"handler":[handler copy], @"count":@(number)}];
        }
        //if we're there then call it right away
        else if ([self launchCount] == number) {
            handler([self launchCount]);
        }
    }
    else {
        @throw [NSException exceptionWithName:@"GBLaunchCounter" reason:@"must pass valid handler" userInfo:nil];
    }
}

+(void)callHandler:(Handler)handler inNLaunches:(NSUInteger)number {
    [self callHandler:handler onLaunchNumber:[self launchCount] + number];
}

+(void)callHandler:(Handler)handler everyNLaunches:(NSUInteger)number {
    //foo todo
}

#pragma mark - private API

+(void)_callPotentialDeferredLaunchHandlers {
    NSMutableArray *calledHandlers = [NSMutableArray new];
    
    //see if there is any deferred launch handler which matches our launch number
    for (NSDictionary *handlerDict in _GBLaunchCounter.deferredLaunchHandlers) {
        if ([handlerDict[@"count"] integerValue] == [self launchCount]) {
            //call our block
            Handler handlerBlock = handlerDict[@"handler"];
            if (handlerBlock) {
                handlerBlock([self launchCount]);
            }
            
            //mark it for removal
            [calledHandlers addObject:handlerDict];
        }
    }
    
    for (NSDictionary *handlerDict in calledHandlers) {
        //remove the block from memory
        [_GBLaunchCounter.deferredLaunchHandlers removeObject:handlerDict];
    }
}

+(void)_incrementLaunchCount {
    NSUInteger oldLaunchCount = [self _readLaunchCountNumber];
    NSUInteger newLaunchCount = oldLaunchCount + 1;
    
    [self _storeLaunchCountNumber:newLaunchCount];
}

+(NSUInteger)_readLaunchCountNumber {
    id launchCountObject = GBStorage[kLaunchCountKey];
    //make sure its set
    if ([launchCountObject isKindOfClass:[NSNumber class]]) {
        NSInteger launchCountSignedIntegerValue = [launchCountObject integerValue];
        if (launchCountSignedIntegerValue <= 0) {
            return 0;
        }
        else {
            return (NSUInteger)launchCountSignedIntegerValue;
        }
    }
    //if it isnt set return 0
    else {
        return 0;
    }
}

+(void)_storeLaunchCountNumber:(NSUInteger)count {
    GBStorage[kLaunchCountKey] = @(count);
    [GBStorage save];
}

@end
