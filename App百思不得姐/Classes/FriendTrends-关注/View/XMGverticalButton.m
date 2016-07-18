//
//  XMGverticalButton.m
//  App百思不得姐
//
//  Created by garday on 16/6/20.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGverticalButton.h"

@implementation XMGverticalButton

//下面方法不管是用代码还是用xib创建都能实现，要加上下面所有代码
-(void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
/****************************        ------         *********************/


//只适用于xib
-(void)awakeFromNib
{
     [self setup];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    /**调整图片**/
    self.imageView.x = 0;
    self.imageView.y = 0;
    

    self.imageView.width = self.width;
    self.imageView.width = self.imageView.width;
    
    /**调整文字**/
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
