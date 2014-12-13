//
//  DatabaseManager.m
//  Eczaplus
//
//  Created by Selim Bakdemir on 05.11.13.
//  Copyright (c) 2013 Concept Factory. All rights reserved.
//

#import "DatabaseManager.h"
#import "FileManager.h"

static NSString * databasePath = @"";

@implementation AsyncDBOperation

-(void)main
{
    DatabaseManager * manager = self.dbManager;
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
    [queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *resultSet = [db
                                  executeQuery:manager.databaseQuery.sql
                                  withArgumentsInArray:manager.databaseQuery.arguments];
        
        NSMutableArray *arr = [manager convertResultSet:resultSet];
        
        BOOL isEmpty = [arr count] > 0;
        manager.completionBlock(arr,isEmpty);
        
    }];
}

@end



@implementation DatabaseManager

-(id)initWithDatabase:(NSString *)databaseFilename
{
    if ([super init]) {
        
        NSString * path = [NSString stringWithFormat:@"databases/%@",databaseFilename];
        databasePath = [[FileManager documentsDirectory] stringByAppendingString:path];
    }
    
    return self;
}

-(BOOL)open
{
    self.database = [FMDatabase databaseWithPath:databasePath];
    
    BOOL opened = [self.database open];
    if (!opened) {
        self.database = nil;
    }
    
    return opened;
}

-(void)queryAsyncWithParser:(ConvertBlock)b completion:(FMDBCompletionBlock)completion forSql:(SqliteQuery *)query
{
    self.block              = b;
    self.completionBlock    = completion;
    self.databaseQuery      = query;
    
    AsyncDBOperation *asyncOperation = [AsyncDBOperation new];
    asyncOperation.dbManager = self;
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:asyncOperation];
}

-(void)queryWithParser:(ConvertBlock)b completion:(FMDBCompletionBlock)completion forSql:(SqliteQuery *)query
{
    self.block              = b;

    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
    [queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *resultSet = [db
                                  executeQuery:query.sql
                                  withArgumentsInArray:query.arguments];
        
        NSMutableArray *arr = [self convertResultSet:resultSet];
        
        BOOL isEmpty = [arr count] > 0;
        completion(arr,isEmpty);
        
    }];
}

-(NSMutableArray *)convertResultSet:(FMResultSet *)resultSet
{
    NSMutableArray *arr = [NSMutableArray new];
    
    while ([resultSet next]) {
        id row = self.block(resultSet);
        [arr addObject:row];
    }
    
    return arr;
}


@end
