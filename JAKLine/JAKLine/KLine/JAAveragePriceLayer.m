//
//  JAAveragePriceLayer.m
//  JAKLine
//
//  Created by xiazhongchong on 30/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "JAAveragePriceLayer.h"
#import "JAKLineModel.h"
#import <UIKit/UIKit.h>

static NSString *const fiveColor = @"18c9f2";
static NSString *const TenColor  = @"ffe500";
static NSString *const TwentyColor  = @"dd3ddc";
static const NSInteger KlineCellSpace = 2;//cell间隔
static const NSInteger KlineCellWidth = 6;//cell宽度

static const NSInteger fiveLine = 4;
static const NSInteger tenLine  = 9;
static const NSInteger twentyLine = 19;

@interface JAAveragePriceLayer()

@property (nonatomic, strong)CAShapeLayer *fiveMinAP;
@property (nonatomic, strong)CAShapeLayer *TenMinAP;
@property (nonatomic, strong)CAShapeLayer *TwentyMinAP;

@end

@implementation JAAveragePriceLayer


- (void)loadPreLayer:(CGFloat)offsetX models:(NSMutableArray<JAKLineModel *> *)dataArray {
    __block CGFloat fiveLineFloat = 0;
    __block CGFloat tenLineFloat = 0;
    __block CGFloat twentyLineFloat = 0;
    
    __block NSInteger fiveInt = 0;
    __block NSInteger tenInt = 0;
    __block NSInteger twentyInt = 0;
    
    UIBezierPath *fBezier = [UIBezierPath bezierPath];
    UIBezierPath *tBezier = [UIBezierPath bezierPath];
    UIBezierPath *tDBezier = [UIBezierPath bezierPath];
    
    __block NSInteger lineSpace = KlineCellSpace + KlineCellWidth;
    __block NSInteger halfWidth = KlineCellWidth / 2;
    
    
    __block NSInteger startIndexFive = offsetX - fiveLine;
    __block NSInteger showIndexFive = 0;
    if (startIndexFive < fiveLine) {
        showIndexFive = -startIndexFive;
    }
    
    if (startIndexFive < 0) {
        startIndexFive = 0;
    }
    
    __block NSInteger starIndexTen = offsetX-tenLine;//开始展示的获取的数据下标
    __block NSInteger ShowIndexTen = 0;//开始展示的下标
    if (starIndexTen < tenLine) {
        ShowIndexTen = -starIndexTen;
    }
    if (starIndexTen < 0) {
        starIndexTen = 0;
    }
    
    //20个的均线
    __block NSInteger starIndexTwenry = offsetX- twentyLine;//开始展示的获取的数据下标
    __block NSInteger ShowIndexTwenry = 0;//开始展示的下标
    if (starIndexTwenry < twentyLine) {
        ShowIndexTwenry = -starIndexTwenry;
    }
    if (starIndexTwenry < 0) {
        starIndexTwenry = 0;
    }
    
    [dataArray enumerateObjectsUsingBlock:^(JAKLineModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //5的均线
        if (idx > startIndexFive) {
            fiveLineFloat += obj.last;
            fiveInt++;
            if (fiveInt >= 5) {
                CGFloat fivePrice_x = lineSpace * showIndexFive * self.x_scale + halfWidth;
                CGFloat fivePrice_y = (fiveLineFloat / 5 - self.lowerPrice) / self.h;
                CGPoint point = CGPointMake(fivePrice_x, fivePrice_y);
                if (fiveInt == 5) {
                    [fBezier moveToPoint:point];
                } else {
                    [fBezier addLineToPoint:point];
                }
                fiveLineFloat -= [dataArray objectAtIndex:idx - fiveLine].last;
                showIndexFive++;
            }
        }
        
        if (idx >= starIndexTen) {
            tenLineFloat += obj.last;
            tenInt ++;
            if (tenInt >= 10) {
                //下标开始的位置
                CGFloat TenPrice_x = lineSpace * ShowIndexTen*self.x_scale + halfWidth;
                
                CGFloat TenPrice_y = (tenLineFloat /10-self.lowerPrice)/self.h;
                
                CGPoint point = CGPointMake(TenPrice_x, TenPrice_y);
                
                if (tenInt == 10) {
                    [tBezier moveToPoint:point];
                }else{
                    [tBezier addLineToPoint:point];
                }
                tenLineFloat -= [[dataArray objectAtIndex:idx-tenLine] last];
                ShowIndexTen++;
            }
        }
        if (idx >= starIndexTwenry) {
            twentyLineFloat += obj.last;
            twentyInt ++;
            if (twentyInt >= 20) {
                //下标开始的位置
                CGFloat TwenryPrice_x = lineSpace*ShowIndexTwenry*self.x_scale+halfWidth;
                
                CGFloat TwenryPrice_y = (twentyLineFloat/20-self.lowerPrice)/self.h;
                
                CGPoint point = CGPointMake(TwenryPrice_x, TwenryPrice_y);
                
                if (twentyInt == 20) {
                    [tDBezier moveToPoint:point];
                }else{
                    [tDBezier addLineToPoint:point];
                }
                twentyLineFloat -= [[dataArray objectAtIndex:idx-twentyInt] last];
                ShowIndexTwenry ++;
            }
        }
        
    }];
        
    dispatch_async(dispatch_get_main_queue(), ^{
        self.fiveMinAP.path = fBezier.CGPath;
        self.TenMinAP.path = tBezier.CGPath;
        self.TwentyMinAP.path = tDBezier.CGPath;
        
        [fBezier removeAllPoints];
        [tBezier removeAllPoints];
        [tDBezier removeAllPoints];
    });
    
    
    
    
    
    
    
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (!_fiveMinAP) {
        _fiveMinAP = [CAShapeLayer layer];
        [_fiveMinAP setFrame:frame];
        _fiveMinAP.strokeColor = [UIColor cyanColor].CGColor;
        _fiveMinAP.fillColor = [UIColor clearColor].CGColor;
    }
    if (!_TenMinAP) {
        _TenMinAP = [CAShapeLayer layer];
        [_TenMinAP setFrame:frame];
        _TenMinAP.strokeColor = [UIColor yellowColor].CGColor;
        _TenMinAP.fillColor = [UIColor clearColor].CGColor;
    }
    if (!_TwentyMinAP) {
        _TwentyMinAP = [CAShapeLayer layer];
        [_TwentyMinAP setFrame:frame];
        _TwentyMinAP.strokeColor = [UIColor redColor].CGColor;
        _TwentyMinAP.fillColor = [UIColor clearColor].CGColor;
    }
}

- (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] <6) {
        
        return [UIColor clearColor];
        
    }
    
    // strip 0X if it appears
    
    if ([cString hasPrefix:@"0X"])
        
        cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"])
        
        cString = [cString substringFromIndex:1];
    
    if ([cString length] !=6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    
    range.location =0;
    
    range.length =2;
    
    
    NSString *rString = [cString substringWithRange:range];
    
    
    range.location =2;
    
    NSString *gString = [cString substringWithRange:range];
    
    
    range.location =4;
    
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r /255.0f) green:((float) g /255.0f) blue:((float) b /255.0f) alpha:1.0f];
}
@end









