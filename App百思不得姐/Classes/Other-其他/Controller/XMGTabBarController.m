//
//  XMGTabBarController.m
//  App百思不得姐
//
//  Created by garday on 16/6/15.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGNewViewController.h"
#import "XMGVEssenceiewController.h"
#import "XMGMeViewController.h"
#import "XMGFriendTrendsViewController.h"
#import "XMGTabBar.h"
#import "XMGNavigationController.h"
@interface XMGTabBarController ()

@end

@implementation XMGTabBarController


//当第一次使用这个类的时候会调用一次
+(void)initialize
{
    //通过appearance统一设置所有UITabBarItem的所有文字属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一管理
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    attrs[NSBackgroundColorDocumentAttribute] = [UIColor cyanColor];
    NSMutableDictionary *selectedattrs = [NSMutableDictionary dictionary];
    selectedattrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedattrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedattrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}
-(void)setUI
{
  
    //添加子控制器
    
    
    
        //此方法为自定义，可以使图片保持默认图片颜色，不会被改成蓝色
    //UIImage *img = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    vc01.tabBarItem.selectedImage = img;
    
    //此方法为系统方法，会自动将tab图片染成蓝色
   // vc01.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    //第三种直接在Assets直接修改
    
    [self setupChildVc:[[XMGVEssenceiewController alloc]init]   title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[XMGNewViewController alloc]init]   title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[XMGFriendTrendsViewController alloc]init]   title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[XMGMeViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //更换taBar
    [self setValue:[[XMGTabBar alloc]init] forKeyPath:@"tabBar"];

    
}


//初始化子控制器
-(void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)img selectedImage:(NSString *)selectedImage
{
   //设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title=title;
    vc.tabBarItem.image = [UIImage imageNamed:img];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:vc];
    //包装一个导航控制器，添加导航控制器为tabbarcontroller的子控制器
  XMGNavigationController *nva = [[XMGNavigationController alloc]initWithRootViewController:vc];
    
   
    [self addChildViewController:nva];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
