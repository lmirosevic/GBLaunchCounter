//
//  GBLaunchCounter.h
//  GBLaunchCounter
//
//  Created by Luka Mirosevic on 29/03/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBLaunchCounter : NSObject

+(void)track;
+(NSUInteger)launchCount;

+(void)callHandler:(void(^)(NSUInteger launchCount))handler onLaunchNumber:(NSUInteger)number;
+(void)callHandler:(void(^)(NSUInteger launchCount))handler everyNLaunches:(NSUInteger)nLaunches;
+(void)callHandler:(void(^)(NSUInteger launchCount))handler everyNLaunches:(NSUInteger)nLaunches startingAtLaunchNumber:(NSUInteger)number;

@end
