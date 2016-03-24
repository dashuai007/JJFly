//
//  CoreDataManager.m
//  CoreDataLearn
//
//  Created by John on 16/3/24.
//  Copyright © 2016年 John. All rights reserved.
//

#import "CoreDataManager.h"
#define TableName @"News"
@implementation CoreDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coorinator = [self persistentStoreCoordinator];
    if (coorinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coorinator];
    }
    NSLog(@"create NSManagedObjectContext");
    return _managedObjectContext;
    
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataLearn" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSLog(@"create NSManagedObjectModel");
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NewsModel.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSLog(@"create NSPersistentStoreCoordinator");
    return _persistentStoreCoordinator;
}


- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)insertCoreData:(NSMutableArray *)dataArray {
    NSManagedObjectContext *context = [self managedObjectContext];
    for (News *info in dataArray) {
        News *newsInfo = (News *)[NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
        newsInfo.newsid = info.newsid;
        newsInfo.title = info.title;
        newsInfo.imgurl = info.imgurl;
        newsInfo.descr = info.descr;
        newsInfo.islook = info.islook;
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"can't save :%@", [error localizedDescription]);
        }
    }
}


- (void)deleData {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count]) {
        for (NSManagedObject *obj in datas) {
            [context deleteObject:obj];
        }
        if (![context save:&error]) {
            NSLog(@"error dele:%@", error);
        }
    }
    
}

- (NSMutableArray *)selectData:(int)pageSize andOffset:(int)currentPage {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setFetchLimit:pageSize];
    [fetchRequest setFetchOffset:currentPage];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (News *info in fetchedObjects) {
        NSLog(@"id:%@", info.newsid);
        [resultArray addObject:info];
    }
    return  resultArray;
}


- (void)updateData:(NSString *)newId withIsLook:(NSString *)islook {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"newsid like[cd] %@", newId];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:TableName inManagedObjectContext:context]];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    for (News *news in result) {
        news.islook = islook;
    }
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
}



@end
