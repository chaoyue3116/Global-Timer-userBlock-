//
//  NSTimer+WW.m
//  temp
//
//  Created by WeichengWang on 16/8/24.
//  Copyright © 2016年 WW. All rights reserved.
//

#import "NSTimer+WW.h"
#import <objc/runtime.h>

static NSMutableDictionary *_instanceDictForTimer = nil;
static NSMutableDictionary *_instanceDictForBlock = nil;


@implementation NSTimer (WW)


+ (NSMutableDictionary *)TimerDictionary{
    if (_instanceDictForTimer) {
        return _instanceDictForTimer;
    }
    
    _instanceDictForTimer = [NSMutableDictionary dictionary];
    return _instanceDictForTimer;
}

+ (NSMutableDictionary *)BlockDictionary{
    if (_instanceDictForBlock) {
        return _instanceDictForBlock;
    }
    
    _instanceDictForBlock = [NSMutableDictionary dictionary];
    return _instanceDictForBlock;
}

//scheduled with navi

+ (void)scheduledTimerWithKey:(nullable NSString *)key TimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo
{
    
    NSMutableDictionary *timerDict = [self TimerDictionary];
    NSTimer *oldTime = [timerDict objectForKey:key];
    if (oldTime) {
        [oldTime invalidate];
        [timerDict removeObjectForKey:key];
        oldTime = nil;
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    
    [timerDict setObject:timer forKey:key];
    
}

+(void)invalidateWithKey:(NSString *)key{
    //remove and invalidate timer
    NSMutableDictionary *timerDict = [self TimerDictionary];
    NSTimer *timer =[timerDict objectForKey:key];
    [timer invalidate];
    [timerDict removeObjectForKey:key];
    timer = nil;
    //remove block
    NSMutableDictionary *blockDict = [self BlockDictionary];
    timerBlock block = [blockDict objectForKey:key];
    [blockDict removeObjectForKey:key];
    block = nil;
    
}

+ (void)invalidate
{
    [self invalidateWithKey:@"key"];
}

//scheduled with block

+ (void)scheduledTimerWithInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(nullable timerBlock)block
{
    [self scheduledTimerWithKey:@"key" Interval:ti repeats:yesOrNo block:block];
}

+ (void)scheduledTimerWithKey:(nullable NSString *)key Interval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(nullable timerBlock)block
{
    [self scheduledTimerWithKey:key TimeInterval:ti target:self selector:@selector(blockAction:) userInfo:@{@"timerKey":key} repeats:yesOrNo];
    NSMutableDictionary *BlockDict = [self BlockDictionary];
    timerBlock newBlock = block;
    [BlockDict setObject:newBlock forKey:key];
}


//target & Actions

+ (void)blockAction:(NSTimer *)timer
{
    NSString *currentKey = [timer.userInfo objectForKey:@"timerKey"];
    timerBlock ablock = [[self BlockDictionary] objectForKey:currentKey];
    ablock();
}

@end
