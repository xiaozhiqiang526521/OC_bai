//
//  XMGRecommendUser.h
//  App百思不得姐
//
//  Created by garday on 16/6/17.
//  Copyright © 2016年 garday. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommendUser : NSObject
/***头像 ***/
@property (nonatomic ,copy)NSString *header;
/***粉丝 ***/
@property (nonatomic ,assign)NSInteger fans_count;

@property (nonatomic ,copy)NSString *screen_name;

@end
