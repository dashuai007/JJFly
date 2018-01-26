//
//  NewObject.m
//  JATangQiaoBook
//
//  Created by xiazhongchong on 26/01/2018.
//  Copyright © 2018 JJFly. All rights reserved.
//

#import "NewObject.h"

@interface NewObject () <NSCopying>

@end

@implementation NewObject


- (id)init {
    if (self) {
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    NewObject *ne = [[[self class] allocWithZone:zone] init];
    return ne;
}



@end
