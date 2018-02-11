//
//  JANavigationSubView.h
//  JANavigationScrollView
//
//  Created by xiazhongchong on 06/02/2018.
//  Copyright © 2018 esunny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapNextContractBlock)(BOOL isNext);

@interface JANavigationSubView : UIView

@property (nonatomic, copy) TapNextContractBlock nextBlock;

- (void)changeContract:(NSString *)contractName;
@end
