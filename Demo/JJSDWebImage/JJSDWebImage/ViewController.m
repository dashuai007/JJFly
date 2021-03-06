//
//  ViewController.m
//  JJSDWebImage
//
//  Created by xiazhongchong on 23/01/2018.
//  Copyright © 2018 JJFly. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HomeViewController.h"
#import <CTMediator.h>
/**
 分析SDWebImageManager
 
 
 
 */


/**
 NS_OPTIONS and NS_ENUM
 NS_OPTIONS 使用按位方式赋值 可以使用多个枚举
 NS_ENUM 使用阿拉伯数字赋值  只能使用一个枚举
 1、enum和option的参数值不一样，分别是NSInteger和NSUInteger
 2、使用方式不一样，option使用的是位移的方法，enum使用的是整型
 3、enum只能使用一个，option可以使用多个
 4、编译方式不一样，option使用的是C++编译方式NSUInter，
 
 NSCache苹果官方提供的，专门做缓存的类
 使用方式和NSMutableDictionary使用很相似
 线程安全
 当内存不足的时候，就会自动清理缓存
 程序开始的时候，自己可以指定数量和成本的概念
 NSCache不支持遍历，而是通过key进行访问的
 */

@interface ViewController () <NSCacheDelegate>
{
    NSCache *_cache;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84, 50, 50)];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"www.baidu.com"] placeholderImage:[UIImage imageNamed:@"nil"] options:SDWebImageRefreshCached];
//    [self.view addSubview:imageView];
//    
//    [SDWebImageManager sharedManager].imageDownloader.username = @"esunny";
//    [SDWebImageManager sharedManager].imageDownloader.password = @"";
//    
//    //队列先进先出
//    //后进先出 栈的形式
//    [[[SDWebImageManager sharedManager] imageCache] setValue:@"demo" forKey:@"sdwebimage"];
//    [[SDWebImageManager sharedManager] imageDownloader].executionOrder = SDWebImageDownloaderFIFOExecutionOrder;
    
//    [[[SDWebImageManager sharedManager] imageCache] clearMemory]; 清理内存同CPU对话
    //清理磁盘 先加载到内存然后和CPU对话
//    [[[SDWebImageManager sharedManager] imageCache ] clearDiskOnCompletion:nil];
    
}

- (void)cacheInit {
    _cache = [NSCache new];
    _cache.countLimit = 10;
    _cache.delegate = self;
}
//查看缓存内容
- (void)showCache {
    for (int i = 0; i < 20; i++) {
        id obj = [_cache objectForKey:@(i)];
        NSLog(@"%@", obj);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    for (int i = 0; i < 20; i++) {
//        NSString *str = [@"隔壁老王有" stringByAppendingFormat:@"%d个", i];
//        [_cache setObject:str forKey:@(i)];
//        NSLog(@"%@", [_cache objectForKey:@(i)]);
//    }
//    Class class = NSClassFromString(@"HomeViewController");
//    UIViewController *vc = (UIViewController *)[class new];
//    [self.navigationController pushViewController:vc animated:YES];
    NSURL *url = [NSURL URLWithString:@""];
    [[CTMediator sharedInstance] performActionWithUrl:url completion:nil];
}

/**
是否支持当前VC自动旋转
 */
- (BOOL)shouldAutorotate {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"will evict --%@", obj);
}


@end
