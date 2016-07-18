//
//  XMGRecommendCategory.h
//  App百思不得姐
//
//  Created by garday on 16/6/16.
//  Copyright © 2016年 garday. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommendCategory : NSObject
/***id ***/
@property (nonatomic ,assign)NSUInteger ID;
/***总数 ***/
@property (nonatomic ,assign)NSInteger count;
/***名字 ***/
@property (nonatomic ,assign)NSString *name;

/**这个类别对应的数据**/
@property (nonatomic ,strong)NSMutableArray *users;

/***page总数 ***/
@property (nonatomic ,assign)NSInteger total;
/*** 当前页码 ***/
@property (nonatomic ,assign)NSInteger currentPage;

@end
