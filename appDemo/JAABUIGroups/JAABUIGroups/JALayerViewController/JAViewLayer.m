//
//  JAViewLayer.m
//  JAABUIGroups
//
//  Created by xiazhongchong on 08/12/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "JAViewLayer.h"

@implementation JAViewLayer


/**
 CAShapeLayer 是一个用矢量图绘制自身的图层子类，制定颜色和线条粗细等属性，使用CGPath制定想要的形状，然后CAShapeLayer会自动渲染。当软也可以用core graphics在一个浦东的CALayer直接向内容里绘制路径
    优点：快，使用硬件加速，比用core graphics绘制图像快很多
    高效内存：并不需要像正常CALayer那样创建主图像，所以无论它多大都不需要消耗过多内存
    不会被图层便捷裁剪--可以自由的画在边界之外，它并不会像你使用core graphics绘制在普通CALyer路径中被裁剪
    不会像素化--当你放大一个CAShapeLayer或者用3D透视变形将其拉近镜头，他并不会像普通图层主图像一样像素化
 
    可以CAShapeLayer绘画圆角 我们可以使用我们的CAShapeLayer作为视图的主视图mask属性，而不是添加为子图层
 */
- (void)caShapeLayer {
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //路径不一定是连续的 strokeColor fillColor lineWidth lineCap线两端 lineJoin线连接处
//    先创建UIBezierPath
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    shapeLayer.path = bezier.CGPath;
    [shapeLayer setFrame:self.frame];
    [self.layer addSublayer:shapeLayer];
    
    //圆角最终版
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectZero byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)].CGPath;
    /*
     CAShapeLayer *shapeLayer = [CAShapeLayer layer];
     shapeLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
     UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width, rect.size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)];
     shapeLayer.lineWidth = 1.0f;
     shapeLayer.fillColor = [UIColor whiteColor].CGColor;
     shapeLayer.path = path.CGPath;
     if (image) {
     shapeLayer.contents = (__bridge id _Nullable)(image.CGImage);
     }
     [imageView.layer addSublayer:shapeLayer];
     */
    view.layer.mask = shapeLayer;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
