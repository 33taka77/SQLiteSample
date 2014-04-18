//
//  ViewController.m
//  SQLiteSample
//
//  Created by Aizawa Takashi on 2014/04/18.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import "ViewController.h"
#import "SQLiteManager.h"

@interface ViewController ()
@property (nonatomic, strong) SQLiteManager* sqliteMngr;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _sqliteMngr = [SQLiteManager sharedSQLiteManager:@"testDB2.sqlite3"];
    
    //[_sqliteMngr test];
    
    //[_sqliteMngr createDB:@"testDB2.sqlite3"];
    [_sqliteMngr openDB];
    
    NSDictionary* column1 = @{@"name":@"name", @"type":@"text"};
    NSDictionary* column2 = @{@"name":@"age", @"type":@"integer"};
    NSDictionary* column3 = @{@"name":@"tall", @"type":@"double"};
    
    NSArray* columns = @[column1,column2,column3];
    [_sqliteMngr createTable:@"testTable" columns:columns];
    
    NSDictionary* objectParam1 = @{@"name":@"name", @"type":[NSNumber numberWithInt:TypeText], @"value":@"aizawa"};
    NSDictionary* objectParam2 = @{@"name":@"age", @"type":[NSNumber numberWithInt:TypeInteger], @"value":@47};
    NSDictionary* objectParam3 = @{@"name":@"tall", @"type":[NSNumber numberWithInt:TypeReal], @"value":@173.4};
    
    [_sqliteMngr insertObject:objectParam1,objectParam2,objectParam3,nil];
    
    objectParam1 = @{@"name":@"name", @"type":[NSNumber numberWithInt:TypeText], @"value":@"sato"};
    objectParam2 = @{@"name":@"age", @"type":[NSNumber numberWithInt:TypeInteger], @"value":@35};
    objectParam3 = @{@"name":@"tall", @"type":[NSNumber numberWithInt:TypeReal], @"value":@183.5};
    
    [_sqliteMngr insertObject:objectParam1,objectParam2,objectParam3,nil];
    
    objectParam1 = @{@"name":@"name", @"type":[NSNumber numberWithInt:TypeText], @"value":@"ikeda"};
    objectParam2 = @{@"name":@"age", @"type":[NSNumber numberWithInt:TypeInteger], @"value":@48};
    objectParam3 = @{@"name":@"tall", @"type":[NSNumber numberWithInt:TypeReal], @"value":@168.9};
    
    [_sqliteMngr insertObject:objectParam1,objectParam2,objectParam3,nil];
    
    objectParam1 = @{@"name":@"name", @"type":[NSNumber numberWithInt:TypeText], @"value":@"kimura"};
    objectParam2 = @{@"name":@"age", @"type":[NSNumber numberWithInt:TypeInteger], @"value":@24};
    objectParam3 = @{@"name":@"tall", @"type":[NSNumber numberWithInt:TypeReal], @"value":@178.2};
    
    [_sqliteMngr insertObject:objectParam1,objectParam2,objectParam3,nil];
    
    NSString* selectString = @"select * from";
    NSString* whereString = nil;
    
    NSDictionary* resultCol1 = @{@"name":@"name", @"index":[NSNumber numberWithInt:0], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol2 = @{@"name":@"age", @"index":[NSNumber numberWithInt:1], @"type":[NSNumber numberWithInt:TypeInteger]};
    NSDictionary* resultCol3 = @{@"name":@"tall", @"index":[NSNumber numberWithInt:2], @"type":[NSNumber numberWithInt:TypeReal]};
    NSArray* resultFormat = @[resultCol1,resultCol2,resultCol3];
    
    NSArray* results = [_sqliteMngr fetchResultOnSelect:selectString whereAndOrder:whereString format:resultFormat];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
