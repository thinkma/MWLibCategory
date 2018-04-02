//
//  NSArray+Category.m
//  My_iOS_Dev_Tools
//
//  Created by RenSihao on 16/7/8.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)

static BOOL IsNullOrNil(id value)
{
    if ([value isKindOfClass:[NSNull class]] || value ==nil || [value isEqual:[NSNull null]] || value == NULL)
    {
        return YES;
    }
    return NO;
}

- (BOOL)isValidate
{
    if (self.count >0 && [self isKindOfClass:[NSArray class]])
    {
        return YES;
    }
    
    if (IsNullOrNil(self))
    {
        return NO;
    }
    
    return NO;
}





- (id)firstObject
{
    if (self.count > 0)
    {
        return [self objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

- (id)lastObject
{
    if (self.count > 0)
    {
        return [self objectAtIndex:self.count-1];
    }
    else
    {
        return nil;
    }
}
- (id)objectAtIndexNotBeyond:(NSUInteger)index
{
    if (self.count  > index)
    {
        return [self objectAtIndex:index];
    }
    else
    {
        return nil;
    }
}


- (id)lf_randomObject {
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (id)lf_objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
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
