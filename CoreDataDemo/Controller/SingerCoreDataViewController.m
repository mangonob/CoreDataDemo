//
//  SingerCoreDataViewController.m
//  CoreDataDemo
//
//  Created by Trinity on 16/6/27.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#import "SingerCoreDataViewController.h"
#import "Singer.h"

@implementation SingerCoreDataViewController

#pragma mark - TableView DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView
                             dequeueReusableCellWithIdentifier:@"SingerCell"];
    Singer *singer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = singer.name;
    cell.detailTextLabel.text = singer.detail;
    return cell;
}

-(IBAction)singerCoreDataViewControllerUnwind:(UIStoryboardSegue *) segue
{
}

#pragma mark - Setter & Getter

-(void)setContext:(NSManagedObjectContext *)context
{
    _context = context;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Singer"];
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:@"name"
                                 ascending:YES
                                 selector:@selector(localizedStandardCompare:)]];
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:request
                                     managedObjectContext:self.context
                                     sectionNameKeyPath:nil
                                     cacheName:nil];
}
@end
