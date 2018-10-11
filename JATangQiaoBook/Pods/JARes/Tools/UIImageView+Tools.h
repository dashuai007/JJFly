//
//  UIImageView+Tools.h
//  JAUITools
//
//  Created by xiazhongchong on 04/12/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Tools)
+ (UIImageView *)createImageView:(CGRect)rect
                           image:(UIImage *)image
                        isCorner:(CGFloat)corner;

+ (UIImageView *)createImageView:(CGRect)rect
                           image:(UIImage *)image
                        isCorner:(CGFloat)corner
                             tap:(void(^)(void))tapBlock;
@end

