//
//  JAKLineView.m
//  JAKLine
//
//  Created by xiazhongchong on 30/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "JAKLineView.h"
#import "JAAveragePriceLayer.h"
#import "JAKLineModel.h"

static const NSInteger KlineCellSpace = 2;//cell间隔
static const NSInteger KlineCellWidth = 6;//cell宽度
static const NSInteger CellOffset = 3;//偏移的单位（速度）

static const CGFloat scale_Min = 0.1;//最小缩放量
static const CGFloat scale_Max = 1;//最大缩放量

@interface JAKLineView ()

@property (nonatomic, strong) CAShapeLayer *shapLayer;//super layer

@property (nonatomic, assign) NSInteger showMaxCount;//展示最大个数

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, strong) NSMutableArray <JAKLineModel *> *kLineModels;

@property (nonatomic, assign) CGFloat viewHeight;

@property (nonatomic, assign) CGFloat viewWidth;

@property (nonatomic, assign) CGFloat h;//view 每个点代表的高度

@property (nonatomic, assign) NSInteger maxCount;// show how much

@property (nonatomic, assign) NSInteger offsetIndex;//偏移量

@property (nonatomic, assign) CGFloat x_scale;//缩放比例

@property (nonatomic, strong) CAShapeLayer *trackingCrossLayer;//十字光标的layer层

@property (nonatomic, strong) UIColor *redColor;

@property (nonatomic, strong) UIColor *blueColor;

@property (nonatomic, strong) UIColor *whiteColor;

@property (nonatomic, strong) JAAveragePriceLayer *avLayer;//均线的


@end

@implementation JAKLineView

- (id)initWithFrame:(CGRect)frame delegate:(id<JAKLineDataSourceProtocol>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.avLayer = [JAAveragePriceLayer layer];
        [self.avLayer setFrame:frame];
        
        [self klineInit];
    }
    return self;
}

- (void)klineInit {
    self.kLineModels = [NSMutableArray array];
    
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:self.pan];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [self addGestureRecognizer:pinch];
    
    self.redColor = [UIColor redColor];
    self.blueColor = [UIColor blueColor];
    self.whiteColor = [UIColor whiteColor];
    
    
    [self reload];
}


- (void)reload {
    
}



- (void)pinchGesture:(UIPinchGestureRecognizer *)pinch {
    
}

- (void)panGesture:(UIPanGestureRecognizer *)pan {
    
}


- (void)calculationHighestLowest:(NSArray *)dataArray {
    _hightPrice = 0;
    _lowerPrice = 0;
    [dataArray enumerateObjectsUsingBlock:^(JAKLineModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat higher = MAX(obj.highest, obj.last);
        if (higher > self.hightPrice) {
            _hightPrice = higher;
        }
        
        if (self.lowerPrice == 0) {
            _lowerPrice = obj.lowest;
        }
        
        if (obj.lowest < self.lowerPrice || obj.last > self.lowerPrice) {
            if (obj.last > 0 && obj.lowest > 0) {
                _lowerPrice = MIN(obj.lowest, obj.last);
            }
        }
        
    }];
    
    _lowerPrice  *= 0.9996;
    _hightPrice *= 1.0004;
    
    [self caluculationH];
}


- (void)caluculationH {
    if ([self.delegate respondsToSelector:@selector(willRoad)]) {
        [self.delegate willRoad];
    }
    
    self.h = (self.hightPrice - self.lowerPrice) / self.viewHeight;
    
    
    
}

- (void)initShapeLayer {
    if (self.shapLayer) {
        [self.shapLayer removeFromSuperlayer];
        self.shapLayer = nil;
    }
    
    if (self.shapLayer == nil) {
        self.shapLayer = [CAShapeLayer layer];
        self.shapLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        
        self.shapLayer.strokeColor = [UIColor brownColor].CGColor;
        self.shapLayer.fillColor = [UIColor clearColor].CGColor;
        
    }
}

- (void)calculationTransform:(NSArray <JAKLineModel *>*)models {
    [self initShapeLayer];
    
    [models enumerateObjectsUsingBlock:^(JAKLineModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        
        
        
        
    }];
    
    
    
}


// made shapeLayer
- (CAShapeLayer *)transform:(JAKLineModel *)model index:(NSInteger)index {
    CGFloat open = (model.open - self.lowerPrice) / self.h;
    CGFloat settle = (model.settlementle - self.lowerPrice) / self.h;
    
    CGFloat x = (KlineCellSpace + KlineCellWidth) *index * self.x_scale;
    CGFloat y = open  > settle ? settle : open;
    
    //fabs 取整
    CGFloat height = MAX(fabs(settle - open), 1);
    
    CGRect rect = CGRectMake(x, y, KlineCellWidth * self.x_scale, height);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:rect];
#pragma mark - 线的宽度
    bezierPath.lineWidth = 1.0;
    
    [bezierPath moveToPoint:CGPointMake(x + KlineCellWidth / 2, y)];
    [bezierPath addLineToPoint:CGPointMake(x + KlineCellWidth / 2, (model.lowest - self.lowerPrice) / self.h)];
    
    [bezierPath moveToPoint:CGPointMake(x + KlineCellWidth  / 2, y + height)];
    [
    
    
    
    
    
}












@end












