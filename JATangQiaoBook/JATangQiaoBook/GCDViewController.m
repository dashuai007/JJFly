//
//  GCDViewController.m
//  JATangQiaoBook
//
//  Created by xiazhongchong on 17/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()
{
    BtnBlock bloc;
}
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //声明Block
//    void(^delcarBlock)(void);
//    delcarBlock = ^{
//        NSLog(@"Hello Block");
//    };
//
//    delcarBlock();
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"text1" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 30);
    button.center = self.view.center;
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)clickBlock:(BtnBlock)block {
    
        
        bloc = block;
    
}

- (void)clickBtn:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"text1"]) {
        [btn setTitle:@"text2" forState:UIControlStateNormal];
//        if (self.block) {
//            self.block(@"text2");
//        }
        if (bloc) {
             bloc(@"text2");
        }
    } else {
        [btn setTitle:@"text1" forState:UIControlStateNormal];
//        if (self.block) {
//            self.block(@"text1");
//        }
        if (bloc) {
            bloc(@"text1");
        }
    }
}

- (void)gcd_exculute {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
    dispatch_group_async(dispatch_group_create(), dispatch_get_global_queue(0, 0), ^{
        
    });
    
}



@end
