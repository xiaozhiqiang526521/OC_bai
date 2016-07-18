//
//  XMGLogRogisterViewController.m
//  App百思不得姐
//
//  Created by garday on 16/6/20.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGLogRogisterViewController.h"

@interface XMGLogRogisterViewController ()
/** 登录框距离控制器view 左边的间距 **/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;


@end

@implementation XMGLogRogisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)button {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {//显示注册界面
        self.loginViewLeftMargin.constant = -self.view.width;
        button.selected = YES;
    }
    else{//显示登录界面
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }
         [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
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
