//
//  FileManager.m
//  Eczaplus
//
//  Created by Selim Bakdemir on 06.11.13.
//  Copyright (c) 2013 Concept Factory. All rights reserved.
//

#import "FileManager.h"
#include <sys/xattr.h>

@implementation FileManager

+(NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingString:@"/appdata/"];
    
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory])
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:&error];
    
    return documentsDirectory;
}

+(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{ 
    if (&NSURLIsExcludedFromBackupKey == nil) { // iOS <= 5.0.1
        const char* filePath = [[URL path] fileSystemRepresentation];
        
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    }
    else { // iOS >= 5.1
        NSError *error = nil;
        [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
        return error == nil;
    }
}

+(void)listFiles
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:[FileManager documentsDirectory] error:nil];
    for (NSString *s in fileList){
        NSLog(@"%@", s);
    }
}


@end
