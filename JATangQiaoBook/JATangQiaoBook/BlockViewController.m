//
//  GCDViewController.m
//  JATangQiaoBook
//
//  Created by xiazhongchong on 17/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()

@end


/**
 自动引用计数--内存管理
 LLVM编译器中设置ARC有效状态，无需在键入retain或者release
 
 内存管理的思考方式：
 自己生成的对象，自己所持有；非自己生成的对象，自己也能持有
 不再需要自己持有的对象时释放；非自己持有的对象无法释放
 
 生成并持有对象alloc/new/copy/mutableCopy等方法
 持有对象 retain
 释放对象 release
 废弃对象 dealloc
 
 这些有关OC内存管理的方法，实际不包含在该语言中，而是包含在cocoa框架中，用于OSX、iOS应用开发。cocoa框架中foundation框架类库的NSObjective类单幅内存管理的职责。
 
 copy方法利用基于NSCopying方法约定，由各类实现copyWithZone:方法生成并持有对象的副本。mutableCopy方法基于NSMutableCopying方法约定，由各类实现的mutableCopyWithZone:方法生成并持有对象的副本。两者的区别在于，copy方法生成不可变更的对象，而mutableCopy方法生成可变更的对象，虽然生成的是对象的副本，但同alloc、new方法一样，在自己生成并持有对象这点上没有改变
 
 非自己生成的对象，自己也能持有 [object retain];
 不再需要自己持有的对象时释放   [object release];
 无法释放非自己持有的对象
 
 release立即释放
 autorelease不立即释放，注册到autoreleasepool中，pool结束时自动释放
 
 NSDefaultMallocZone、NSZoneMalloc等名称中包含的NSZone是什么呢？它是为了防止碎片化而引入的结构。对内存分配的区域本身进行多重化管理，根据适用对象的目的、对象的大小分配内存，从而提高内存管理效率。
 两种容量使用两种区域：大容量区域和分配小容量区域。不发生碎片化
 
 
 */
@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    
}







@end
