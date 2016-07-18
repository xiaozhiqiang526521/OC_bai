//
//  UIBarButtonItem+XMGeXtension.m
//  App百思不得姐
//
//  Created by garday on 16/6/15.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "UIBarButtonItem+XMGeXtension.h"

@implementation UIBarButtonItem (XMGeXtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
     button.size = button.currentBackgroundImage.size;
    return [[self alloc]initWithCustomView:button];
}
@end
