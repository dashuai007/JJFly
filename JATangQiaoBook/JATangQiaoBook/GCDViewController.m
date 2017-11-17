//
//  GCDViewController.m
//  JATangQiaoBook
//
//  Created by xiazhongchong on 17/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //声明Block
    void(^delcarBlock)(void);
    delcarBlock = ^{
        NSLog(@"Hello Block");
    };
    
    delcarBlock();
    
    
}

- (void)gcd_exculute {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
    dispatch_group_async(dispatch_group_create(), dispatch_get_global_queue(0, 0), ^{
        
    });
    
}



@end
