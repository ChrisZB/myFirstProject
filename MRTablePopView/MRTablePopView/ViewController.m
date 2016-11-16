//
//  ViewController.m
//  MRTablePopView
//
//  Created by estt on 16/9/27.
//  Copyright © 2016年 estt. All rights reserved.
//

#import "ViewController.h"
#import "MRTablePopView.h"

#define MainScreen [[UIScreen mainScreen] bounds]
#define SCREENWIDTH MainScreen.size.width
#define SCREENHEIGHT MainScreen.size.height

@interface ViewController ()

@end

@implementation ViewController
{
    UIButton *contentBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    contentBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    contentBtn.frame = CGRectMake(100, 100, 100, 20);
    [contentBtn setTitle:@"ceshi" forState:UIControlStateNormal];
    [self.view addSubview: contentBtn];
    
    [contentBtn addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)chooseAction
{
    MRTablePopView *popView = [[MRTablePopView alloc] initWithFrame:CGRectMake(35, (SCREENHEIGHT-240)/2.0, SCREENWIDTH-35*2, 240)];
    popView.dataSource = @[@"旅游",@"健身",@"阅读",@"游戏",@"体育",@"科技",@"新闻",@"美女",@"音乐"];
    popView.atcBlock = ^(NSString *type){
        [contentBtn setTitle:type forState:UIControlStateNormal];
    };
    [popView popShow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
