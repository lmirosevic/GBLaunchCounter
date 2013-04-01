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

@implementation GBLaunchCounter

#pragma mark - public API

+(void)track {
    [self _incrementLaunchCount];
}

+(NSUInteger)launchCount {
    return [self _readLaunchCountNumber];
}


+(void)callHandler:(void(^)(NSUInteger launchCount))handler onLaunchNumber:(NSUInteger)number {
    if (handler) {
        if ([self launchCount] == number) {
            handler([self launchCount]);
        }
    }
    else {
        @throw [NSException exceptionWithName:@"GBLaunchCounter" reason:@"must pass valid handler" userInfo:nil];
    }
}

+(void)callHandler:(void(^)(NSUInteger launchCount))handler everyNLaunches:(NSUInteger)nLaunches startingAtLaunchNumber:(NSUInteger)number {
    if (handler) {
        if (([self launchCount] - number) % nLaunches == 0) {
            handler([self launchCount]);
        }
    }
    else {
        @throw [NSException exceptionWithName:@"GBLaunchCounter" reason:@"must pass valid handler" userInfo:nil];
    }
}

+(void)callHandler:(void(^)(NSUInteger launchCount))handler everyNLaunches:(NSUInteger)nLaunches {
    [self callHandler:handler everyNLaunches:nLaunches startingAtLaunchNumber:1];
}

#pragma mark - private API

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
