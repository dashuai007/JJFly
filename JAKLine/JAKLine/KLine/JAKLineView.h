//
//  JAKLineView.h
//  JAKLine
//
//  Created by xiazhongchong on 30/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAKLineDataSourceProtocol.h"

@interface JAKLineView : UIView

@property (nonatomic, assign) id<JAKLineDataSourceProtocol>delegate;

@property (nonatomic, assign, readonly) CGFloat hightPrice;

@property (nonatomic, assign, readonly) CGFloat lowerPrice;

@property (nonatomic, assign, getter=isShowTrackingCross) BOOL isShowTrackingCross;
- (id)initWithFrame:(CGRect)frame delegate:(id<JAKLineDataSourceProtocol>)delegate;

- (void)reload;
- (void)replacementLastPoint:(JAKLineModel *)model;//替换最后一点 tcp数据跳动的时候可用

@end
