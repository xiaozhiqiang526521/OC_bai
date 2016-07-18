//
//  XMGTextField.m
//  App百思不得姐
//
//  Created by garday on 16/6/20.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGTextField.h"
#import <objc/runtime.h>

static NSString *const XMGPlacerholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation XMGTextField

//-(void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:rect withAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
//}


/**
 运行时（Runtime）:
 ＊苹果官方一套c语言库
 ＊能做很多底层操作（比如访问隐藏的一些成员变量／成员方法...）
 **/
//+(void)initialize
//{
//    unsigned int count = 0;
//    
//    //拷贝出所有的成员变量列表
//   Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        //取出成员变量
//     Ivar ivar =  *(ivars + i);
//        //打印成员变量名字
//        XMGLog(@"%s",ivar_getName(ivar));
//        
//    }
//    /**释放**/
//    free(ivars);
//}


-(void)awakeFromNib
{
    
    //设置光标颜色和文字颜色一致
    self.tintColor  = self.textColor;
    
    //不成为第一响应者
    [self resignFirstResponder];
}

//当前文本框聚焦时就会调用
-(BOOL)becomeFirstResponder
{
    [self setValue:self.textColor   forKeyPath:XMGPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

//当前文本框失去焦点时就会调用
-(BOOL)resignFirstResponder
{
   [self setValue:[UIColor grayColor] forKeyPath:XMGPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}
@end
