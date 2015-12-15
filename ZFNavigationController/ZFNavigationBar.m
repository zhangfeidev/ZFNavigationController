//
//  ZFNavigationBar.m
//  TestNavigationController
//
//  Created by zhangfei on 15/11/27.
//  Copyright © 2015年 zhangfei. All rights reserved.
//

#import "ZFNavigationBar.h"

#define SCREENWIDTH ([UIScreen mainScreen].bounds.size.width)

@interface ZFNavigationBar ()
@end

@implementation ZFNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        [self initializeUI];
    }
    
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)initializeUI{
    self.frame = CGRectMake(0, 0, SCREENWIDTH, 64);
    self.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    
    self.barLine = [UIView new];
    self.barLine.frame = CGRectMake(0, 63, SCREENWIDTH, 1);
    self.barLine.backgroundColor = [UIColor colorWithWhite:0.639 alpha:1.000];
    [self addSubview:self.barLine];
    
    self.backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backItem.frame = CGRectMake(0, 20, 30, 44);
    [self.backItem setImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
    [self.backItem addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backItem];
    
    CGFloat titleLableX = SCREENWIDTH *0.5 - 50;
    self.titleLable = [[UILabel alloc] init];
    self.titleLable.frame = CGRectMake(titleLableX, 20, 100, 43);
    self.titleLable.text = self.title;
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.titleLable];
    
}

- (void)popViewController{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickBackitem)]) {
        [_delegate didClickBackitem];
    }else{
        NSLog(@"没有实现ZFNavigationBarDelegate协议！");
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    if (!title) {
        _titleLable.text = @"";
        return;
    }
    if ([title isEqualToString:_titleLable.text]) {
        return;
    }
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    _titleLable.text = title;
    [self setNeedsDisplay];
}
@end
