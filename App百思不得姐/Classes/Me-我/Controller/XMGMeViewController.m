//
//  XMGMeViewController.m
//  App百思不得姐
//
//  Created by garday on 16/6/15.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGMeViewController.h"
@interface XMGMeViewController ()

@end

@implementation XMGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self nva];
    // Do any additional setup after loading the view.
}
-(void)nva
{
     self.view.backgroundColor = XMGGlobalBg;
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    //设置导航栏左边的按钮
      UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];

    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
   
    self.navigationItem.rightBarButtonItems =@[settingItem,moonItem
                                              ];
}

-(void)settingClick
{
    XMGLogFunc;
}
-(void)moonClick
{
    XMGLogFunc;
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
