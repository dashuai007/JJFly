//
//  JAAveragePriceLayer.h
//  JAKLine
//
//  Created by xiazhongchong on 30/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class JAKLineModel;

@interface JAAveragePriceLayer : CALayer

@property (nonatomic, assign) CGFloat h;

@property (nonatomic, assign) CGFloat lowerPrice;

@property (nonatomic, assign) CGFloat x_scale;

//传入现在点的下标 还有数组

- (void)loadPreLayer:(CGFloat)offsetX models:(NSMutableArray <JAKLineModel *> *)dataArray;

@end
