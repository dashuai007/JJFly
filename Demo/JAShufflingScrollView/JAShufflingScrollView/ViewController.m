//
//  ViewController.m
//  JAShufflingScrollView
//
//  Created by xiazhongchong on 04/01/2018.
//  Copyright © 2018 JJFly. All rights reserved.
//

#import "ViewController.h"
#import "JAShufflingView.h"
@interface ViewController ()
@property (nonatomic, strong) JAShufflingView *shufflingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.shufflingView loadData:5];
}

- (JAShufflingView *)shufflingView {
    if (!_shufflingView) {
        _shufflingView = [[JAShufflingView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 200)];
        [self.view addSubview:_shufflingView];
    }
    return _shufflingView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
