//
//  XMGPushGuideView.m
//  App百思不得姐
//
//  Created by garday on 16/6/20.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGPushGuideView.h"

@implementation XMGPushGuideView

+(void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    //获得当前软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    //获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        XMGPushGuideView *guideView =[XMGPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        //马上存储
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

}
+(instancetype)guideView
{
    return [[[NSBundle  mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}



@end
