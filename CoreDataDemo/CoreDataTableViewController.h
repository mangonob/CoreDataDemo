//
//  CoreDataTableViewController.h
//  CoreDataDemo
//
//  Created by Trinity on 16/6/26.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#include <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface CoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

-(void)performFetching;

@end
