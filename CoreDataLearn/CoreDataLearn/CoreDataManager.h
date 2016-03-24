//
//  CoreDataManager.h
//  CoreDataLearn
//
//  Created by John on 16/3/24.
//  Copyright © 2016年 John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "News.h"

@interface CoreDataManager : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)insertCoreData:(NSMutableArray *)dataArray;
- (NSMutableArray *)selectData:(int)pageSize andOffset:(int)currentPage;
- (void)deleData;
- (void)updateData:(NSString *)newId withIsLook:(NSString *)islook;








@end
