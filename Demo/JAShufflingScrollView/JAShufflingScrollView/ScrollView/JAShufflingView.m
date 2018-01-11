//
//  JAShufflingView.m
//  JAShufflingScrollView
//
//  Created by xiazhongchong on 04/01/2018.
//  Copyright © 2018 JJFly. All rights reserved.
//

#import "JAShufflingView.h"

#define  kScreen_width self.bounds.size.width
#define  kScreen_height self.bounds.size.height
@interface JAShufflingView ()<UIScrollViewDelegate>

{
    NSTimer *timer;
    NSInteger currentPage;
    NSInteger totalPage;
}
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation JAShufflingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerScrollView) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        currentPage = 1;
        [self addSubView];
    }
    return self;
}

- (void)addSubView {
    
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_width * i, 0, self.bounds.size.width, self.bounds.size.height)];
        label.tag = 200 + i;
        if (i == 0) {
            label.backgroundColor = [UIColor orangeColor];
        } else if (i == 2) {
            label.backgroundColor = [UIColor cyanColor];
        } else {
            label.backgroundColor = [UIColor yellowColor];
        }
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"--";
        [self.scrollView addSubview:label];
    }
}

- (void)loadData:(NSInteger)totalNumber {
    self.pageControl.numberOfPages = totalNumber;
    totalPage = totalNumber;
    self.scrollView.contentSize = CGSizeMake(kScreen_width * 3, kScreen_height);
    [_scrollView setContentOffset:CGPointMake(kScreen_width, 0) animated:NO];
    [self scrollPage];
//    [timer fire];
    
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor blueColor];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreen_height - 30, kScreen_width, 20)];
        _pageControl.backgroundColor = [UIColor redColor];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (void)timerScrollView {
    currentPage++;
    if (currentPage > 5) {
        currentPage = 1;
    }
    [self.scrollView setContentOffset:CGPointMake(2 * kScreen_width, kScreen_height) animated:YES];
    _pageControl.currentPage = currentPage - 1;
    [self reloadData];
    
}

- (void)scrollPage {
    _pageControl.currentPage = currentPage - 1;
    [self reloadData];
}

- (void)reloadData {
    UILabel *left = [self.scrollView viewWithTag:200];
    UILabel *center = [self.scrollView viewWithTag:201];
    UILabel *right = [self.scrollView viewWithTag:202];
    if (currentPage == 1) {
        left.text = [NSString stringWithFormat:@"%ld", totalPage];
        right.text = [NSString stringWithFormat:@"%ld", currentPage + 1];
    } else if (currentPage == totalPage) {
        left.text = [NSString stringWithFormat:@"%ld", currentPage - 1];
        right.text = @"1";
    } else {
        left.text = [NSString stringWithFormat:@"%ld", currentPage - 1];
        right.text = [NSString stringWithFormat:@"%ld", currentPage + 1];
    }
    center.text = [NSString stringWithFormat:@"%ld", (long)currentPage];
    [self.scrollView setContentOffset:CGPointMake(kScreen_width, 0) animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
//    if (timer.isValid) {
//        return;
//    }
//    [timer invalidate];
    if (aScrollView.contentOffset.x == kScreen_width * 2) {
        if (currentPage == totalPage) {
            currentPage = 1;
        } else {
            currentPage++;
        }
        [self scrollPage];
    } else if (aScrollView.contentOffset.x == 0) {
        if (currentPage == 1) {
            currentPage = totalPage;
        } else {
            currentPage--;
        }
        [self scrollPage];
    }
//    [timer fire];
}


- (void)dealloc {
    [timer invalidate];
}

@end
