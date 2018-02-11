//
//  ViewController.m
//  JANavigationScrollView
//
//  Created by xiazhongchong on 06/02/2018.
//  Copyright © 2018 esunny. All rights reserved.
//

#import "ViewController.h"
#import "JANavigationSubView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JANavigationSubView *navi = [[JANavigationSubView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 160, 40)];
    navi.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = navi;
    navi.nextBlock = ^(BOOL isNext) {
        
    };
    [navi changeContract:@"ZCEContractCF8011"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
