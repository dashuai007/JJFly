//
//  LayoutView.m
//  JJFlyViewTransitions
//
//  Created by John on 5/11/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "LayoutView.h"

@implementation LayoutView

- (instancetype)init {
    self = [super init];
    if (self) {
        //获取当前view中所有的  NSLayoutConstraint
        [self constraints];
//        2、旧版方法，将指定的NSLayoutConstraint添加到页面或者从页面中移除
//        
//        1 1 - (void)addConstraint:(NSLayoutConstraint *)constraint NS_AVAILABLE_IOS(6_0); // This method will be deprecated in a future release and should be avoided.  Instead, set NSLayoutConstraint's active property to YES.
//        2 2 - (void)addConstraints:(NSArray *)constraints NS_AVAILABLE_IOS(6_0); // This method will be deprecated in a future release and should be avoided.  Instead use +[NSLayoutConstraint activateConstraints:].
//        3 3 - (void)removeConstraint:(NSLayoutConstraint *)constraint NS_AVAILABLE_IOS(6_0); // This method will be deprecated in a future release and should be avoided.  Instead set NSLayoutConstraint's active property to NO.
//        4 4 - (void)removeConstraints:(NSArray *)constraints NS_AVAILABLE_IOS(6_0); // This method will be deprecated in a future release and should be avoided.  Instead use +[NSLayoutConstraint deactivateConstraints:].

    }
    return self;
}


//设置视图view1为 宽度=20的正方形
//两种写法，第一种 宽度=20，高度=20
//view1.attr1 [= , >= , <=] view2.attr2 * multiplier + c;

//method 1
- (void)setWidthView:(UIView *)view {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20]];
    
}
//method 2
- (void)sameWithView:(UIView *)view {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
}

/*
 NSArray *constraints1=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|"
 　　　　　　　　　　　　　　　　　　　　　　　　　options:0
 　　　　　　　　　　　　　　　　　　　　　　　　　metrics:nil
 　　　　　　　　　　　　　　　　　　　　　　　　　views:NSDictionaryOfVariableBindings(button)];
 这里的意思是：button在水平方向上距离它的superView，左右各20px，比如在这里他的大小就是320-20*2=280.在@"H:|-[button]-|"这个语句中，其中"H:"是表示这是水平方向上的约束，"|"是表示superView，"-"表示一个间隔空间，这个间隔如果是如superView之间的，那么就是20px,如果是两个同级别的view，比如@"[button]-[button1]"，那么这里表示的是8px.
 
 
 1
 2
 3
 4
 NSArray *constraints2=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[button(==30)]"
 　　　　　　　　　　　　　　　　　　　　　　　　　options:0
 　　　　　　　　　　　　　　　　　　　　　　　　　metrics:nil
 　　　　　　　　　　　　　　　　　　　　　　　　　views:NSDictionaryOfVariableBindings(button)];
 跟上面有点不同,@"V:|-20-[button(==30)]",其中"V:"中代表这是垂直方向上的约束,"|-20-"这里的意思就是距离头部为20px，相当于y坐标为20。后面的"[button(==30)]"，是指定这个button的高度为30px.y坐标固定了，高度固定了，那这个view的约束就完成了。如果你有需要，你的高度值（或者其他同类型的）可以使用>=,==,<=来表示，甚至你可以组合来用，像上面的30，你可以指定一个区别，比如:(>=30,<=40)，这同样也是可以的。如果你想表达他的优先级别,可以使用@"V:|-20-[button(==30@1000)]",这个@1000，就是他的级别了。你可以适配XIB或者SB对它的优先级做更多的处理.
 */

- (void)setCon {
    UIButton *button=[[UIButton alloc]init];
        [button setTitle:@"点击一下" forState:UIControlStateNormal];
        button.translatesAutoresizingMaskIntoConstraints=NO;
        [button setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:button];
        NSArray *constraints1=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|"
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　options:0
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　metrics:nil
                                　　　　　　　　　　　　　　　　　　　　　　　　　　　views:NSDictionaryOfVariableBindings(button)];
          
        NSArray *constraints2=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[button(==30)]"
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　　options:0
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　　metrics:nil
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　　views:NSDictionaryOfVariableBindings(button)];
          
        [self.view addConstraints:constraints1];
        [self.view addConstraints:constraints2];
          
          
        UIButton *button1=[[UIButton alloc]init];
        button1.translatesAutoresizingMaskIntoConstraints=NO;
        [button1 setTitle:@"请不要点击我" forState:UIControlStateNormal];
        [button1 setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:button1];
          
        NSArray *constraints3=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button1]-|"
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　　 options:0
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　　metrics:nil
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　　views:NSDictionaryOfVariableBindings(button1)];
          
        NSArray *constraints4=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-[button1(==30)]"
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　　options:0
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　　metrics:nil
                               　　　　　　　　　　　　　　　　　　　　　　　　　　　　views:NSDictionaryOfVariableBindings(button1,button)];
          
        [self.view addConstraints:constraints3];
        [self.view addConstraints:constraints4];
}


- (void)updateConstraints {
    
}

@end
