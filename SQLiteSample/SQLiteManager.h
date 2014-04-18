//
//  SQLiteManager.h
//  SQLiteTest2
//
//  Created by 相澤 隆志 on 2014/04/16.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TypeText        (1)
#define TypeInteger     (2)
#define TypeReal        (3)
#define TypeBLOB        (4)

@interface SQLiteManager : NSObject

+ (SQLiteManager*)sharedSQLiteManager:(NSString*)dbFileName;
- (BOOL)createDB:(NSString*)dbfileName;
- (BOOL)openDB;
- (BOOL)closeDB;
- (BOOL)createTable:(NSString*)tableName  columns:(NSArray*)params;
- (BOOL)insertObject:(NSDictionary*)param, ...;
- (NSArray*)fetchResultOnSelect:(NSString*)selectString whereAndOrder:(NSString*)whereAndOrderString format:(NSArray*)formatResult;

- (void)test;

@end