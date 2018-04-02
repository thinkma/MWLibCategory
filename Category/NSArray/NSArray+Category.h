//
//  NSArray+Category.h
//  My_iOS_Dev_Tools
//
//  Created by RenSihao on 16/7/8.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  全部做了防止越界处理
 */
@interface NSArray (Category)

- (BOOL)isValidate;
- (id)firstObject;
- (id)lastObject;
- (id)objectAtIndexNotBeyond:(NSUInteger)index;


/// 随机返回一个对象 (如果Array空，则返回nil)
- (id)lf_randomObject;

/// 和 `objectAtIndex:` 类似，但超出范围不会抛异常
- (id)lf_objectOrNilAtIndex:(NSUInteger)index;

/// 编码为 json 字符串。 如果出错则返回nil。 内容支持NSString/NSNumber/NSDictionary/NSArray
- (NSString *)lf_jsonStringEncoded;

/// 编码为 json 字符串(带格式)。 如果出错则返回nil。 内容支持NSString/NSNumber/NSDictionary/NSArray
- (NSString *)lf_jsonPrettyStringEncoded;




@end
