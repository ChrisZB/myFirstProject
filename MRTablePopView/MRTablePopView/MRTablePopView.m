//
//  MRTablePopView.m
//  MRTablePopView
//
//  Created by estt on 16/9/27.
//  Copyright © 2016年 estt. All rights reserved.
//

#import "MRTablePopView.h"

@interface MRTablePopView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *popTableView;

@end

@implementation MRTablePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self. userInteractionEnabled = YES;
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        self.alpha = 1.0;
        
        _popTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        _popTableView.rowHeight = 40;
        _popTableView.scrollEnabled = YES;
        _popTableView.dataSource = self;
        _popTableView.delegate = self;
        [self addSubview:_popTableView];
    }
    return self;
}

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"type";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = _dataSource[indexPath.row];
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self popDismiss];
    if (_atcBlock) {
        _atcBlock(_dataSource[indexPath.row]);
    }
}

@end
