//
//  XMGComment.h
//  App百思不得姐
//
//  Created by garday on 16/7/4.
//  Copyright © 2016年 garday. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGUser;
@interface XMGComment : NSObject
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) XMGUser *user;
@end
