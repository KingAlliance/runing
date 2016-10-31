//
//  YQRightBarButtonItemTVC.m
//  动动
//
//  Created by tarena on 2016/10/22.
//  Copyright © 2016年 tad23. All rights reserved.
//

#import "YQRightBarButtonItemTVC.h"
#import "YQ11ViewController.h"

@interface YQRightBarButtonItemTVC ()<CAAnimationDelegate,UIGestureRecognizerDelegate>
@property (nonatomic) NSArray *array;
//显示的数量
@property (nonatomic) NSInteger displayNum;

@property (nonatomic) UITapGestureRecognizer *tap;

@end

@implementation YQRightBarButtonItemTVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([NSStringFromClass([gestureRecognizer class]) isEqualToString:@"UITapGestureRecognizer"] && [NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    
//     _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(top)];
//    [self.tableView addGestureRecognizer:_tap];
//    _tap.delegate = self;
    
    //默认显示数据
    _displayNum = 0;
    [self.tableView reloadData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    //定时器 .15秒钟 执行一次
    [NSTimer scheduledTimerWithTimeInterval:.15 target:self selector:@selector(insertNewRow:) userInfo:nil repeats:YES];
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self top];
}

- (void)top{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.9;
    transition.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    transition.type = @"pageCurl";
    transition.subtype = kCATransitionFromLeft;
    transition.delegate = self;
    
    [self.view.superview.layer addAnimation:transition forKey:@"animation"];
    
    [self.view removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
    
}


- (void)insertNewRow:(NSTimer *)timer{
    _displayNum++;
    //如果已经把所有的cell都显示 了, 则关闭定时器
    if (_displayNum == 4) {
        [timer invalidate];
    }
    //动画方式 在tableView上一行行插入
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_displayNum -1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _displayNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *title = @[@"GPS运动",  @"路入运动", @"录入体重", @"微信排行榜"];
    NSArray *normalImage = @[@"dd_Activity_TrackExercise", @"dd_Activity_LogCardio", @"dd_Activity_LogWeight", @"dd_Activity_Wechat"];
   
    cell.textLabel.text = title[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:normalImage[indexPath.row]];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = YQOrangeColor;
    if (indexPath.row == 0) {
        [self presentViewController:[YQ11ViewController new] animated:YES completion:nil];
    }
    
     NSArray *highlightImage = @[@"dd_Activity_TrackExercise_Highlight", @"dd_Activity_LogCardio_Highlight", @"dd_Activity_LogWeight_Highlight", @"dd_Activity_Wechat_Highlight"];
    cell.imageView.image = [UIImage imageNamed:highlightImage[indexPath.row]];
}

@end
