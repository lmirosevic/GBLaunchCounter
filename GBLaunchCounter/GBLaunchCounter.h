//
//  GBLaunchCounter.h
//  GBLaunchCounter
//
//  Created by Luka Mirosevic on 29/03/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Handler)(NSUInteger launchCount);

@interface GBLaunchCounter : NSObject

+(void)trackLaunch;
+(NSUInteger)launchCount;

+(void)callHandler:(Handler)handler onLaunchNumber:(NSUInteger)number;
+(void)callHandler:(Handler)handler inNLaunches:(NSUInteger)number;
+(void)callHandler:(Handler)handler everyNLaunches:(NSUInteger)number;

@end
