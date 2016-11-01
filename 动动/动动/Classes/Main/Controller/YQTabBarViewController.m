//
//  YQTabBarViewController.m
//  动动
//
//  Created by tarena on 2016/10/18.
//  Copyright © 2016年 tad23. All rights reserved.
//

#import "YQTabBarViewController.h"
#import "YQProfileTVC.h"
#import "YQAnalyseTVC.h"
#import "YQRunVC.h"
#import "YQTargetTVC.h"
#import "YQGroupTVC.h"
#import "YQNavigationController.h"

#import "YQNaviRightButton.h"

@interface YQTabBarViewController () <CAAnimationDelegate>

@end

@implementation YQTabBarViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // 添加所有的子控制器
    [self addAllChildVcs];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:rightButton];
        rightButton.size = rightButton.currentBackgroundImage.size;
        [rightButton setImage:[UIImage imageWithMode:@"dd_Activity_add"] forState:UIControlStateNormal];
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-20);
            make.top.equalTo(30);
        }];
        [rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



- (void)clickRightButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    if (sender.selected) {
        anim.toValue = @(-M_PI_4);
        [self popViewController:sender];
    }else{
        anim.toValue = @(0);
        
        YQNaviRightButton *transparentView = [[YQNaviRightButton alloc]initWithStyle:UITableViewStylePlain];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.15;
        transition.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        transition.delegate = self;
        [transparentView.view.layer addAnimation:transition forKey:nil];
        [self.view removeFromSuperview];
        
//        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.viewControllers];
//        for (UIViewController *vc in array) {
//            if ([vc isKindOfClass:[YQNaviRightButton class]]) {
//                [array removeObject:vc];
//                break;
//            }
//        }
//        self.viewControllers = array;
        
        
        
        // 显示主控制器（HMTabBarController）
        YQTabBarViewController *vc = [[YQTabBarViewController alloc] init];
        
        // 切换控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
       window.rootViewController = vc;
        
        
    }
    anim.duration = 0.3;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [sender.layer addAnimation:anim forKey:nil];
}

- (void)popViewController:(UIButton *)sender{
    YQNaviRightButton *transparentView = [[YQNaviRightButton alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *nai = [[UINavigationController alloc]initWithRootViewController:transparentView];
    [self addChildViewController:nai];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.005;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    
    [transparentView.tableView.layer addAnimation:transition forKey:nil];
    
    [self.view addSubview:transparentView.tableView];
    [self.view addSubview:sender];
}



/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    UIStoryboard *pfStoryboard = [UIStoryboard storyboardWithName:@"YQProfile" bundle:nil];
    YQProfileTVC *profile = (YQProfileTVC*)[pfStoryboard instantiateInitialViewController];
    [self addOneChlildVc:profile title:@"我" imageName:@"dd_ImgTabBarMe" selectedImageName:@"dd_ImgTabBarMeSelected"];
    
    YQAnalyseTVC *analyse = [[YQAnalyseTVC alloc] init];
    [self addOneChlildVc:analyse title:@"分析" imageName:@"dd_ImgTabBarTrend" selectedImageName:@"dd_ImgTabBarTrendSelected"];
    
    YQRunVC *run = [[YQRunVC alloc] init];
    [self addOneChlildVc:run title:@"" imageName:@"dd_ImgTabBarActivity" selectedImageName:@"dd_ImgTabBarActivitySelected"];
    
    YQTargetTVC *target = [[YQTargetTVC alloc] init];
    [self addOneChlildVc:target title:@"目标" imageName:@"dd_imgTabBarGoalwhite" selectedImageName:@"dd_imgTabBarGoalyellow"];
    
    YQGroupTVC *group = [[YQGroupTVC alloc] init];
    [self addOneChlildVc:group title:@"群组" imageName:@"dd_ImgTabBarSocial" selectedImageName:@"dd_ImgTabBarSocialSelected"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */

- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题
    childVc.title = title;
    
    // 设置背景颜色
//    childVc.view.backgroundColor = YQBlackColor;
    
    // 设置普通图标
    childVc.tabBarItem.image = [UIImage imageWithMode:imageName];
    
    // 设置选中的图标
    childVc.tabBarItem.selectedImage = [UIImage imageWithMode:selectedImageName];
    
    //设置tabBar文字垂直和水平位置
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    // 设置tabBarItem的普通文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: YQOrangeColor} forState:UIControlStateSelected];
    
    // 添加为tabbar控制器的子控制器
    YQNavigationController *nav = [[YQNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
