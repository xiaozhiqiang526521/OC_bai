//
//  UIBarButtonItem+XMGeXtension.h
//  App百思不得姐
//
//  Created by garday on 16/6/15.
//  Copyright © 2016年 garday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XMGeXtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
