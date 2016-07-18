//
//  XMGTopic.m
//  App百思不得姐
//
//  Created by garday on 16/6/22.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGTopic.h"
#import "XMGComment.h"
#import "XMGUser.h"
#import <MJExtension.h>
@implementation XMGTopic

{
    CGFloat _cellHeight;
}

//你给我一个替换的key，来代替要换的key
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image":@"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2",
             };

}

+(NSDictionary *)objectClassInArray{
    return @{@"top_cmt" : @"XMGComment"};
}

-(NSString *)create_time
{
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //设置日期格式(y:年，M：月，d：日，H：时，m:分 ，s：秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) {//今年
        if (create.isToday) {//今天
            NSDateComponents *cmps = [[NSDate date]deltaFrom:create];
            if (cmps.hour >= 1) {//时间差距 >＝1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >=1){//1小时>时间差距>=1分钟
               return[NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{//1分钟 >时间差距
               return@"刚刚";
            }
        }else if (create.isYesterday){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }else{//其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
           return[fmt stringFromDate:create];
        }
    }else{//非今年
      return _create_time;
    }

}


-(CGFloat)cellHeight
{
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * XMGTopicCellMargin, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // cell的高度
        // 文字部分的高度
        _cellHeight = XMGTopicCellTextY + textH + XMGTopicCellMargin;
        
        // 根据段子的类型来计算cell的高度
        if (self.type == XMGTopicTypePicture) { // 图片帖子
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 显示显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= XMGTopicCellPictureMaxH) { // 图片高度过长
                pictureH = XMGTopicCellPictureBreakH;
                self.bigPicture = YES; // 大图
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = XMGTopicCellMargin;
            CGFloat pictureY = XMGTopicCellTextY + textH + XMGTopicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + XMGTopicCellMargin;
        } else if (self.type == XMGTopicTypeVoice) { // 声音帖子
            CGFloat voiceX = XMGTopicCellMargin;
            CGFloat voiceY = XMGTopicCellTextY + textH + XMGTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceViewFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + XMGTopicCellMargin;
        } else if (self.type == XMGTopicTypeVideo) { // 视频帖子
            CGFloat videoX = XMGTopicCellMargin;
            CGFloat videoY = XMGTopicCellTextY + textH + XMGTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + XMGTopicCellMargin;
        }
        
        // 如果有最热评论
        XMGComment *cmt = [self.top_cmt firstObject];
        if (cmt) {
              NSString *content = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            
//            XMGLog(@"%f", contentH);
            _cellHeight += XMGTopicCellTopCmtTitleH + contentH + XMGTopicCellMargin+10;
        }
        
        // 底部工具条的高度
        _cellHeight += XMGTopicBottomBarH + XMGTopicCellMargin;
    }
    return _cellHeight;

}
@end
