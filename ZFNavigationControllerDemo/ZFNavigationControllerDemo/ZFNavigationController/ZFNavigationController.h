//
//  MyNavigationController.h
//  TestNavigationController
//
//  Created by zhangfei on 15/11/27.
//  Copyright © 2015年 zhangfei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZFNavigationController : UINavigationController

@property (nonatomic, assign) BOOL fullScreenPopGesture;
/**
 *  设置返回手势的范围，数值是距离页面左边的距离，默认是全屏。
 */
@property (nonatomic, assign) CGFloat maxAllowedInitialDistance;

@end
