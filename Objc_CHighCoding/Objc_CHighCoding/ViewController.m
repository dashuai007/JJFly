//
//  ViewController.m
//  Objc_CHighCoding
//
//  Created by John on 19/12/2016.
//  Copyright © 2016 John. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSAutoreleasePool
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task0---%@", [NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    }];
    
    // 开始必须在添加其他操作之后
    [op start];
    
    
    
}

- (void)nsthread {
    UIImage *image = [UIImage imageNamed:@""];
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething) object:image];


    [thread start];
}

- (void)doSomeThing:(id)anObj {
    @synchronized (anObj) {
        //循环锁NSRecursiveLock，条件锁NSConditionLock，分布式锁NSDistributedLock NSLock。
    }
}

/*
 - (void)setAge:(int)age

 {       
 atomic加锁原理
 @synchronized(self) {

               _age = age;
        }

 }
 */

- (void)doSomething {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
