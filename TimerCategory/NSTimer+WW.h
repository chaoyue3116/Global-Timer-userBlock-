//
//  NSTimer+WW.h
//  temp
//
//  Created by WeichengWang on 16/8/24.
//  Copyright © 2016年 WW. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^timerBlock)(void);

@interface NSTimer (WW)


/**
 *  start With default key.default is "key".
 */
+ (void)scheduledTimerWithInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(nullable timerBlock)block;

/**
 *  start With customKey.
 */
+ (void)scheduledTimerWithKey:(nullable NSString *)key Interval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(nullable timerBlock)block;

/**
 *  invalidate default time which start with default key.
 */
+ (void)invalidate;

/**
 *  invalidate default time which start with custom key.
 */
+ (void)invalidateWithKey:(nullable NSString *)key;

@end
