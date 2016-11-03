//
//  YQNaviRightButton.m
//  动动
//
//  Created by tarena on 16/11/1.
//  Copyright © 2016年 tad23. All rights reserved.
//

#import "YQNaviRightButton.h"
#import "GPSSports.h"
#import "InputSports.h"
#import "InputWeight.h"



@interface YQNaviRightButton ()<CAAnimationDelegate>
@property (nonatomic) NSArray *array;
//显示的数量
@property (nonatomic) NSInteger displayNum;


@property (nonatomic) NSArray *titleName;

@end

@implementation YQNaviRightButton

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleName];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //默认显示数据
    _displayNum = 0;
    [self.tableView reloadData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    //定时器 .15秒钟 执行一次
    [NSTimer scheduledTimerWithTimeInterval:.15 target:self selector:@selector(insertNewRow:) userInfo:nil repeats:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
    
    NSArray *normalImage = @[@"dd_Activity_TrackExercise", @"dd_Activity_LogCardio", @"dd_Activity_LogWeight", @"dd_Activity_Wechat"];
    
    cell.textLabel.text = _titleName[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:normalImage[indexPath.row]];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIViewController *vc = [UIViewController new];
    switch (indexPath.row) {
        case 0:{
            UIStoryboard *GPSSportsSB = [UIStoryboard storyboardWithName:@"GPSSports" bundle:nil];
            
            vc = (GPSSports *)[GPSSportsSB instantiateInitialViewController];
            break;
        }
        case 1:
            vc = [[InputSports alloc]init];
            break;
        case 2:
            vc = [[InputWeight alloc]init];
            break;
        case 3:
            vc = [[GPSSports alloc]init];
            break;
    }
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"历史记录" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButtonItem:)];
    rightItem.tintColor = YQOrangeColor;
    vc.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButtonItem:)];
    leftItem.tintColor = YQOrangeColor;
    vc.navigationItem.leftBarButtonItem = leftItem;
    
    vc.title = _titleName[indexPath.row];
    navi.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationController.topViewController presentViewController:navi animated:YES completion:nil];
    NSArray *highlightImage = @[@"dd_Activity_TrackExercise_Highlight", @"dd_Activity_LogCardio_Highlight", @"dd_Activity_LogWeight_Highlight", @"dd_Activity_Wechat_Highlight"];
    cell.imageView.image = [UIImage imageNamed:highlightImage[indexPath.row]];
}

- (void)clickRightBarButtonItem:(UIBarButtonItem *)sender{
    
}

- (void)clickLeftBarButtonItem:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (NSArray *)titleName {
	if(_titleName == nil) {
		_titleName = [[NSArray alloc] init];
        _titleName = @[@"GPS运动",  @"路入运动", @"录入体重", @"微信排行榜"];
	}
	return _titleName;
}

@end





