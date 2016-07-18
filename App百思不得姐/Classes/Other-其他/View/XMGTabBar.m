//
//  XMGTabBar.m
//  App百思不得姐
//
//  Created by garday on 16/6/15.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGTabBar.h"
#import "XMGPublishViewController.h"

@interface XMGTabBar()

//发布按钮
@property(nonatomic,strong)UIButton *publishButton;

@end

@implementation XMGTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //更换tabbar背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
      publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
  
    }
    return self;
}


-(void)publishClick{
    XMGPublishViewController *publish = [[XMGPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];

     }


-(void)layoutSubviews
{
    //系统布局完后再执行，覆盖之前的布局
    [super layoutSubviews];
   
    //设置发布按钮的frame
//    self.publishButton.width =self.publishButton.currentBackgroundImage.size.width;
//    self.publishButton.height =self.publishButton.currentBackgroundImage.size.height;
    CGFloat width = self.width;
    CGFloat height = self.height;
   self.publishButton.center = CGPointMake(width*0.5, height*0.5);
    
    //设置其他UITabBArButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width/5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        //第一种判断
//        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
        
        //第二种判断
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton)continue;
            //下面的判断因为添加一个加号按钮导致名称（例 关注）一个被占有，导致最后一个没有名称， 当索引>1，则在基础上加一；
        CGFloat buttonX = buttonW * ((index>1)?(index+1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //添加索引
        index++;
        
        }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
