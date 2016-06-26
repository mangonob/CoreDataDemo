//
//  Singer+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by Trinity on 16/6/29.
//  Copyright © 2016年 Trinity. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Singer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Singer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *age;
@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Song *> *songs;

@end

@interface Singer (CoreDataGeneratedAccessors)

- (void)addSongsObject:(Song *)value;
- (void)removeSongsObject:(Song *)value;
- (void)addSongs:(NSSet<Song *> *)values;
- (void)removeSongs:(NSSet<Song *> *)values;

@end

NS_ASSUME_NONNULL_END
