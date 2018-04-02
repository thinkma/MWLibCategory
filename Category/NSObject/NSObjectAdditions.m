//
//  NSObjectAdditions.m
//  Satellite
//
//  Created by 李军 on 13-4-20.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "NSObjectAdditions.h"
#import <objc/runtime.h>

@implementation NSObject (Extends)

//把传进来的数据为NSNull的对象移除
+ (id)turnNullToNilForObject:(id)item
{
    if([item isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:item];
        for (NSString *key in [dic allKeys]) {
            id value = [dic objectForKey:key];
            id o = [self turnNullToNilForObject:value];
            if (o) {
                [dic setObject:o forKey:key];
            }
            else {
                [dic removeObjectForKey:key];
            }
        }
        return dic;
    }
    else if([item isKindOfClass:[NSArray class]]){
        NSMutableArray *arr= [NSMutableArray arrayWithArray:item];
        for (NSInteger i = [arr count]-1; i >= 0; i--) {
            id value = [arr objectAtIndex:i];
            id o = [self turnNullToNilForObject:value];
            if (o) {
                [arr replaceObjectAtIndex:i withObject:o];
            }
            else {
                [arr removeObjectAtIndex:i];
            }
        }
        return arr;
    }
    return [item nullTonil];
}
- (id)nullTonil
{
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return self;
}
- (id)objcetByRemoveNullObjects
{
    return [NSObject turnNullToNilForObject:self];
}
- (void)setArchiveredObject:(NSObject *)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:key ];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (id)archiveredObjectForKey:(NSString *)key
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
}

- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}



@end

@implementation NSObject (Nametags)

- (id)nametag
{
    return objc_getAssociatedObject(self, @selector(nametag));
}

- (void)setNametag:(NSString *)theNametag
{
    objc_setAssociatedObject(self, @selector(nametag), theNametag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}


- (NSString *)objectIdentifier
{
    return [NSString stringWithFormat:@"%@:0x%0x", self.class.description, (int)self];
}

- (void)removeitem:(NSString *)itme
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:itme];
    [defaults synchronize];
}


@end
