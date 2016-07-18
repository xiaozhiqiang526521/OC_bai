//
//  XMGNavigationController.m
//  App百思不得姐
//
//  Created by garday on 16/6/15.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGNavigationController.h"

@implementation XMGNavigationController

//当第一次使用这个类的时候会调用一次
+(void)initialize
{
    //添加导航栏的背景图片
    //    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    //

    
    //当导航栏用在XMGNavigationController中，appearan设置才会生效
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



//可以在这个方法中拦截所有push进来的控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        //如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        
        //设置内边距
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;        //        [button sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //这句super的push要放在后面让viewcontroller可以覆盖上面设置的leftBarButtonItem
  [super pushViewController:viewController animated:animated];
    

}

-(void)back
{
    [self popViewControllerAnimated:YES];
}
@end
