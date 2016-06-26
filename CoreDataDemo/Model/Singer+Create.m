//
//  Singer+Create.m
//  CoreDataDemo
//
//  Created by Trinity on 16/6/29.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#import "Singer+Create.h"

@implementation Singer (Create)
+(Singer *) singerInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription
            insertNewObjectForEntityForName:@"Singer"
            inManagedObjectContext:context];
}
+(Singer *) singerInContext:(NSManagedObjectContext *)context
                   withName:(NSString *)name date:(NSDate *)date;
{
    Singer *s = [self singerInContext:context];
    s.name = name;
    s.age = date;
    return s;
}
@end
