//
//  LXTNSDateFormat.m
//  LXTClientStudent
//
//  Created by weima on 2017/6/29.
//  Copyright © 2017年 mawei. All rights reserved.
//

#import "LXTNSDateFormat.h"
#import "NSDate+Extension.h"

@implementation LXTNSDateFormat


//09:00:00
+ (NSString *)getDataIntervalTime:(NSString *)currentTime
{
    NSTimeInterval time=[currentTime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSArray * dateArr = [[detaildate description] componentsSeparatedByString:@" "];
    NSString * dateString = [dateArr objectAtIndex:1];
//    NSLog(@"date:%@",[detaildate description]);
    NSArray * dateArrs = [[dateString description] componentsSeparatedByString:@":"];
    NSString * dateStrings = [NSString stringWithFormat:@"%@:%@",[dateArrs objectAtIndex:0],[dateArrs objectAtIndex:1]];
    return dateStrings;
}


//2017-06-30
+ (NSString *)getDataIntervalDate:(NSString *)currentTime
{
    NSTimeInterval time=[currentTime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSArray * dateArr = [[detaildate description] componentsSeparatedByString:@" "];
    NSString * dateString = [dateArr objectAtIndex:0];
   // NSLog(@"date:%@",[detaildate description]);
    return [LXTNSDateFormat dataWithString:dateString];;
}

+ (NSString *)dataWithString:(NSString *)dataString
{
   // NSLog(@"dataString = %@",dataString);
    NSDate * data = [NSDate dateWithString:dataString format:@"yyyy-MM-dd"];
   // NSLog(@"data = %@",data);
    NSString * week = [NSDate dayFromWeekday:data];
    //NSLog(@"week = %@",week);
    NSString * mounths = [NSDate stringWithDate:data format:@"MM月dd日"];
   // NSLog(@"mounths = %@",mounths);
    NSString *headdataString = [NSString stringWithFormat:@"%@(%@)",mounths,week];
    return headdataString;
    
}

+ (NSString *)gettimeStempTolesson:(NSString *)timetemp
{
    NSString * timeHs = [LXTNSDateFormat getDataIntervalTime:timetemp];
    NSTimeInterval time=[timetemp doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSArray * dateArr = [[detaildate description] componentsSeparatedByString:@" "];
    NSString * dateString = [dateArr objectAtIndex:0];
    NSDate * data = [NSDate dateWithString:dateString format:@"yyyy-MM-dd"];
    NSString * yesr = [NSDate stringWithDate:data format:@"yyyy-MM-dd"];
    return [NSString stringWithFormat:@"%@ %@",yesr,timeHs];
}


+ (NSString *)getDataIntervalMounth:(NSString *)currentTime
{
    NSTimeInterval time=[currentTime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSArray * dateArr = [[detaildate description] componentsSeparatedByString:@" "];
    NSString * dateString = [dateArr objectAtIndex:0];
    // NSLog(@"date:%@",[detaildate description]);
    return [LXTNSDateFormat dataWithStringWeek:dateString];;
}

+ (NSString *)dataWithStringWeek:(NSString *)dataString
{
    // NSLog(@"dataString = %@",dataString);
    NSDate * data = [NSDate dateWithString:dataString format:@"yyyy-MM-dd"];
    // NSLog(@"data = %@",data);
//    NSString * week = [NSDate dayFromWeekday:data];
    //NSLog(@"week = %@",week);
    NSString * mounths = [NSDate stringWithDate:data format:@"MM月dd日"];
    // NSLog(@"mounths = %@",mounths);
    return mounths;
    
}

+ (NSString *)brithdayString:(NSString *)timetmp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    //时间戳转换成时间
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[timetmp integerValue]];
    NSString *timeStr=[formatter stringFromDate:currentDate];
    return timeStr;
}



/**
 时间转化为时间戳
 */
+ (NSString *)getNSTimeIntervalTime:(NSDate *)date
{
    NSTimeInterval interval = [date timeIntervalSince1970];
    NSString * time = [NSString stringWithFormat:@"%.0f",interval];
    return time;
}







@end
