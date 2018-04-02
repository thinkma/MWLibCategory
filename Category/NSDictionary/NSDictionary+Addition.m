//
//  NSDictionary+Addition.m
//
//
//  Created by 马伟 on 15/5/18.
//  Copyright (c) 2015年 kongfanwu. All rights reserved.
//

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)

- (void)setValueReal:(id)value forKey:(NSString *)key
{
    if (value) {
        [self setValue:value forKey:key];
    }
}

- (id)objectForKeyReal:(NSString *)key
{
    
    if ([[self objectForKey:key] isEqual:[NSNull null]] || ![self objectForKey:key]) {
        return @"";
    }
    return [self objectForKey:key];
}

- (NSArray *)lf_allKeysSorted {
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSArray *)lf_allValuesSortedByKeys {
    NSArray *sortedKeys = [self lf_allKeysSorted];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return arr;
}

- (BOOL)lf_containsObjectForKey:(id)key {
    return [[self allKeys] containsObject:key];
}

- (NSDictionary *)lf_entriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = @{}.mutableCopy;
    for (id key in keys) {
        id value = self[key];
        if (value) dic[key] = value;
    }
    return dic;
}

- (NSString *)lf_jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (NSString *)lf_jsonPrettyStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}



@end

@implementation NSDictionary (Json)

- (BOOL)isSuccess
{
    NSString *result = [NSString stringWithFormat:@"%@", self[@"status"]];
    if ([result isEqualToString:@"200"]) return YES;
    return NO;
}


@end
