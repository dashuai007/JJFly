//
//  JAShufflingView.h
//  JAShufflingScrollView
//
//  Created by xiazhongchong on 04/01/2018.
//  Copyright © 2018 JJFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAShufflingView : UIView
@property (nonatomic, strong) NSString *name;

- (void)loadData:(NSInteger)totalNumber;

@end
