//
//  GPSSports.m
//  动动
//
//  Created by tarena on 16/11/1.
//  Copyright © 2016年 tad23. All rights reserved.
//

#import "GPSSports.h"

@import MapKit;
@import CoreLocation;
#define ButtonWidth (self.tableView.bounds.size.width - 2 * 15 - 20) / 2

@interface GPSSports ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *hookLB1;
@property (weak, nonatomic) IBOutlet UILabel *titleLB1;
@property (weak, nonatomic) IBOutlet UIImageView *hookLB2;
@property (weak, nonatomic) IBOutlet UILabel *titleLB2;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationManager *mgr;
@end

@implementation GPSSports

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showMap];
    
    [self addButton];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
}


#pragma mark 添加地图上的按钮
- (void)addButton{
    //导航栏上的音乐按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"dd_music_icon" highImageName:nil target:self action:@selector(clickLeftBarButtonItem:)];
    
    //返回原点按钮
    UIButton *backOrigin = [UIButton buttonWithType:UIButtonTypeSystem];
    backOrigin.size = backOrigin.currentBackgroundImage.size;
    [_mapView addSubview:backOrigin];
    [backOrigin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.right.equalTo(-10);
    }];
    [backOrigin setImage:[UIImage imageWithMode:@"dd_gps_back_to_user_location"] forState:UIControlStateNormal];
    [backOrigin addTarget:self action:@selector(backOriginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //开始按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_mapView addSubview:startButton];
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.bottom.equalTo(-20);
        make.height.equalTo(40);
        make.width.equalTo(ButtonWidth);
    }];
    startButton.backgroundColor = YQOrangeColor;
    [startButton setTitleColor:YQBlackColor forState:UIControlStateNormal];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    {
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_mapView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.height.width.equalTo(startButton);
        make.left.equalTo(startButton.mas_right).equalTo(20);
        
    }];
    backButton.backgroundColor = [UIColor grayColor];
    [backButton setTitleColor:YQBlackColor forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)clickLeftBarButtonItem:(UIBarButtonItem *)sender{
    
    
}

- (void)backOriginClick:(UIButton *)sender{
    //2.设置范围的属性
    //2.1 获取坐标
    CLLocationCoordinate2D coordinate = self.mapView.userLocation.coordinate;
    
    //2.2 设置范围 --> 为了跟系统默认的跨度保持一致，我们可以打印region的span值来获取，然后设置即可
    MKCoordinateSpan span = MKCoordinateSpanMake(0.021705, 0.013733);
    
    //2.3 设置范围属性
    //    self.mapView.region = MKCoordinateRegionMake(coordinate, span);
    
    [self.mapView setRegion:MKCoordinateRegionMake(coordinate, span) animated:YES];
}

/**
 *  当地图显示区域发生改变后，调用的方法
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    //获取默认的显示大小 -->span
    NSLog(@"latitudeDelta : %f, longitudeDelta : %f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
}

- (void)startClick:(UIButton *)sender{
    
}

- (void)backClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 地图
- (void)showMap{
    _mgr = [CLLocationManager new];
    
    
    if ([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.mgr requestAlwaysAuthorization];
    }
    
    self.mapView.height = self.tableView.bounds.size.height - 70 - 90 * 2 - 64;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.mapView.delegate = self;
    self.mapView.showsTraffic = YES;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
}




#pragma mark UITabViewDelegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",indexPath.row);
    
    if (indexPath.row == 1) {
        _hookLB1.image = [UIImage imageWithMode:@"dd_gps_selection_on"];
        _titleLB1.font = [UIFont systemFontOfSize:20];
    }else{
        _hookLB1.image = [UIImage imageWithMode:@"dd_gps_selection_off"];
        _titleLB1.font = [UIFont systemFontOfSize:17];
    }
    
    if (indexPath.row == 2) {
        _hookLB2.image = [UIImage imageWithMode:@"dd_gps_selection_on"];
        _titleLB2.font = [UIFont systemFontOfSize:20];
    }else{
        _hookLB2.image = [UIImage imageWithMode:@"dd_gps_selection_off"];
        _titleLB2.font = [UIFont systemFontOfSize:17];
    }
}
@end
