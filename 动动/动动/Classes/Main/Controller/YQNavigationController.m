//
//  YQNavigationController.m
//  动动
//
//  Created by tarena on 2016/10/18.
//  Copyright © 2016年 tad23. All rights reserved.
//

#import "YQNavigationController.h"
#import "YQLeftBarButtonItemTVC.h"
#import "YQRightBarButtonItemTVC.h"

@interface YQNavigationController ()<CAAnimationDelegate>
@property (nonatomic) UIButton *rightButton;

@end

@implementation YQNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
}

/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{
    // 设置setupTabBarAndNavigationBarColor的颜色
    [self setupTabBarAndNavigationBarColor];
}

/**
 *  设置setupTabBarAndNavigationBarColor的颜色
 */
+ (void)setupTabBarAndNavigationBarColor
{
    
    [UITabBar appearance].backgroundColor = YQBlackColor;
    [UITabBar appearance].barTintColor = YQBlackColor;
    
    [UINavigationBar appearance].backgroundColor = YQBlackColor;
    [UINavigationBar appearance].barTintColor = YQBlackColor;
    
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
    }else
    {
       viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"imgGroupInvitationIcon" highImageName:nil target:self action:@selector(clickLeftBarButtonItem)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"dd_Activity_add" highImageName:nil target:self action:@selector(clickRightBarButtonItem:)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)clickLeftBarButtonItem
{
#warning 这里用的是self, 因为self就是当前正在使用的导航控制器
    UINavigationController *nai = [[UINavigationController alloc]initWithRootViewController:[[YQLeftBarButtonItemTVC alloc]initWithStyle:UITableViewStylePlain]];
    
    [self presentViewController:nai animated:YES completion:nil];
}

- (void)clickRightBarButtonItem:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    [self spinButton:sender];
    
    [self popViewController];
}

- (void)spinButton:(UIButton *)sender{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    if (sender.selected) {
        anim.toValue = @(-M_PI_4);
    }else{
        anim.toValue = @(0);
    }
    anim.duration = 0.3;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [sender.layer addAnimation:anim forKey:nil];
}


- (void)popViewController{
    YQRightBarButtonItemTVC* transparentView = [[YQRightBarButtonItemTVC alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *nai = [[UINavigationController alloc]initWithRootViewController:transparentView];
    [self addChildViewController:nai];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.005;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    
    [transparentView.view.layer addAnimation:transition forKey:nil];
    
    [self.view addSubview:transparentView.view];
}


- (UIButton *)rightButton{
    
    if (_rightButton == nil) {
        _rightButton = [UIButton new];
    }
    return _rightButton;
}
@end

