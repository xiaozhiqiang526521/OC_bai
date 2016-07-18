//
//  XMGProgressView.m
//  App百思不得姐
//
//  Created by garday on 16/6/27.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGProgressView.h"

@implementation XMGProgressView
-(void)awakeFromNib{
     self.roundedCorners = 2;//环形进度条的进度时是圆角
    self.progressLabel.textColor = [UIColor whiteColor];
}
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
     NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    text =
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];;
}

@end
