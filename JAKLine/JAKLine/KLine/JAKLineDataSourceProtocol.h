//
//  JAKLineDataSourceProtocol.h
//  JAKLine
//
//  Created by xiazhongchong on 30/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import <Foundation/Foundation.h>


@class JAKLineModel;

@protocol JAKLineDataSourceProtocol <NSObject>

- (JAKLineModel *)lineView:(UIView *)view cellIndex:(NSInteger)index;

- (NSInteger)numberOfView:(UIView *)view;

@optional

- (void)trackingCross:(JAKLineModel *)kLineModel indexPoint:(CGPoint)point;

- (void)willRoad;

@end
