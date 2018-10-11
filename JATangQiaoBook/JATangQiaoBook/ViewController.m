//
//  ViewController.m
//  JATangQiaoBook
//
//  Created by xiazhongchong on 17/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "BlockViewController.h"
#import "POP.h"
#import "UIViewExtension.h"
@interface ViewController ()
@property (nonatomic, strong) UIView *centerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *neededName = @"DFWaWaSC-W5";
    BOOL isLoaded = [self queryFoneDownloaded:neededName];
    if (!isLoaded) {
        [self downloaded:neededName];
    } else {
        NSLog(@"already downloaded");
    }
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self centerView];
    NSLog(@"%f %f", self.centerView.width, self.centerView.height);
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    GCDViewController *gc = [[GCDViewController alloc] init];
//    [gc clickBlock:^(NSString *str) {
//       NSLog(@"%@", str);
//    }];
//    [self presentViewController:gc animated:YES completion:nil];
    
    
    
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    [self pop_animation:point];
}

- (void)pop_animation:(CGPoint)point {
    
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation   animationWithPropertyNamed:kPOPViewCenter];
    
    
    springAnimation.toValue = [NSValue valueWithCGPoint:point];
    
//    if (_centerView.alpha == 1) {
//        springAnimation.toValue = @0;
//    } else {
//        springAnimation.toValue = @1;
//    }
    //弹性值
    springAnimation.springBounciness = 20;
    //弹性速度
    springAnimation.springSpeed = 8.0;
    
//    [self.centerView pop_addAnimation:animation_alpha forKey:@"alpha"];

//    [self.centerView pop_addAnimation:animation_center forKey:@"center"];
    [self.centerView pop_addAnimation:springAnimation forKey:@"bounces"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_centerView pop_removeAllAnimations];
    });
    
}


- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _centerView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_centerView];
    }
    return _centerView;
}

#pragma mark - test block


#pragma mark - 下载字体，下载完成通知更新字体
- (void)downloaded:(NSString *)fontName {
    //用字体的postscript 名字创建一个字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];

    //创建一个字体描述对象
    CTFontDescriptorRef des = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)des];
    CFRelease(des);

    __block BOOL errorDuringDownload = NO;
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler((__bridge CFArrayRef)descs, NULL, ^bool(CTFontDescriptorMatchingState state, CFDictionaryRef  _Nonnull progressParameter) {
        double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
        if (state == kCTFontDescriptorMatchingDidFinish) {
            if (!errorDuringDownload) {
                NSLog(@"download finish");
            }
        } else if (state == kCTFontDescriptorMatchingDownloading) {
            NSLog(@"%.2f%%", progressValue);
        }
        return YES;
    });
}


- (BOOL)queryFoneDownloaded:(NSString *)fontName {
    
    UIFont *font = [UIFont fontWithName:fontName size:12.0f];
    if (font && [font.fontName compare:fontName] == NSOrderedSame) {
        return YES;
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
