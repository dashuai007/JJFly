//
//  UIButton+Tools.m
//  JAUITools
//
//  Created by xiazhongchong on 04/12/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "UIButton+Tools.h"

@implementation UIButton (Tools)

+ (UIButton *)createButtonWithRect:(CGRect)rect
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                            target:(id)target
                               sel:(SEL)selector
                             image:(UIImage *)image
                            corner:(CGFloat)corner {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (corner > 0) {
        button.layer.cornerRadius = corner;
        button.clipsToBounds = YES;
    }
    return button;
}

@end
