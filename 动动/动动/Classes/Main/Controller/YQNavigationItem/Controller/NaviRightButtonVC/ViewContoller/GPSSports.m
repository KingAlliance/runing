//
//  GPSSports.m
//  动动
//
//  Created by tarena on 16/11/1.
//  Copyright © 2016年 tad23. All rights reserved.
//

#import "GPSSports.h"

@interface GPSSports ()
@property (weak, nonatomic) IBOutlet UIImageView *hookLB1;
@property (weak, nonatomic) IBOutlet UILabel *titleLB1;
@property (weak, nonatomic) IBOutlet UIImageView *hookLB2;
@property (weak, nonatomic) IBOutlet UILabel *titleLB2;

@end

@implementation GPSSports

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"dd_music_icon" highImageName:nil target:self action:@selector(clickLeftBarButtonItem:)];
    
    
}

- (void)clickLeftBarButtonItem:(UIBarButtonItem *)sender{


}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
