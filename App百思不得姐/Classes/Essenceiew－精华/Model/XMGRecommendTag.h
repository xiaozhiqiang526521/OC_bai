//
//  XMGRecommendTag.h
//  App百思不得姐
//
//  Created by garday on 16/6/18.
//  Copyright © 2016年 garday. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommendTag : NSObject
/***图片 ***/
@property (nonatomic ,copy)NSString *image_list;

/***名字 ***/
@property (nonatomic ,copy)NSString *theme_name;

/***订阅数 ***/
@property (nonatomic ,assign)NSInteger sub_number;
@end
