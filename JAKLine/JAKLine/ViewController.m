//
//  ViewController.m
//  JAKLine
//
//  Created by xiazhongchong on 30/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "ViewController.h"
#import "JAKLineView.h"
#import "JAKLineModel.h"
@interface ViewController ()<JAKLineDataSourceProtocol>


@property (nonatomic, strong)NSArray *KlineModels;
@property (nonatomic, assign)NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    JAKLineModel *model = [JAKLineModel new];
    
    __weak ViewController *selfWeak = self;
    [model dataWithFile:^(NSArray *dataArray) {
        __strong ViewController *strongSelf = selfWeak;
        strongSelf.KlineModels = dataArray;
    }];
    
    JAKLineView *kline = [[JAKLineView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 300) delegate:self];
    
    kline.isShowTrackingCross = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        kline.isShowTrackingCross = NO;
    });
    
    [self.view addSubview:kline];
    
}

- (JAKLineModel *)lineView:(UIView *)view cellIndex:(NSInteger)index {
    return [self.KlineModels objectAtIndex:index];
}


- (NSInteger)numberOfView:(UIView *)view{
    return self.KlineModels.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
