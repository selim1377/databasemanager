//
//  FileManager.h
//  Eczaplus
//
//  Created by Selim Bakdemir on 06.11.13.
//  Copyright (c) 2013 Concept Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+(NSString *)documentsDirectory;
+(BOOL)fileExists:(NSString *)filePath;
+(void)copyItem:(NSString *)bundleFileName toPath:(NSString *)targetPath;
+(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
+(void)listFiles;
@end
