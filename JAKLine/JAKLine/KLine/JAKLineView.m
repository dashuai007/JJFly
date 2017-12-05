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

@property (nonatomic, assign) NSInteger ShowArrayMaxCount;//展示最大个数

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, strong) NSMutableArray <JAKLineModel *> *kLineModels;

@property (nonatomic, assign) CGFloat viewHeight;

@property (nonatomic, assign) CGFloat viewWidth;

@property (nonatomic, assign) CGFloat h;//view 每个点代表的高度

@property (nonatomic, assign) NSInteger count;// show how much

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
        self.avLayer.frame = self.bounds;
        
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
    if ([self.delegate respondsToSelector:@selector(numberOfView:)]) {
        self.ShowArrayMaxCount = [self.delegate numberOfView:self];
    }
    self.viewWidth = CGRectGetWidth(self.frame);
    self.viewHeight = CGRectGetHeight(self.frame);
    if (!self.x_scale) {
        self.x_scale = 1;
    }
    self.count = self.viewWidth / ((KlineCellSpace + KlineCellWidth) * self.x_scale);
    NSInteger index = self.ShowArrayMaxCount - _count;
    
    if (index < 0) {
        index = 0;
    }
    self.offsetIndex = index;
    
    [self offsetNormal];
    
}

- (void)offsetNormal {
    [self offset_xPoint:CGPointMake(0, 0)];
}


- (void)pinchGesture:(UIPinchGestureRecognizer *)pinch {
    @synchronized (self) {
        self.x_scale *= pinch.scale;
        if (_x_scale < scale_Min) {
            self.x_scale = scale_Min;
        } else if (_x_scale > scale_Max) {
            self.x_scale = scale_Max;
        }
    }
    [self reload];
}

- (void)panGesture:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:pan.view];
    if (self.isShowTrackingCross) {
        //显示十字光标
        if (pan.state == UIGestureRecognizerStateBegan) {
            [self tranckCrollFrom:point];
        } else if (pan.state == UIGestureRecognizerStateEnded) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3), dispatch_get_main_queue(), ^{
                self.isShowTrackingCross = NO;
            });
        } else {
            [self offset_xPoint:point];
        }
    }
}

- (void)offset_xPoint:(CGPoint)point {
    if ([self.delegate respondsToSelector:@selector(lineView:cellIndex:)]) {
        if (point.x < 0) {
            self.offsetIndex += CellOffset;
        } else if (point.x > 0){
            self.offsetIndex -= CellOffset;
        }
        if (self.offsetIndex < 0) {
            self.offsetIndex = 0;
        }
        if (self.offsetIndex > _ShowArrayMaxCount - _count) {
            self.offsetIndex = -_count + _ShowArrayMaxCount - 1;
        }
        
        NSInteger index = self.offsetIndex;
        if (index < 0) {
            index = 0;
        }
        
        @synchronized (self) {
            [self.kLineModels removeAllObjects];
            NSInteger count = MIN(_count, _ShowArrayMaxCount);
            for (NSInteger i = 0; i < count; i++, index++) {
                JAKLineModel *model = [self.delegate lineView:self cellIndex:index];
                if (model) {
                    [self.kLineModels addObject:model];
                }
            }
        }
        
        [self calculationHighestLowest:self.kLineModels];
        [self initAP];
    }
}

