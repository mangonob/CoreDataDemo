//
//  AppDelegate+CoreData.m
//  CoreDataDemo
//
//  Created by Trinity on 16/6/26.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#import "AppDelegate+CoreData.h"
#import <CoreData/CoreData.h>

@implementation AppDelegate (CoreData)

- (void)saveContext:(NSManagedObjectContext *)managedObjectContext
{
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(NSManagedObjectContext *)createManagedObjectContext
{
    NSManagedObjectContext *context = nil;
    NSPersistentStoreCoordinator *coord = [self createPersistentStoreCoordinator];
    
    if (coord != nil) {
        context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [context setPersistentStoreCoordinator:coord];
    }
    
    return context;
}

-(NSPersistentStoreCoordinator *)createPersistentStoreCoordinator
{
    NSPersistentStoreCoordinator *coord = nil;
    
    NSURL *url = [[[[NSFileManager defaultManager]
                    URLsForDirectory:NSDocumentDirectory
                    inDomains:NSUserDomainMask]
                   lastObject]
                  URLByAppendingPathComponent:@"MOC.sqlite"];
    
    NSError *error = nil;
    coord = [[NSPersistentStoreCoordinator alloc]
             initWithManagedObjectModel:[self createManagedObjectModel]];
    
    if(! [coord addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error] ) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    return coord;
}

-(NSManagedObjectModel *)createManagedObjectModel
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"CoreDataDemo" withExtension:@"momd"];
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
}
@end
