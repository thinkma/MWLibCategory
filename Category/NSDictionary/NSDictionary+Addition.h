//
//  NSDictionary+Addition.h
//  
//
//  Created by 马伟 on 15/5/18.
//  Copyright (c) 2015年 kongfanwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Addition)

- (void)setValueReal:(id)value forKey:(NSString *)key;

- (id)objectForKeyReal:(NSString *)key;


/// 返回所有key (按字典序排列)
- (NSArray *)lf_allKeysSorted;

/// 返回所有value (按key的字典序排列)
- (NSArray *)lf_allValuesSortedByKeys;


/// 是否包含 key
- (BOOL)lf_containsObjectForKey:(id)key;

/// 根据一组 key 来取对象
- (NSDictionary *)lf_entriesForKeys:(NSArray *)keys;

/// 编码为 json 字符串。 如果出错则返回nil。 内容支持NSString/NSNumber/NSDictionary/NSArray
- (NSString *)lf_jsonStringEncoded;

/// 编码为 json 字符串(带格式)。 如果出错则返回nil。 内容支持NSString/NSNumber/NSDictionary/NSArray
- (NSString *)lf_jsonPrettyStringEncoded;


@end

@interface NSDictionary (Json)



@end
