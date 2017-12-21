//
//  ViewController.m
//  JAUITools
//
//  Created by xiazhongchong on 04/12/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+Tools.h"
#import "UIButton+Tools.h"
#import "UIImageView+Tools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UILabel *label = [UILabel createLabel:CGRectMake(100, 200, 100, 40) alignment:NSTextAlignmentLeft text:@"100" textColor:[UIColor redColor] font:12 sizeFit:YES tap:^{
        self.view.backgroundColor = [UIColor orangeColor];
    }];
    label.backgroundColor = [UIColor blueColor];
    [self.view addSubview:label];
    
    UIButton *button = [UIButton createButtonWithRect:CGRectMake(150, 250, 100, 40) title:@"button" titleColor:[UIColor yellowColor] target:self sel:@selector(tap) image:nil corner:0];
    [self.view addSubview:button];
    
    UIImageView *imageView = [UIImageView createImageView:CGRectMake(200, 300, 100, 100) image:nil isCorner:50 tap:^{
        self.view.backgroundColor = [UIColor blueColor];
    }];
    [self.view addSubview:imageView];
    
//    [self cornerView];
    
}



- (void)cornerView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(50, 50)];
    layer.lineWidth = 1.0f;
    layer.fillColor = [UIColor redColor].CGColor;
    layer.path = bezier.CGPath;
    [view.layer addSublayer:layer];
    [self.view addSubview:view];
    
}


- (void)tap {
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

