//
//  ViewController.m
//  CoreDataLearn
//
//  Created by John on 16/3/23.
//  Copyright © 2016年 John. All rights reserved.
//

#import "ViewController.h"
#import "JSONKit.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", NSHomeDirectory());
    
    coreManager = [[CoreDataManager alloc] init];
    
    //更新时间
    NSString *updateDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"updateDate"];
    
    if (!updateDate) {
        //如果无此对象，表示第一次，那么就读数据写到数据库中
        [self writeDate];
        
    }else{
        //有此对象说明只要从数据库中读数据
        NSTimeInterval update = updateDate.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        //8小时一更新
        if ((now - update)>8*60*60) {
            //如果超出八小时就把数据库清空再重新写
            [coreManager deleData];
            [self writeDate];
        }else{
            //没有超过8小时就从数据库中读
            NSMutableArray *array = [coreManager selectData:3 andOffset:2];
            _resultArray = [NSMutableArray arrayWithArray:array];
            [newsTableView reloadData];
        }
    }
    
    

}

- (void)writeDate {
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]] forKey:@"updateDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"News" ofType:@"txt"];
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [data objectFromJSONString];
    
    _resultArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in array) {
        News *info = [[News alloc] initWithDictionary:dict];
        [_resultArray addObject:info];
    }
    
    [coreManager insertCoreData:_resultArray];
    [newsTableView reloadData];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
        cell = [cells lastObject];
    }
    News *info = [_resultArray objectAtIndex:indexPath.row];
    [cell setContent:info];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当你点击时说明要看此条新闻，那么就标注此新闻已被看过
    News *info = [_resultArray objectAtIndex:indexPath.row];
    info.islook = @"1";
    [coreManager updateData:info.newsid withIsLook:@"1"];
    [_resultArray setObject:info atIndexedSubscript:indexPath.row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
