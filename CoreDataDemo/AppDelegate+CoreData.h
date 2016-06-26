//
//  AppDelegate+CoreData.h
//  CoreDataDemo
//
//  Created by Trinity on 16/6/26.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (CoreData)
-(NSManagedObjectContext *)createManagedObjectContext;
-(void)saveContext:(NSManagedObjectContext *)managedObjectContext;
@end
