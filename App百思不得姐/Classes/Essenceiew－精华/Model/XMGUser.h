//
//  XMGUser.h
//  App百思不得姐
//
//  Created by garday on 16/7/4.
//  Copyright © 2016年 garday. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGUser : NSObject
/***用户名 ***/
@property (nonatomic ,copy)NSString *username;
/***性别 ***/
@property (nonatomic ,copy)NSString *sex;
/***头像 ***/
@property (nonatomic ,copy)NSString *profile_image;
@end
