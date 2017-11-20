//
//  GCDViewController.h
//  JATangQiaoBook
//
//  Created by xiazhongchong on 17/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BtnBlock)(NSString *str);
@interface GCDViewController : UIViewController
//@property (copy, nonatomic) BtnBlock block;
- (void)clickBlock:(BtnBlock)block;
@end
