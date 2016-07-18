//
//  XMGTopicController.h
//  App百思不得姐
//
//  Created by garday on 16/6/23.
//  Copyright © 2016年 garday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGTopicController : UITableViewController
/***帖子类型(交给子类去实现) ***/
@property (nonatomic ,assign)XMGTopicType type;
@end
