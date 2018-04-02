//
//  LXTNSDateFormat.h
//  LXTClientStudent
//
//  Created by weima on 2017/6/29.
//  Copyright © 2017年 mawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTNSDateFormat : NSObject


/**
 时间戳改为time
 */
+ (NSString *)getDataIntervalTime:(NSString *)currentTime;


+ (NSString *)getDataIntervalDate:(NSString *)currentTime;

+ (NSString *)gettimeStempTolesson:(NSString *)timetemp;


/**
 通过时间戳获得 几月几号
 */
+ (NSString *)getDataIntervalMounth:(NSString *)currentTime;


+ (NSString *)brithdayString:(NSString *)timetmp;
/**
 时间转化为时间戳
 */
+ (NSString *)getNSTimeIntervalTime:(NSDate *)date;


@end
