//
//  XMGTopicVideoView.h
//  App百思不得姐
//
//  Created by garday on 16/7/1.
//  Copyright © 2016年 garday. All rights reserved.
//


     /***视频帖子中间的内容 ***/
#import <UIKit/UIKit.h>
@class XMGTopic;

@interface XMGTopicVideoView : UIView
+(instancetype)videoView;
/***帖子数据 ***/
@property (nonatomic ,strong)XMGTopic *topic;
@end
