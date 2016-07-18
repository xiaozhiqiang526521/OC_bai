//
//  XMGRecommendCategory.m
//  App百思不得姐
//
//  Created by garday on 16/6/16.
//  Copyright © 2016年 garday. All rights reserved.
//


//推荐关注  左边的数据模型
#import "XMGRecommendCategory.h"
#import <MJExtension.h>
@implementation XMGRecommendCategory

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

-(NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
