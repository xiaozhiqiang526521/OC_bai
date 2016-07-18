//
//  XMGTopicPictureView.h
//  App百思不得姐
//
//  Created by garday on 16/6/25.
//  Copyright © 2016年 garday. All rights reserved.


    /***图片帖子中间的内容 ***/

#import <UIKit/UIKit.h>
@class XMGTopic;
@interface XMGTopicPictureView : UIView

+(instancetype)pictureView;

/***帖子数据 ***/
@property (nonatomic ,strong)XMGTopic *topic;
@end
