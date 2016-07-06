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
    
    [self GCD_2];
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

/*
 GCD的所有的调度队列都是先进先出队列，因此，队列中的任务的开始的顺序和添加到队列中的顺序相同。我们可以将部分独立运行的任务添加到对列，由系统管理执行。
 
 　　GCD队列主要有三种，系统主队列 main_queue、全局并发队列 global_queue和自定义队列
 
 并发队列     队列中的任务必须在前一个任务开始后才能执行
 同步串行队列：队列的执行任务与主线程是同步的，会阻塞主线程
 异步串行队列：队列的执行任务与主线程是异步的
 串行队列     队列中的任务必须在前一个任务结束后才能执行（可替代线程锁）
 同步串行队列：队列的执行任务与主线程是同步的，会阻塞主线程
 异步串行队列：队列的执行任务与主线程是异步的
 */

- (void)GCD_2 {
    //main_queue
    //global_queue
    //self define
    
    //1.创建串行队列、提交同步任务
    dispatch_queue_t queue_t = dispatch_queue_create("QueueName", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue_t, ^{
        //task 1
        NSLog(@"111");
    });
    
    dispatch_sync(queue_t, ^{
        //task 2
        NSLog(@"222");
    });
    //队列中的任务是同步出列的，任务一执行结束后执行任务二。这种类型的任务与主线程是同步的，会阻塞主线程
    
    
    //自定义串行队列，提交异步任务
    dispatch_async(queue_t, ^{
        
    });
    dispatch_async(queue_t, ^{
        
    });
    
    //创建并行队列、提交异步任务
    dispatch_queue_t queue = dispatch_queue_create("queueName", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        //code 任务一
    });
    dispatch_async(queue, ^{
        //code 任务一
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
