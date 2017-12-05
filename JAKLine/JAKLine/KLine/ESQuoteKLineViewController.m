//
//  ESQuoteKLineViewController.m
//  epolestar
//
//  Created by xiazhongchong on 04/12/2017.
//  Copyright © 2017 esunny. All rights reserved.
//

#import "ESQuoteKLineViewController.h"
#import "QuoteKCrossViewController.h"
#import "QuoteBetsView.h"
#import "QuoteKLineViewController.h"
#import "WJScrollerMenuView.h"
#import "KLineConstant.h"
#import "KLineView.h"
#import "FavoriteContract.h"
#import "AppDelegate.h"
#import "KLineGlobalVariable.h"
#import "UIColor+KLine.h"
#import "TradeViewController.h"
#import "ESFuturesBetsView.h"
#import "BaseNavigationController.h"
#import "TabBarViewController.h"
#import "QuoteData.h"
#import "OptionData.h"
#import "KLineGroupModel.h"
#import "UIColor+KLine.h"
#import "KLineMainView.h"
#import "KTimeSharingView.h"
#import "QuoteKCrossViewController.h"

@interface ESQuoteKLineViewController ()<WJScrollerMenuDelegate, ApiHisQuoteNotifyDelegate, ApiQuoteNotifyDelegate>
{
    BOOL _isGetNewData;
    BOOL _isAddFavorite;
    //
    int  _getDataCount;
    BOOL _isLayout;
}

@property(nonatomic, strong)WJScrollerMenuView* kTypeScroll;
@property(nonatomic, strong)QuoteBetsView* quoteBetView;
@property(nonatomic, assign)NSInteger kTypeIndex;
@property(atomic, assign)BOOL dataReady;
@property(nonatomic, strong)MBProgressHUD* hud;
@property(nonatomic, assign)NSInteger subHisQuoteCount;
//表示断开连接
@property (nonatomic, assign) BOOL isLost;
//盘口信息
@property (nonatomic, strong) ESFuturesBetsView *futuresBV;

@property(nonatomic,strong)KLineGroupModel* groupModel;
//KLineMainView(三部分：K线、成交量、指标)
@property(nonatomic, strong)KLineMainView* kLineMainView;
@property(nonatomic, strong)KTimeSharingView* kTimeSharingView;
@property(nonatomic, strong)UIButton* btnEnlarge;
@property(nonatomic, strong)MBProgressHUD* errorHUD;
//记录该界面的K线类型（）

@end




@implementation ESQuoteKLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.isLost = NO;
    self.kTypeIndex = 0;
    self.dataReady = false;
    self.subHisQuoteCount = 0;
    
    _isGetNewData = true;
    _getDataCount = 300;
    self.view.autoresizingMask = UIViewAutoresizingNone;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewData) name:@"KLineViewGetNewData" object:@"DefaultView"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewData_Quote) name:@"KLineViewGetNewData" object:@"ChangeDataTypeQuote"];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    
    
    [self.kTypeScroll setMyTitleArray:[[SettingHelper sharedHelper] readKLinePeroid].mutableCopy];
    [[ApiNotifyManager sharedManager] addHisQuoteObserver:self];
    [[ApiNotifyManager sharedManager] addQuoteObserver:self];
    
    [KLineGlobalVariable initAllParams];
    [self setNavigationAttribute];
    self.isCrossView = NO;
    
    SQuoteSnapShot snap;
    S_GetSnapShot(self.contract->ContractNo, &snap);
    [self.quoteBetView setData:&snap setContract:self.contract];
    
    
    SSessionIdType sessionid = 0;
    int iRet = S_SubHisQuote(self.contract->ContractNo, S_KLINE_DAY, &sessionid);
    iRet= S_SubHisQuote(self.contract->ContractNo, S_KLINE_MINUTE, &sessionid);
    
    S_SubQuote(self.contract->ContractNo);
    
    
    if(self.subHisQuoteCount == 0){
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.label.text = @"loading";
        [self.hud showAnimated:YES];
    }
    self.subHisQuoteCount++;
    
    if(!_dataReady && iRet == 2){
        [self refreshHisQuoteData:ChangeDataTypeNormal];
    }
    
    if (iRet == 2) {
        [self.hud hideAnimated:YES afterDelay:0.3f];
    } else {
        [self.hud hideAnimated:NO afterDelay:0.8f];
    }
    
    [self.kTypeScroll setCurrentIndex:self.kTypeIndex];
    
    
    _isLayout = YES;
    [KLineGlobalVariable setkLineViewRadio:0.45];
    [KLineGlobalVariable setkLineVolumViewRadio:0.275];
    
    //KLineMain进行更新
    [self.kLineMainView willAppear];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self layoutSubviews];
    if(_isLayout){
        [self initFirst];
    }
}

