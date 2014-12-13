//
//  DatabaseManager.h
//  Eczaplus
//
//  Created by Selim Bakdemir on 05.11.13.
//  Copyright (c) 2013 Concept Factory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>
#import "SqliteQuery.h"

typedef id (^ConvertBlock)(FMResultSet *resultSet);
typedef void (^FMDBCompletionBlock)(NSMutableArray *results, BOOL isEmpty);

@class DatabaseManager;
@interface AsyncDBOperation : NSOperation

@property (nonatomic, strong) DatabaseManager *dbManager;

@end


@interface DatabaseManager : NSObject

@property (strong, nonatomic)   FMDatabase      *database;
@property (copy, nonatomic)     ConvertBlock    block;
@property (copy, nonatomic)     FMDBCompletionBlock    completionBlock;
@property (nonatomic, strong)   SqliteQuery *databaseQuery;

-(id)initWithDatabase:(NSString *)databaseFilename;
-(BOOL)open;
-(NSMutableArray *)convertResultSet:(FMResultSet *)resultSet;
-(void)queryWithParser:(ConvertBlock)b completion:(FMDBCompletionBlock)completion forSql:(SqliteQuery *)query;
-(void)queryAsyncWithParser:(ConvertBlock)b completion:(FMDBCompletionBlock)completion forSql:(SqliteQuery *)query;

@end
