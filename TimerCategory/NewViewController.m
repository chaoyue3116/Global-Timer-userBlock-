//
//  NewViewController.m
//  temp
//
//  Created by WeichengWang on 16/8/24.
//  Copyright © 2016年 WW. All rights reserved.
//

#import "NewViewController.h"
#import "NSTimer+WW.h"

@implementation NewViewController

-(void)viewDidAppear:(BOOL)animated{
    
}


- (IBAction)dark:(id)sender {
    
    [NSTimer scheduledTimerWithInterval:1 repeats:YES block:^{
        NSLog(@"default key timer");
    }];
}
- (IBAction)dog:(id)sender {
    [NSTimer scheduledTimerWithKey:@"aa" Interval:1 repeats:YES block:^{
        NSLog(@"custom key timer");
    }];
}



@end
