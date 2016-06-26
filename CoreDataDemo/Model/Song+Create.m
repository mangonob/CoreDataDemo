//
//  Song+Create.m
//  CoreDataDemo
//
//  Created by Trinity on 16/6/29.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#import "Song+Create.h"

@implementation Song (Create)

+(Song *) songInContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Song"
                                         inManagedObjectContext:context];
}

+(Song *) songInContext:(NSManagedObjectContext *)context
               withName:(NSString *)name
                   time:(NSNumber *)time
{
    Song *s = [self songInContext:context];
    s.name = name;
    s.time = time;
    return s;
}
@end
