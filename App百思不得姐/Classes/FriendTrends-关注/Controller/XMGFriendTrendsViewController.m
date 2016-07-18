//
//  XMGFriendTrendsViewController.m
//  App百思不得姐
//
//  Created by garday on 16/6/15.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGFriendTrendsViewController.h"
#import "XMGRecommendViewController.h"
#import "XMGLogRogisterViewController.h"

@interface XMGFriendTrendsViewController ()

@end

@implementation XMGFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self nva];
    
    // Do any additional setup after loading the view.
}
-(void)nva
{
     self.view.backgroundColor = XMGGlobalBg;
    //设置导航栏标题
   self.navigationItem.title = @"我的关注";
    //设置导航栏左边的按钮
    UIButton *friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [friendButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    [friendButton addTarget:self action:@selector(friendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    friendButton.size = friendButton.currentBackgroundImage.size;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendButtonClick)];
}

-(void)friendButtonClick
{
    XMGRecommendViewController *vc = [[XMGRecommendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)logRegister {
    XMGLogRogisterViewController *cv = [[XMGLogRogisterViewController alloc]init];
    [self presentViewController:cv animated:YES completion:nil];
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
