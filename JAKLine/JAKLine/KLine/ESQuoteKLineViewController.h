//
//  ESQuoteKLineViewController.h
//  epolestar
//
//  Created by xiazhongchong on 04/12/2017.
//  Copyright © 2017 esunny. All rights reserved.
//

#import "RootViewController.h"

typedef NS_ENUM(NSInteger, ESQuoteKViewCSkipVC) {
    ESQuoteKViewCSkipVCFavorite,//自选跳转
    ESQuoteKViewCSkipVCQuote,//行情列表跳转
    ESQuoteKViewCSkipVCOption,//期权跳转
};

typedef void(^TabSelectVC) (SContract *contract, SDirectType type);

@interface ESQuoteKLineViewController : RootViewController

@property(nonatomic, assign) SContract *contract;
@property(nonatomic, strong) KLinePeroid *klinePeroid;
@property(nonatomic, assign) BOOL isCrossView;

@property (nonatomic, copy) TabSelectVC selectVC;

//自选 行情 或者是期权跳转到K线界面
@property (nonatomic, assign) ESQuoteKViewCSkipVC skipFromVC;

@end
