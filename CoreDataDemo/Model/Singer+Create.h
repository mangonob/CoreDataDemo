//
//  Singer+Create.h
//  CoreDataDemo
//
//  Created by Trinity on 16/6/29.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#import "Singer.h"

@interface Singer (Create)
+(Singer *) singerInContext:(NSManagedObjectContext *)context;
+(Singer *) singerInContext:(NSManagedObjectContext *)context withName:(NSString *)name date:(NSDate *)date;
@end
