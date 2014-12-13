//
//  SqliteQuery.m
//  Eczaplus
//
//  Created by Selim on 20.01.14.
//  Copyright (c) 2014 Concept Factory. All rights reserved.
//

#import "SqliteQuery.h"

@implementation SqliteQuery

+(SqliteQuery *)queryWithString:(NSString *)sql andArguments:(NSArray *)arguments
{
    SqliteQuery *instance = [SqliteQuery new];
    instance.sql = sql;
    instance.arguments = arguments;
    
    return instance; 
}

@end
