//
//  News.h
//  WangyiNews
//
//  Created by iHope on 14-1-10.
//  Copyright (c) 2014年 任海丽. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 id: "1",
 title: "明星双11也疯狂晒单晒幸福",
 descr: "一起来看看明星们是如何度过光棍节这个疯狂的日子吧",
 imgurl: "http://img1.cache.netease.com/lady/2013/11/12/2013111209141859623.jpg",
 
 }
 */
@interface News : NSObject

@property (nonatomic, strong) NSString *newsid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *islook;//0未查看1已查看
- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
