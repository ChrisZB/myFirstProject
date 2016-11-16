//
//  MRTablePopView.h
//  MRTablePopView
//
//  Created by estt on 16/9/27.
//  Copyright © 2016年 estt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActiveTypeChooseBlock)(NSString *type);

@interface MRTablePopView : UIView

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, copy) ActiveTypeChooseBlock atcBlock;

- (void)popShow;

@end
