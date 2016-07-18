//
//  XMGTopicVoiceView.h
//  App百思不得姐
//
//  Created by garday on 16/6/30.
//  Copyright © 2016年 garday. All rights reserved.
//
        /***声音帖子中间的内容 ***/
#import <UIKit/UIKit.h>
@class XMGTopic;
@interface XMGTopicVoiceView : UIView

+(instancetype)voiceView;
/***帖子数据 ***/
@property (nonatomic ,strong)XMGTopic *topic;
@end
