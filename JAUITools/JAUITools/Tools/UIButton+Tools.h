//
//  UIButton+Tools.h
//  JAUITools
//
//  Created by xiazhongchong on 04/12/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Tools)

/**
 createButton
 @param corner 如果想要圆角 大于0 for则为o
 */
+ (UIButton *)createButtonWithRect:(CGRect)rect
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                            target:(id)target
                               sel:(SEL)selector
                             image:(UIImage *)image
                            corner:(CGFloat)corner;

@end
