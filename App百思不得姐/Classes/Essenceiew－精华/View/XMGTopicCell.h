//
//  XMGTopicCell.h
//  App百思不得姐
//
//  Created by garday on 16/6/22.
//  Copyright © 2016年 garday. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGTopic;
@interface XMGTopicCell : UITableViewCell
/***帖子数据 ***/
@property (nonatomic ,strong)XMGTopic *topic;

+(instancetype)cell;
@end
