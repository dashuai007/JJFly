//
//  JANavigationSubView.m
//  JANavigationScrollView
//
//  Created by xiazhongchong on 06/02/2018.
//  Copyright © 2018 esunny. All rights reserved.
//

#import "JANavigationSubView.h"

static const CGFloat kUIControlGap = 10;
static const NSTimeInterval kTimeInterval = 5;
static const CGFloat kFontSize = 19;
static const CGFloat kLabelGap = 30;

@interface JANavigationSubView ()

{
    CGFloat kBiggestWidth;
    CGFloat kScrollSizeInterval;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) NSTimer *scrollTimer;

@end

@implementation JANavigationSubView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        kBiggestWidth = 120;
        kScrollSizeInterval = 0;
    }
    return self;
}



- (void)autoScroll {
    if (ABS(self.scrollView.contentOffset.x - kScrollSizeInterval) < 10) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    [UIView animateWithDuration:kTimeInterval animations:^{
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + kScrollSizeInterval, 0);
    }];
}

- (void)changeContract:(NSString *)contractName {
    CGSize strSize = [contractName sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:kFontSize]}];
    if (strSize.width < kBiggestWidth) {
        self.scrollView.frame = CGRectMake(self.frame.size.width / 2 - strSize.width / 2, 0, strSize.width, self.frame.size.height);
        if (self.scrollView.subviews.count > 0) {
            for (UIView *view in _scrollView.subviews) {
                [view removeFromSuperview];
            }
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        label.text = contractName;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:kFontSize];
        [_scrollView addSubview:label];
        
        
        CGSize btnSize = self.leftBtn.frame.size;
        self.leftBtn.frame = CGRectMake(_scrollView.frame.origin.x - kUIControlGap - btnSize.width, self.bounds.size.height / 2 - btnSize.height / 2, btnSize.width, btnSize.height);
        self.rightBtn.frame = CGRectMake(_scrollView.frame.origin.x + kUIControlGap + _scrollView.bounds.size.width, self.bounds.size.height / 2 - btnSize.height / 2, btnSize.width, btnSize.height);
        
    } else {
        self.scrollView.frame = CGRectMake(self.frame.size.width / 2 - kBiggestWidth / 2, 0, kBiggestWidth, self.frame.size.height);
        _scrollView.contentSize = CGSizeMake(2 * strSize.width + kLabelGap, self.frame.size.height);
        if (_scrollView.subviews.count > 0) {
            for (UIView *view in _scrollView.subviews) {
                [view removeFromSuperview];
            }
        }
        
        for (int i = 0; i < 2; i++) {
            UILabel *label = [[UILabel alloc] init];
            if (i == 1) {
                label.frame = CGRectMake(strSize.width * i + kLabelGap, 0, strSize.width, self.frame.size.height);
            } else {
                label.frame = CGRectMake(strSize.width * i, 0, strSize.width, self.frame.size.height);
            }
            label.text = contractName;
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:kFontSize];
            [_scrollView addSubview:label];
            
        }
        
        CGSize btnSize = self.leftBtn.frame.size;
        self.leftBtn.frame = CGRectMake(_scrollView.frame.origin.x - kUIControlGap - btnSize.width, self.bounds.size.height / 2 - btnSize.height / 2, btnSize.width, btnSize.height);
        self.rightBtn.frame = CGRectMake(_scrollView.frame.origin.x + kUIControlGap + _scrollView.bounds.size.width, self.bounds.size.height / 2 - btnSize.height / 2, btnSize.width, btnSize.height);
        
        kScrollSizeInterval = strSize.width + kLabelGap;
        [self scrollTimer];
    }
}


- (void)tapBtn:(UIButton *)btn {
    if (btn == _leftBtn) {
        if (self.nextBlock) {
            self.nextBlock(NO);
        }
    } else {
        if (self.nextBlock) {
            self.nextBlock(YES);
        }
    }
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setBackgroundColor:[UIColor whiteColor]];
        [_leftBtn setTitle:@"left" forState:UIControlStateNormal];
        _leftBtn.frame = CGRectMake(0, 0, 6, 13);
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.frame = CGRectMake(0, 0, 6, 13);
        [_rightBtn setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (NSTimer *)scrollTimer {
    if (!_scrollTimer) {
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
        [_scrollTimer setFireDate:[NSDate date]];
    }
    return _scrollTimer;
}

@end
