//
//  JFImage.m
//  JJFlyWaterFall
//
//  Created by John on 5/16/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "JFImage.h"

@implementation JFImage
+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic {
    JFImage *image = [[JFImage alloc] init];
    image.imageURL = [NSURL URLWithString:imageDic[@"img"]];
    image.imageW = [imageDic[@"w"] floatValue];
    image.imageH = [imageDic[@"h"] floatValue];
    return image;
}
@end