- (void)initAP {
    NSInteger apIndex = self.offsetIndex - 20;
    if (apIndex < 0) {
        apIndex = 0;
    }
    NSMutableArray *apModels = [NSMutableArray array];
    for (NSInteger i = apIndex; i < self.offsetIndex; i++) {
        [apModels addObject:[self.delegate lineView:self cellIndex:i]];
    }
    [apModels addObjectsFromArray:self.kLineModels];
    
    self.avLayer.x_scale = self.x_scale;
    self.avLayer.lowerPrice = self.lowerPrice;
    self.avLayer.h = self.h;
    [self.avLayer loadPreLayer:apModels.count - self.kLineModels.count models:apModels];
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
    [self calculationTransform:self.kLineModels];
    
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
       
        CAShapeLayer *layer = [self transform:obj index:idx];
        [self.shapLayer addSublayer:layer];
        
        
        
    }];
    [self.layer addSublayer:self.shapLayer];
    [self.layer addSublayer:self.avLayer];
    
    
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
    [bezierPath addLineToPoint:CGPointMake(x + KlineCellWidth / 2, (model.highest - self.lowerPrice) / self.h)];
    
    //生成Layer 用贝塞尔路径渲染
    
    CAShapeLayer *cellShapeLayer = [CAShapeLayer layer];
    cellShapeLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    cellShapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    if (model.open == model.settlementle) {
        cellShapeLayer.strokeColor = _whiteColor.CGColor;
    } else if (model.open > model.settlementle) {
        cellShapeLayer.strokeColor = _redColor.CGColor;
    } else {
        cellShapeLayer.fillColor = _blueColor.CGColor;
    }
    cellShapeLayer.path = bezierPath.CGPath;
    [bezierPath removeAllPoints];
    
    return cellShapeLayer;
    
    
    
    
}


- (void)tranckCrollFrom:(CGPoint)point {
    if (self.kLineModels.count == 0) {
        return;
    }
    NSInteger index = point.x / (KlineCellSpace + KlineCellWidth) * self.x_scale;
    if (index > self.kLineModels.count - 1) {
        index = self.kLineModels.count - 1;
    }
    if (index < 0) {
        return;
    }
    
    JAKLineModel *model = self.kLineModels[index];
    CGPoint point_x = CGPointMake(0, (model.last - self.lowerPrice) / self.h);
    CGPoint point_endx = CGPointMake(self.viewWidth, (model.last - self.lowerPrice) / self.h);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:point_x];
    [bezierPath addLineToPoint:point_endx];
    
    CGPoint point_y = CGPointMake(point.x, 0);
    CGPoint point_endY = CGPointMake(point.x, self.viewHeight);
    
    [bezierPath moveToPoint:point_y];
    [bezierPath addLineToPoint:point_endY];
    
    bezierPath.lineWidth = 0.75f;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineCapRound;
    
    self.trackingCrossLayer.path = nil;
    
    if (!self.trackingCrossLayer) {
        self.trackingCrossLayer = [CAShapeLayer layer];
        self.trackingCrossLayer.frame = CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        self.trackingCrossLayer.strokeColor = [UIColor colorWithRed:40/255.0 green:135/255.0 blue:255/255.0 alpha:1].CGColor;
        self.trackingCrossLayer.fillColor = [UIColor clearColor].CGColor;
    }
    self.trackingCrossLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:self.trackingCrossLayer];
    if ([self.delegate respondsToSelector:@selector(trackingCross:indexPoint:)]) {
        [self.delegate trackingCross:model indexPoint:CGPointMake(point_x.y, point_y.x)];
    }
    
}

- (void)setIsShowTrackingCross:(BOOL)isShowTrackingCross {
    _isShowTrackingCross = isShowTrackingCross;
    if (_isShowTrackingCross) {
        CGPoint center = self.center;
        [self tranckCrollFrom:center];
        if (self.trackingCrossLayer) {
            [self.trackingCrossLayer removeFromSuperlayer];
        }
    }
}

- (void)replacementLastPoint:(JAKLineModel *)model {
    if (self.shapLayer) {
        NSArray *array = self.shapLayer.sublayers;
        if (array) {
            if (array.count > 0) {
                CAShapeLayer *layer = (CAShapeLayer *)[self.shapLayer.sublayers lastObject];
                [layer removeFromSuperlayer];
            }
        }
    } else {
        [self initShapeLayer];
    }
    
    CAShapeLayer *layer = [self transform:model index:[self.kLineModels count] - 1];
    [self.shapLayer addSublayer:layer];
    
}



@end












