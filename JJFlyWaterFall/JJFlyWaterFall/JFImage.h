//
//  JFImage.h
//  JJFlyWaterFall
//
//  Created by John on 5/16/16.
//  Copyright © 2016 John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JFImage : NSObject
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, assign) CGFloat imageW;
@property (nonatomic, assign) CGFloat imageH;

+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic;

@end
