//
//  NSMutableArray+Category.m
//  My_iOS_Dev_Tools
//
//  Created by RenSihao on 16/7/11.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "NSMutableArray+Category.h"

@implementation NSMutableArray (Category)


- (void)lf_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)lf_removeLastObject {
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}

#pragma clang diagnostic pop


- (id)lf_popFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self lf_removeFirstObject];
    }
    return obj;
}

- (id)lf_popLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self removeLastObject];
    }
    return obj;
}

- (void)appendObject:(id)anObject {
    [self addObject:anObject];
}

- (void)lf_prependObject:(id)anObject {
    [self insertObject:anObject atIndex:0];
}

- (void)appendObjects:(NSArray *)objects {
    if (!objects) return;
    [self addObjectsFromArray:objects];
}

- (void)lf_prependObjects:(NSArray *)objects {
    if (!objects) return;
    NSUInteger i = 0;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)lf_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)lf_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)lf_shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}


- (void)lf_appendObject:(id)anObject
{
    if (anObject && ![anObject isKindOfClass:[NSNull class]]) {
        [self addObject:anObject];
    }
}

- (void)lf_appendObjects:(NSArray *)objects
{
    if (objects && [objects isKindOfClass:[NSArray class]]) {
        [self addObjectsFromArray:objects];
    }
}

@end
