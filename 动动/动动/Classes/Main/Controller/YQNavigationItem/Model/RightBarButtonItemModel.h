//
//  RightBarButtonItemModel.h
//  动动
//
//  Created by tarena on 16/10/27.
//  Copyright © 2016年 tad23. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RightBarButtonItemModel : NSObject

+(NSArray*)allLists;
/**
 *  title名字
 */
@property (nonatomic) NSString *name;
/**
 *  普通状态下的图片
 */
@property (nonatomic) NSString *normalImage;
/**
 *  高亮状态下的图片
 */
@property (nonatomic) NSString *highlightImage;

@end