-(void)initFirst
{
    if(![self.klinePeroid.name isEqualToString:@"分时图"]){
        [self.kLineMainView changeDrawType:ChangeDataTypeNormal];
        [self KLineMainRedraw];
    }else{
        [self timeSharingDraw];
    }
}

-(void)layoutSubviews
{
    [self.view addSubview:self.kTypeScroll];
}

- (ESFuturesBetsView *)futuresBV {
    if (!_futuresBV) {
        _futuresBV = [[ESFuturesBetsView alloc] init];
        _futuresBV.hidden = YES;
    }
    return _futuresBV;
}

-(QuoteBetsView*)quoteBetView
{
    if(_quoteBetView == nil)
    {
        _quoteBetView = [[QuoteBetsView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, QuoteBetsH)];
        __weak typeof(self) blockSelf = self;
        
        _quoteBetView.tap = ^{
#pragma mark - add action to show tape
            [blockSelf showPOP];
        };
        [self.view addSubview:_quoteBetView];
    }
    return _quoteBetView;
}

- (void)showPOP {
    SQuoteSnapShot snap;
    S_GetSnapShot(self.contract->ContractNo, &snap);
    [self.futuresBV showBView];
    [self.futuresBV showBets:&snap contract:self->_contract];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");
    [super viewWillDisappear:animated];
    
    [[ApiNotifyManager sharedManager] removeHisQuoteObserver:self];
    [[ApiNotifyManager sharedManager] removeQuoteObserver:self];
    
    _dataReady = false;
    
    _isLayout = NO;
    [self.kLineMainView willDisappear];
    [self.kTimeSharingView willDisappear];
}

-(void)getNewData
{
    [self getNewData:ChangeDataTypePan];
}
-(void)getNewData_Quote
{
    [self getNewData:ChangeDataTypeQuote];
}
-(void)didAppThemeChanged
{
    [self refreshHisQuoteData:ChangeDataTypeNormal];
    [self.quoteBetView changeTheme];
    [self changeTheme];
    [self.kTypeScroll changeTheme];
}

-(WJScrollerMenuView*)kTypeScroll
{
    if(_kTypeScroll == nil){
        CGRect frame = self.view.bounds;
        frame.origin = CGPointMake(0, QuoteBetsH);;
        frame.size = CGSizeMake(self.view.frame.size.width, kTypeScrollH);
        _kTypeScroll = [[WJScrollerMenuView alloc] initWithFrame:frame showArrayButton:NO backgroundColor:[UIColor backgroundColor ] selectedColor:[UIColor increaseColor] noSelectColor:[UIColor assistTextColor]];
        _kTypeScroll.delegate=self;
        _kTypeScroll.myTitleArray= [[SettingHelper sharedHelper] readKLinePeroid].mutableCopy;
        _kTypeScroll.currentIndex=0;
        [self.view addSubview:_kTypeScroll];
    }
    return _kTypeScroll;
}

