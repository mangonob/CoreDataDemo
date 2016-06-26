//
//  Song+Create.h
//  CoreDataDemo
//
//  Created by Trinity on 16/6/29.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#import "Song.h"

@interface Song (Create)
+(Song *) songInContext:(NSManagedObjectContext *)context;
+(Song *) songInContext:(NSManagedObjectContext *)context withName:(NSString *)name time:(NSNumber *)time;
@end
