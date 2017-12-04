//
//  JAKineModel.h
//  JAKLine
//
//  Created by xiazhongchong on 30/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 KLIne 开盘价， 收盘价 最高价 最低价  ....
 */
@interface JAKLineModel : NSObject

@property (nonatomic, assign) float open;

@property (nonatomic, assign) float close;

@property (nonatomic, assign) float highest;

@property (nonatomic, assign) float lowest;

@property (nonatomic, assign) float last;

@property (nonatomic, assign) float settlementle;

@property (nonatomic, strong) NSMutableArray <JAKLineModel *> *parentKLineModels;

@property (nonatomic, strong) JAKLineModel *preKLineModel;

@property (nonatomic, assign) BOOL isFirstKLineModel;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *stockID;

@property (nonatomic, copy) NSString *change;

@property (nonatomic, copy) NSString *changePer;

@property (nonatomic, assign) float volume;

@property (nonatomic, assign) float position;

- (void)dataWithFile:(void(^)(NSArray *dataArray))block;
                      
@end
