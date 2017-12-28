//
//  UILabel+Tools.m
//  JAUITools
//
//  Created by xiazhongchong on 04/12/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "UILabel+Tools.h"

@implementation UILabel (Tools)

void(^block)(void);

+ (UILabel *)createLabel:(CGRect)rect
               alignment:(NSTextAlignment)alignment
                    text:(NSString *)text
               textColor:(UIColor *)textColor
                    font:(CGFloat)fontSize
                 sizeFit:(BOOL)adjustsFontSize {
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    label.textAlignment = alignment;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.adjustsFontSizeToFitWidth = adjustsFontSize;
    return label;
}



+ (UILabel *)createLabel:(CGRect)rect
               alignment:(NSTextAlignment)alignment
                    text:(NSString *)text
               textColor:(UIColor *)textColor
                    font:(CGFloat)fontSize
                 sizeFit:(BOOL)adjustsFontSize
                     tap:(void(^)(void))tapBlock{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textAlignment = alignment;
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.userInteractionEnabled = YES;
    label.adjustsFontSizeToFitWidth = adjustsFontSize;
    block = tapBlock;
    
    return label;
}

+ (void)resetFontSize:(UILabel *)label
                 rect:(CGRect)rect
             fontSize:(CGFloat)fontSize {
    CGFloat retSize = fontSize;
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:@(fontSize)}];
    if (size.width > rect.size.width) {
        retSize--;
        if (retSize <= 13) {
            label.font = [UIFont systemFontOfSize:13];
            return;
        } else {
            [self resetFontSize:label rect:rect fontSize:retSize];
        }
    } else {
        label.font = [UIFont systemFontOfSize:retSize];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (block) {
        block();
    }
}

@end
