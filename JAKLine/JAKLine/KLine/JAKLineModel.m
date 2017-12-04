//
//  JAKineModel.m
//  JAKLine
//
//  Created by xiazhongchong on 30/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "JAKLineModel.h"
#import "JAData.h"

@interface JAKLineModel () <JADataDelegate>

@property (nonatomic, copy) void (^dataBlock)(NSArray *dataArray);

@end

@implementation JAKLineModel

- (void)dataWithFile:(void (^)(NSArray *))block {
    self.dataBlock = block;
    JAData *data = [JAData new];
    [data dataAdd:self];
}

- (void)dataKLine:(NSArray *)array {
    NSMutableArray *dataArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dataArray addObject:[self mymodel:obj]];
    }];
    
}

- (JAKLineModel *)mymodel:(id)objc{
    JAKLineModel *model;
    if ([[objc class] isSubclassOfClass:[NSArray class]]){
        NSMutableArray *dataArray = objc;
        model = [[JAKLineModel alloc] init];
        model.last = [dataArray[1] floatValue];
        model.settlementle = [dataArray[3] floatValue];
        model.highest = [dataArray[4] floatValue];
        model.lowest = [dataArray[5] floatValue];
        model.open = [dataArray[6] floatValue];
    }
    return model;
}

@end
