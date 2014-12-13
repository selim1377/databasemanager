//
//  SqliteQuery.h
//  Eczaplus
//
//  Created by Selim on 20.01.14.
//  Copyright (c) 2014 Concept Factory. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@interface SqliteQuery : NSObject

@property (nonatomic, strong) NSString *sql;
@property (nonatomic, strong) NSArray *arguments;

+(SqliteQuery *)queryWithString:(NSString *)sql andArguments:(NSArray *)arguments;

@end
