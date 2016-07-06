//
//  ViewController.m
//  MasonryDemo
//
//  Created by John on 7/6/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self centerView];
    
    [self mas_scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - center view
- (void)centerView {
    WS(ws);
    
    UIView *sv = [UIView new];
    sv.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(350, 350));
    }];
    
    
    int padding = 10;
    UIView *sv1 = [UIView new];
    [self.view addSubview:sv1];
    sv1.backgroundColor = [UIColor redColor];
    
    UIView *sv2 = [UIView new];
    [self.view addSubview:sv2];
    sv2.backgroundColor = [UIColor redColor];
    
    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sv.mas_left).with.offset(padding);
        make.right.equalTo(sv2.mas_left).with.offset(-padding);
        make.centerY.equalTo(sv.mas_centerY);
        make.width.equalTo(sv2);
        make.height.mas_equalTo(@150);
    }];
    
    [sv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sv1.mas_right).with.offset(padding);
        make.right.equalTo(sv.mas_right).with.offset(-padding);
        make.centerY.equalTo(sv.mas_centerY);
        make.width.equalTo(sv1);
        make.height.mas_equalTo(@150);
    }];
    
}

- (void)mas_scrollView {
    WS(ws);
    
    UIView *sv = [UIView new];
    sv.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(350, 350));
    }];
    
    UIScrollView *scrollView = [UIScrollView new];
    [sv addSubview:scrollView];
    scrollView.backgroundColor = [UIColor whiteColor];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    UIView *contrainView = [UIView new];
    [scrollView addSubview:contrainView];
    
    [contrainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    int count = 10;
    UIView *lastView = nil;
    for (int i = 0; i < count; i++) {
        UIView *view = [UIView new];
        [contrainView addSubview:view];
        view.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(contrainView);
            make.height.mas_equalTo(@(20 * i));
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            } else {
                make.top.mas_equalTo(contrainView.mas_top);
            }
        }];
        lastView = view;
    }
    [contrainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    
}

@end
