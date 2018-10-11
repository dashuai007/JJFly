//
//  UILabel+Tools.h
//  JAUITools
//
//  Created by xiazhongchong on 04/12/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Tools)
/**
 class method
 
 @param rect label.frame
 @param alignment textAlignment
 @param text string
 @param textColor color
 @param fontSize size
 @param adjustsFontSize yes
 @return label
 */
+ (UILabel *)createLabel:(CGRect)rect
               alignment:(NSTextAlignment)alignment
                    text:(NSString *)text
               textColor:(UIColor *)textColor
                    font:(CGFloat)fontSize
                 sizeFit:(BOOL)adjustsFontSize;

+ (UILabel *)createLabel:(CGRect)rect
               alignment:(NSTextAlignment)alignment
                    text:(NSString *)text
               textColor:(UIColor *)textColor
                    font:(CGFloat)fontSize
                 sizeFit:(BOOL)adjustsFontSize
                     tap:(void(^)(void))tapBlock;

+ (void)resetFontSize:(UILabel *)label
                 rect:(CGRect)rect
             fontSize:(CGFloat)fontSize;
@end
