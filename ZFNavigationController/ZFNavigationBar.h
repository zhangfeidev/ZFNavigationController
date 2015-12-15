//
//  ZFNavigationBar.h
//  TestNavigationController
//
//  Created by zhangfei on 15/11/27.
//  Copyright © 2015年 zhangfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZFNavigationBarDelegate;

@interface ZFNavigationBar : UIView

@property (nonatomic, weak) id<ZFNavigationBarDelegate> delegate;
@property (nonatomic, strong) UIView *barLine;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *backItem;

@end

@protocol ZFNavigationBarDelegate <NSObject>

- (void)didClickBackitem;

@end