-(void)setNavigationAttribute
{
    UIBarButtonItem* followItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"following_normal.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addFavorite)];
    if(_isAddFavorite){
        followItem.image = [UIImage imageNamed:@"following_press.png"];
    }
    UIBarButtonItem *tradeItem = [[UIBarButtonItem alloc] initWithImage:[[UITheme imageName:@"deal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(trade)];
    tradeItem.imageInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    
    self.navigationItem.rightBarButtonItems = @[[self rightBarButton], followItem, tradeItem];
}

-(void)addFavorite
{
    if(_isAddFavorite){
        self.navigationItem.rightBarButtonItems[1].image = [UIImage imageNamed:@"following_normal.png"];
        [[FavoriteContract sharedInstance] removeContract:_contract];
    }else{
        self.navigationItem.rightBarButtonItems[1].image = [UIImage imageNamed:@"following_press.png"];
        [[FavoriteContract sharedInstance] addContract:_contract];
    }
    _isAddFavorite = !_isAddFavorite;
}

-(MBProgressHUD*)errorHUD
{
    if(!_errorHUD)
    {
        _errorHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _errorHUD.mode = MBProgressHUDModeText;
        _errorHUD.label.text = @"数据获取失败！";
        _errorHUD.offset = CGPointMake(0.f, MBProgressMaxOffset);
    }
    return _errorHUD;
}

-(KLineMainView* )kLineMainView
{
    if(!_kLineMainView)
    {
        
        _kLineMainView = [[KLineMainView alloc]initWithFrame:CGRectMake(0, QuoteBetsH + kTypeScrollH, self.view.frame.size.width, SCREEN_HEIGHT - kTypeScrollH - QuoteBetsH - 64)];
        
        _kLineMainView.contract = _contract;
        _kLineMainView.hidden = NO;
        _kLineMainView.mainViewRatio = 0.45;
        _kLineMainView.volumeViewRatio = 0.275;
        _kLineMainView.isCrossView = NO;
        __block typeof(self) blockSelf = self;
        _kLineMainView.swip_block = ^(BOOL up) {
            [blockSelf swipView:up];
        };
        [self.view addSubview:_kLineMainView];
        if(!_kLineMainView.isCrossView){
            [self.btnEnlarge setFrame:CGRectMake(self.view.frame.size.width - KLineEnlargeWidth - labXVap, self.kLineMainView.height * _kLineMainView.mainViewRatio - KLineEnlargeWidth + self.kLineMainView.top, KLineEnlargeWidth, KLineEnlargeWidth)];
            [self.btnEnlarge addTarget:self action:@selector(showCrossView) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _kLineMainView;
}
-(void)showCrossView
{
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appdelegate.allowRotation = YES;
    
    QuoteKCrossViewController* crossVc = [[QuoteKCrossViewController alloc] init];
    [crossVc setBaseInfo:self.klinePeroid contract:self.contract];
    crossVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:crossVc animated:YES completion:nil];
}
-(UIButton*)btnEnlarge{
    if(!_btnEnlarge){
        _btnEnlarge = [[UIButton alloc] init];
        [_btnEnlarge setImage:[UIImage imageNamed:@"kline_enlarge.png"] forState:UIControlStateNormal ];
        [_btnEnlarge setBackgroundColor:[UIColor enlargeColor]];
    }
    [self.view addSubview:_btnEnlarge];
    return _btnEnlarge;
}

-(KTimeSharingView*)kTimeSharingView
{
    if(!_kTimeSharingView)
    {
        _kTimeSharingView = [[KTimeSharingView alloc] init];
        _kTimeSharingView.frame = CGRectMake(0, QuoteBetsH + kTypeScrollH, self.view.frame.size.width, SCREEN_HEIGHT - kTypeScrollH - QuoteBetsH - 64);
        [_kTimeSharingView setContract:_contract];
        _kTimeSharingView.hidden = YES;
        __block typeof(self) blockSelf = self;
        _kTimeSharingView.swip_block = ^(BOOL up) {
            [blockSelf swipView:up];
        };
        [self.view addSubview:_kTimeSharingView];
        if(!self.kLineMainView.isCrossView){
            [self.btnEnlarge setFrame:CGRectMake(self.view.frame.size.width - KLineEnlargeWidth, self.kLineMainView.height * _kLineMainView.mainViewRatio - KLineEnlargeWidth + self.kLineMainView.top, KLineEnlargeWidth, KLineEnlargeWidth)];
            [self.btnEnlarge addTarget:self action:@selector(showCrossView) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _kTimeSharingView;
}

-(void)setContract:(SContract *)contract
{
    if(contract != nil){
        if(_contract != contract){
            _isGetNewData = true;
            _contract = contract;
            //利用接口获取合约名称；
            SContractNameType showName;
            S_GetContractName(contract->ContractNo, showName);
            self.navigationItem.title = [NSString stringWithUTF8String:showName];
            if([[FavoriteContract sharedInstance]contractIndex:_contract] == -1){
                _isAddFavorite = false;
            }else{
                _isAddFavorite = true;
            }
            
            [self.kLineMainView setContract:_contract];
        } else {
            _isGetNewData = false;
        }
    }
}

- (void)trade {
    
    [self.navigationController popViewControllerAnimated:NO];
    if (self.selectVC) {
        _selectVC(_contract, S_DIRECT_BOTH);
    }
    
}

-(void)setKlinePeroid:(KLinePeroid *)klinePeroid
{
    if(klinePeroid){
        [self setKLinePeroid:klinePeroid];
    }
}

-(void)setKLinePeroid:(KLinePeroid*)peroid
{
    _klinePeroid = peroid;
    if(![_klinePeroid.name isEqualToString:@"分时图"]){
        self.kLineMainView.hidden = NO;
        self.kTimeSharingView.hidden = YES;
        [self.kLineMainView setContract:_contract];
        [self.kLineMainView setKlinePeroid:_klinePeroid];
        [self onHisQuoteRsp:self.klinePeroid  changeType:ChangeDataTypeNormal];
    }else{
        self.kLineMainView.hidden = YES;
        self.kTimeSharingView.hidden = NO;
        [self.kTimeSharingView willDisappear];
        [self timeSharingDraw];
    }
}

//目前该函数执行次数较多，要进行流程优化
-(void)refreshHisQuoteData:(int)changeType;
{
    [self onHisQuoteRsp:self.klinePeroid changeType:changeType];
}
-(void)onHisQuoteRsp:(KLinePeroid*)peroid changeType:(int)changeType
{
    if(_contract == NULL ){return ;}
    int iGetCount = 0;
    if(self.kLineMainView.hidden == NO){
        iGetCount = [self getHistoryQuoteDataFromApi:peroid  changeIndex:changeType];
        [self KLineMainRedraw];
    }else if(self.kTimeSharingView.hidden == NO){
        [self timeSharingDraw];
    }
}
-(void)kLineViewGetNewData:(int)changeType
{
    if(changeType == ChangeDataTypePan){
        _getDataCount += 300;
        if(_getDataCount >= 5000){
            _getDataCount = 5000;
            return ;
        }
    }
    [self getHistoryQuoteDataFromApi:self.klinePeroid changeIndex:changeType];
    [self KLineMainRedraw];;
}
#pragma mark - private Method
-(int)getHistoryQuoteDataFromApi:(KLinePeroid*)peroid  changeIndex:(int)changeType;
{
    [self.kLineMainView changeDrawType:changeType];
    SHisQuoteData data[_getDataCount];
    int iGetCount = 0;
    if(![peroid.name isEqualToString:@"分时图"]){
        iGetCount = S_GetHisQuote(_contract->ContractNo , peroid.type, peroid.slice, 0, data, _getDataCount);
        if(iGetCount == 0){
            return iGetCount;
        }
    }else{
        [self timeSharingDraw];
    }
    self.groupModel = [KLineGroupModel objectWithHisData:data size:iGetCount];
    return iGetCount;
}
-(void)KLineMainRedraw
{
    self.kLineMainView.klinePeroid = self.klinePeroid;
    self.kLineMainView.kLineModels = self.groupModel.models;
    [self.kLineMainView drawKLineMainView];
}
-(void)timeSharingDraw
{
    [self.kTimeSharingView setContract:_contract];
    [self.kTimeSharingView drawTimeSharingView];
}
-(void)changeTheme
{
    [self refreshHisQuoteData:ChangeDataTypeQuote];
    [self.kLineMainView changeTheme];
    [self.kTimeSharingView changeTheme];
    [self.btnEnlarge setNeedsDisplay];
}

-(void)getNewData:(int)changeType
{
    [self kLineViewGetNewData:changeType];
}

#pragma mark - MJselected Delegate

-(void)itemDidSelectedWithIndex:(NSInteger)index
{
    self.kTypeIndex = index;
}
-(void)WJScrollerMenuDelegate:(NSString*)string
{
    self.klinePeroid = [KLineUtil getKLinePeroid:string];
//    [self.quoteKLineVC setKLinePeroid:self.klinePeroid];
}
-(BOOL)prefersStatusBarHidden{
    return NO;
}

#pragma mark - 上下滑动切换合约
- (UIImage *)snapCurrentPage:(UIView *)view {
    UIGraphicsBeginImageContext(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)swipView:(BOOL)up {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [self snapCurrentPage:self.view];
    [keyWindow addSubview:imageView];
    
    
    for (int index = 0 ; index < self.subHisQuoteCount; index++) {
        S_UnsubHisQuote(_contract->ContractNo);
        S_UnsubHisQuote(_contract->ContractNo);
        S_UnsubQuote(_contract->ContractNo);
    }
    self.subHisQuoteCount = 0;
    
#pragma mark - 判断是拿一个进行跳转的 稍后刷新数据
    [self switchScontract:up];
    
    
    
    SSessionIdType sessionid = 0;
    int iRet = S_SubHisQuote(self.contract->ContractNo, S_KLINE_DAY, &sessionid);
    iRet= S_SubHisQuote(self.contract->ContractNo, S_KLINE_MINUTE, &sessionid);
    S_SubQuote(self.contract->ContractNo);
    self.subHisQuoteCount++;
    
    SQuoteSnapShot snap;
    S_GetSnapShot(self.contract->ContractNo, &snap);
    
    if (!_futuresBV.hidden) {
        [self.futuresBV showBets:&snap contract:self.contract];
    }
    
//    _quoteKLineVC.view.userInteractionEnabled = NO;
    
    if (up) {
        [UIView animateWithDuration:0.8f animations:^{
            imageView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            if (finished) {
                [imageView removeFromSuperview];
//                _quoteKLineVC.view.userInteractionEnabled = YES;
            }
        }];
    } else {
        [UIView animateWithDuration:0.8f animations:^{
            imageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            if (finished) {
                [imageView removeFromSuperview];
//                _quoteKLineVC.view.userInteractionEnabled = YES;
            }
        }];
    }
}


- (void)switchScontract:(BOOL)up {
    _dataReady = NO;
    if (self.skipFromVC == ESQuoteKViewCSkipVCFavorite) {
        SContract *contract = [[QuoteData sharedQuoteData] favContract:_contract next:up];
        [self setContract:contract];
    } else if (self.skipFromVC == ESQuoteKViewCSkipVCQuote) {
        SContract *contract = [[QuoteData sharedQuoteData] currentContract:_contract next:up];
        [self setContract:contract];
    } else {
        OptionData *data = [[OptionData alloc] init];
        SContract *contract = [data optionContract:_contract next:up];
        [self setContract:contract];
    }
}






#pragma mark - api callback
//行情回调
- (void) onQuote:(const SServiceInfo *) service
{
    if(!strcmp(service->ContractNo, self.contract->ContractNo))
    {
        SQuoteSnapShot snap;
        S_GetSnapShot(self.contract->ContractNo, &snap);
        [self.quoteBetView setData:&snap setContract:self.contract];
        [self.futuresBV showBets:&snap contract:self.contract];
    }
}
//历史行情回调
- (void) onHisQuote:(const SServiceInfo *) service
{
    switch (service->SrvSrc) {
        case S_SRVSRC_HISQUOTE:
        {
            if(!strcmp(service->ContractNo, self.contract->ContractNo)){
                if(service->KLineType == S_KLINE_DAY || service->KLineType == S_KLINE_MINUTE){
                    if(!_dataReady){
                        _dataReady = true;
                        [self refreshHisQuoteData:ChangeDataTypeNormal];
                    }else{
                        _dataReady = true;
                        [self refreshHisQuoteData:ChangeDataTypeQuote];
                    }
                }else if(service->KLineType == 0){
                    SQuoteSnapShot snap;
                    S_GetSnapShot(self.contract->ContractNo, &snap);
                    [self.quoteBetView setData:&snap setContract:self.contract];
                    if (!_futuresBV.hidden) {
                        [self.futuresBV showBets:&snap contract:self.contract];
                    }
                    if(!_dataReady){
                        [self refreshHisQuoteData:ChangeDataTypeNormal];
                    }
                }
            }
        }
            break;
        default:
            break;
    }
    switch (service->SrvEvent) {
        case S_SRVEVENT_CONNECT:
            NSLog(@"srvent connect ");
            
            break;
            
        case S_SRVEVENT_HISLOGIN:
            NSLog(@"srvent reconnected.");
            
            self.isLost = NO;
            [self willActive];
            _dataReady = true;
            [self.hud hideAnimated:YES];
            [self refreshHisQuoteData:ChangeDataTypeQuote];
            
            break;
        case S_SRVEVENT_DISCONNECT:
            NSLog(@"quote disconnected");
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.label.text = @"行情重新连接...";
            [self.hud showAnimated:YES];
            self.isLost = YES;
            break;
        case S_SRVEVENT_HINITCOMPLETED:
            break;
        case S_SRVEVENT_HISQUOTE:
            NSLog(@"quote his quote 1111");
            break;
        default:
            break;
    }
}

#pragma makr - 监听进入前台和后台

- (void)willActive {
    if (self.isLost) {
    } else {
        SSessionIdType sessionid = 0;
        int iRet = S_SubHisQuote(self.contract->ContractNo, S_KLINE_DAY, &sessionid);
        iRet= S_SubHisQuote(self.contract->ContractNo, S_KLINE_MINUTE, &sessionid);
        S_SubQuote(self.contract->ContractNo);
        self.subHisQuoteCount++;
    }
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];    
    
    for (int index = 0 ; index < self.subHisQuoteCount; index++) {
        S_UnsubHisQuote(_contract->ContractNo);
        S_UnsubHisQuote(_contract->ContractNo);
        S_UnsubQuote(_contract->ContractNo);
    }
    self.subHisQuoteCount = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
