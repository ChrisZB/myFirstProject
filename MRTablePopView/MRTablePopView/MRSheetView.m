//
//  MRSheetView.m
//  MRTablePopView
//
//  Created by estt on 16/11/10.
//  Copyright © 2016年 estt. All rights reserved.
//

#import "MRSheetView.h"

@implementation MRSheetView

- (void)popShow
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    window.userInteractionEnabled = YES;
    UIView *maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    maskView.tag = 222;
    maskView.backgroundColor = self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popDismiss)];
    [maskView addGestureRecognizer:dismissTap];
    
    [window addSubview:maskView];
    [window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
    animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = 0.3;
    [self.layer addAnimation:animation forKey:@"bouce"];
}

- (void)popDismiss
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    UIView *maskView = [window viewWithTag:222];
    [UIView animateWithDuration:0.15 animations:^{
        maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [maskView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
