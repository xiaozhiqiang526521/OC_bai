//
//  NSDate+XMGExtension.m
//  App百思不得姐
//
//  Created by garday on 16/6/23.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "NSDate+XMGExtension.h"

@implementation NSDate (XMGExtension)

-(NSDateComponents *)deltaFrom:(NSDate *)from
{

    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear|NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];
}

//是否为今年
-(BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return  nowYear == selfYear;
}

//是否为今天
-(BOOL)isToday
{
    NSDateFormatter *fml = [[NSDateFormatter alloc]init];
    fml.dateFormat = @"yyyy-MM-dd";
    NSString *nowString = [fml stringFromDate:[NSDate date]];
    NSString *selfString = [fml stringFromDate:self];
    return [nowString isEqualToString:selfString];
    
}

//是否为昨天
-(BOOL)isYesterday
{//日期格式化类
    NSDateFormatter *fml = [[NSDateFormatter alloc]init];
    fml.dateFormat = @"yyyy-MM-dd";
    
    NSDate *now = [fml dateFromString:[fml stringFromDate:[NSDate date]]];
     NSDate *selfDate = [fml dateFromString:[fml stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *cmps =  [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth |NSCalendarUnitYear fromDate:selfDate toDate:now options:0];
    return cmps.year == 0 && cmps.month ==0 && cmps.day == 1;
}
@end
