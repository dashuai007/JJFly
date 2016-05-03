//
//  GCDViewController.m
//  BlockBase
//
//  Created by John on 4/17/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()
@property (nonatomic, copy) NSString *name;
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)GCDE {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //后台执行
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
       //主线程执行
    });
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //一次性执行
    });
    
    //延迟两秒执行
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
    });
    
    dispatch_queue_t urls_queue = dispatch_queue_create("blog.devtang.com", NULL);
    dispatch_async(urls_queue, ^{
        
    });
//    dispatch_release(urls_queue);
    
    
    //让后台的两个线程并行执行，等两个线程都执行结束后，再汇总执行结果。
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        //汇总结果 
    });
    
}

- (void)editInBlock {
    __block int a = 0;
    void (^foo)(void) = ^ {
        a++;
    };
    
    foo();
    NSLog(@"a = %d", a);
    
}

- (void)GCD_1 {
    void (^someBlock)() = ^{
        NSLog(@"Hi someBlock");
    };
    someBlock();
    
    int (^addBlock)(int a, int b) = ^(int a, int b){
        return a + b;
    };
    
    addBlock(3, 5);
    
    NSArray *data = @[@1, @3, @5, @4];
    __block NSInteger count = 0;
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj compare:@3] == NSOrderedAscending) {
            count++;
        }
    }];
    
}

- (void)block_1 {
    self ->_name = @"jane";
    void (^someBlock)() = ^{
        _name = @"name";
        self.name = @"jajj";
        NSLog(@"%@", _name);
    };
    someBlock();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
