//
//  RightBarButtonItemModel.m
//  动动
//
//  Created by tarena on 16/10/27.
//  Copyright © 2016年 tad23. All rights reserved.
//

#import "RightBarButtonItemModel.h"

@implementation RightBarButtonItemModel

+ (NSArray *)allLists{
    NSMutableArray *model = [NSMutableArray array];
    
    //    1.生成plist文件的完整路径
    //[NSBundle mainBundle] 获取当前工程的主文件夹
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"YQRightBarButtonItem" ofType:@"plist"];
    //把plist中的数据取出
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dic in plistArray) {
        //每个字典对应创建一个对象 并用字典中的值给对象的属性赋值
        RightBarButtonItemModel *list = [[RightBarButtonItemModel alloc]init];
//                list.name = dic;
//                list.normalImage = dic;
        //        list.commentCount = [dic[@"commentCount"] integerValue];
        //KVC  Key Value Coding
        //会字典把所有的key逐个取出，然后用每个key的名字和对象的属性名字进行匹配，如果key和属性名称一样，就把value取出给该属性赋值
        [list setValuesForKeysWithDictionary:dic];

    
        
        
//        将列表添加到数组中
        [model addObject:list];
    }
    
    return model;
}


@end
