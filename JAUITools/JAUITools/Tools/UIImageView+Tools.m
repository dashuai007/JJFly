//
//  UIImageView+Tools.m
//  JAUITools
//
//  Created by xiazhongchong on 04/12/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "UIImageView+Tools.h"

@implementation UIImageView (Tools)

void(^tapImageView)(void);

+ (UIImageView *)createImageView:(CGRect)rect
                           image:(UIImage *)image
                        isCorner:(CGFloat)corner {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.userInteractionEnabled = YES;
    if (corner > 0) {
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
        
    }
    imageView.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeCenter;
    return imageView;
}

+ (UIImageView *)createImageView:(CGRect)rect
                           image:(UIImage *)image
                        isCorner:(CGFloat)corner
                             tap:(void(^)(void))tapBlock {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.userInteractionEnabled = YES;
    tapImageView = tapBlock;
    if (corner > 0) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width, rect.size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)];
        shapeLayer.lineWidth = 1.0f;
        shapeLayer.fillColor = [UIColor redColor].CGColor;
        shapeLayer.path = path.CGPath;
        if (image) {
            shapeLayer.contents = (__bridge id _Nullable)(image.CGImage);
        }
        [imageView.layer addSublayer:shapeLayer];
        
    }
    imageView.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeCenter;
    return imageView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (tapImageView) {
        tapImageView();
    }
}

@end

