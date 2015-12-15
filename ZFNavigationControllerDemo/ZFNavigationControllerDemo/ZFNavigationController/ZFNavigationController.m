//
//  MyNavigationController.m
//  TestNavigationController
//
//  Created by zhangfei on 15/11/27.
//  Copyright © 2015年 zhangfei. All rights reserved.
//

#import "ZFNavigationController.h"
#import "ZFNavigationBar.h"
#import <objc/runtime.h>

@interface UIViewController (ZFNavigationBar)

@property (nonatomic, strong) ZFNavigationBar *navigationBar;
@property (nonatomic, getter=isNavigationBar) BOOL navigationBarHidden;
@property (nonatomic, copy) NSString *title;

@end

@implementation UIViewController (ZFNavigationBar)

@dynamic navigationBar;
@dynamic navigationBarHidden;
@dynamic title;

- (ZFNavigationBar *)navigationBar{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBar:(ZFNavigationBar *)navigationBar{
    objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isNavigationBar{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    objc_setAssociatedObject(self, @selector(isNavigationBar), @(navigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (NSString *)title{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setTitle:(NSString *)title{
    objc_setAssociatedObject(self, @selector(title), title, OBJC_ASSOCIATION_COPY);
}
@end


@interface ZFNavigationController () <ZFNavigationBarDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) ZFNavigationBar *rootViewNavgationBar;

@end

@implementation ZFNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _maxAllowedInitialDistance = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

- (void)loadView{
    
    [super loadView];
    self.navigationBar.hidden = YES;
    self.rootViewNavgationBar = [[ZFNavigationBar alloc] init];
    self.rootViewNavgationBar.delegate = self;
    self.rootViewNavgationBar.title = self.topViewController.title;
    [self.topViewController.view addSubview:self.rootViewNavgationBar];
    
    if (self.childViewControllers.count == 1) {
        self.rootViewNavgationBar.backItem.hidden = YES;
    }
    
    if (self.fullScreenPopGesture) {
        id target = self.interactivePopGestureRecognizer.delegate;
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:internalAction];
        panGesture.delegate = self;
        [self.view addGestureRecognizer:panGesture];
        panGesture.maximumNumberOfTouches = 1;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    ZFNavigationBar *naviBar = [[ZFNavigationBar alloc] init];
    naviBar.delegate = self;
    [viewController.view addSubview:naviBar];
    if (viewController.navigationBarHidden) {
        naviBar.hidden = YES;
    }
    naviBar.title = viewController.title;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}

- (void)didClickBackitem{
    [self popViewControllerAnimated:YES];
}

#pragma mark - Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = self.maxAllowedInitialDistance;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    return YES;
}
@end


