//
//  ViewLayoutConstrint.h
//  JJFlyViewTransitions
//
//  Created by John on 5/11/16.
//  Copyright © 2016 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewLayoutConstrint : NSLayoutConstraint
/*第一个参数 view1: 要设置的视图；
 
 第二个参数 attr1: view1要设置的属性  NSLayoutAttributeLeft
 
 第三个参数 relation: 视图view1和view2的指定属性之间的关系，稍后详解；
 
 第四个参数 view2: 参照的视图；
 
 第五个参数 attr2: 参照视图view2的属性，稍后详解；
 
 第六个参数 multiplier: 视图view1的指定属性是参照视图view2制定属性的多少倍；
 
 第七个参数 c: 视图view1的指定属性需要加的浮点数。
 根据参数的讲解，得出计算公式如下：
 
 view1.attr1 [= , >= , <=] view2.attr2 * multiplier + c;
 
 NSLayoutAttributeBaseline: 文本底标线，在大多数视图中等同于NSLayoutAttributeBottom； 在少数视图，如UILabel，是指字母的底部出现的位置 ;
 
 NSLayoutAttributeFirstBaseline: 文本上标线 ;
 
 


 */
+ (instancetype)constraintWithItem:(id)view1
                         attribute:(NSLayoutAttribute)attr1
                         relatedBy:(NSLayoutRelation)relation
                            toItem:(id)view2
                         attribute:(NSLayoutAttribute)attr2
                        multiplier:(CGFloat)multiplier
                          constant:(CGFloat)c;
/*
 3、ios8新加方法，激活或者停用指定约束
 1 /* The receiver may be activated or deactivated by manipulating this property.  Only active constraints affect the calculated layout.  Attempting to activate a constraint whose items have no common ancestor will cause an exception to be thrown.  Defaults to NO for newly created constraints.  
 @property (getter=isActive) BOOL active NS_AVAILABLE(10_10, 8_0);
  Convenience method that activates each constraint in the contained array, in the same manner as setting active=YES. This is often more efficient than activating each constraint individually.
 + (void)activateConstraints:(NSArray *)constraints NS_AVAILABLE(10_10, 8_0);

 Convenience method that deactivates each constraint in the contained array, in the same manner as setting active=NO. This is often more efficient than deactivating each constraint individually.
 + (void)deactivateConstraints:(NSArray *)constraints NS_AVAILABLE(10_10, 8_0);
 */
@end
