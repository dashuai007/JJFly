//
//  News.m
//  WangyiNews
//
//  Created by iHope on 14-1-10.
//  Copyright (c) 2014年 任海丽. All rights reserved.
//

#import "News.h"
/*
 {
 id: "1",
 title: "明星双11也疯狂晒单晒幸福",
 descr: "一起来看看明星们是如何度过光棍节这个疯狂的日子吧",
 imgurl: "http://img1.cache.netease.com/lady/2013/11/12/2013111209141859623.jpg",
 islook
 }
 */
@implementation News

- (id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.newsid = [dictionary objectForKey:@"id"];
        self.title = [dictionary objectForKey:@"title"];
        self.descr = [dictionary objectForKey:@"descr"];
        self.imgurl = [dictionary objectForKey:@"imgurl"];
        self.islook = @"0";//0未查看1已查看
    }
    return self;
}

@end
