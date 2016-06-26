//
//  Song+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by Trinity on 16/6/29.
//  Copyright © 2016年 Trinity. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Song.h"

NS_ASSUME_NONNULL_BEGIN

@interface Song (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *time;
@property (nullable, nonatomic, retain) Singer *singer;

@end

NS_ASSUME_NONNULL_END
