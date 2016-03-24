//
//  ViewController.h
//  CoreDataLearn
//
//  Created by John on 16/3/23.
//  Copyright © 2016年 John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCell.h"
#import "CoreDataManager.h"
@interface ViewController : UIViewController
{
    CoreDataManager *coreManager;
    __weak IBOutlet UITableView *newsTableView;
}

@property (nonatomic, strong) NSMutableArray *resultArray;

@end

