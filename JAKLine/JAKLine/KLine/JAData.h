//
//  JAData.h
//  JAKLine
//
//  Created by xiazhongchong on 30/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import <Foundation/Foundation.h>


@class JAData;

@protocol JADataDelegate <NSObject>

@required

- (void)dataKLine:(NSArray *)array;

@end

@interface JAData : NSObject

@property (nonatomic, assign) id <JADataDelegate> delegate;

- (void)dataAdd:(id<JADataDelegate>)delegate;

@end
