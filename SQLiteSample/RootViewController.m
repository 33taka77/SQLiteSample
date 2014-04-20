//
//  RootViewController.m
//  SQLiteSample
//
//  Created by 相澤 隆志 on 2014/04/18.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import "RootViewController.h"
#import "SQLiteManager.h"
#import "AssetManager.h"
#import "RootTableViewCell.h"

const NSString* cDBFileName = @"ImageInfo.sqlite3";

@interface RootViewController ()  <AssetLibraryDelegate>
@property (nonatomic, strong) NSMutableArray* fetchResultArray;
//@property (nonatomic, strong) NSArray* fetchResultArray;
@end

@implementation RootViewController

- (void)updateGroupDataGroupURL:(NSURL *)groupUrl
{
    [self.tableView reloadData];
}

- (void)updateItemDataItemURL:(NSURL *)url groupURL:(NSURL *)groupUrl
{
    AssetManager* assetManager = [AssetManager sharedAssetManager];
    
    NSDictionary* metaData = [assetManager getMetaDataByURL:url];
    //UIImage* thumbnail = [assetManager getThumbnail:url];
    //UIImage* aspectThumbnail = [assetManager getThumbnailAspect:url];

    SQLiteManager* sqlManager = [SQLiteManager sharedSQLiteManager:(NSString*)cDBFileName];
    
    NSDictionary* objectParam1 = @{@"name":@"DateTimeOriginal", @"type":[NSNumber numberWithInt:TypeReal], @"value":[NSNumber numberWithDouble:[self convertUnixDateTime:[metaData valueForKey:@"DateTimeOriginal"]]] };
    NSDictionary* objectParam2 = @{@"name":@"groupName", @"type":[NSNumber numberWithInt:TypeText], @"value":[assetManager getGroupNameByURL:groupUrl]};
    NSDictionary* objectParam3 = @{@"name":@"sectionDate", @"type":[NSNumber numberWithInt:TypeText], @"value":[self makeShortDateString:[metaData valueForKey:@"DateTimeOriginal"]]};
    NSDictionary* objectParam4 = @{@"name":@"url", @"type":[NSNumber numberWithInt:TypeText], @"value":[url absoluteString]};
    NSDictionary* objectParam5 = @{@"name":@"groupUrl", @"type":[NSNumber numberWithInt:TypeText], @"value":[groupUrl absoluteString]};
    NSDictionary* objectParam6 = @{@"name":@"Model", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"Model"]};
    NSDictionary* objectParam7 = @{@"name":@"Maker", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"Maker"]};
    
    NSDictionary* objectParam8 = @{@"name":@"ExposureTime", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"ExposureTime"]};
    NSDictionary* objectParam9 = @{@"name":@"FocalLength", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"FocalLength"]};
    NSDictionary* objectParam10 = @{@"name":@"Orientation", @"type":[NSNumber numberWithInt:TypeInteger], @"value":[self cnvertNumber: [metaData valueForKey:@"Orientation"]]};
    NSDictionary* objectParam11 = @{@"name":@"Artist", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"Artist"]};
    NSDictionary* objectParam12 = @{@"name":@"FNumber", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"FNumber"]};
    NSDictionary* objectParam13 = @{@"name":@"ISO", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"ISO"]};
    NSDictionary* objectParam14 = @{@"name":@"MaxApertureValue", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"MaxApertureValue"]};
    NSDictionary* objectParam15 = @{@"name":@"ExposureCompensation", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"ExposureCompensation"]};
    NSDictionary* objectParam16 = @{@"name":@"Flash", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"Flash"]};
    NSDictionary* objectParam17 = @{@"name":@"LensInfo", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"LensInfo"]};
    NSDictionary* objectParam18 = @{@"name":@"LensInfo", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"LensInfo"]};
    NSDictionary* objectParam19 = @{@"name":@"Lens", @"type":[NSNumber numberWithInt:TypeText], @"value":[metaData valueForKey:@"Lens"]};

    [sqlManager insertObject:objectParam1,objectParam2,objectParam3,objectParam4,objectParam5,objectParam6,objectParam7,objectParam8,objectParam9,objectParam10,objectParam11,objectParam12,objectParam13,objectParam14,objectParam15,objectParam16,objectParam17,objectParam18,objectParam19,nil];
    
}

- (NSString*)makeShortDateString:(NSString*)dateTime
{
    NSArray* strArray = [dateTime componentsSeparatedByString:@" "];
    NSString* str = [strArray[0] stringByReplacingOccurrencesOfString:@":" withString:@"/"];
    NSString* str2 = [str stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    return str2;
    
    //NSDate* date = [self dateTime:dateTime];
    //return [self dateTimeString:date];
}

- (double)convertUnixDateTime:(NSString*)dateTimeString
{
    NSDate* date = [self dateTime:dateTimeString];
    double seconds = [date timeIntervalSince1970];
    return seconds;
}

- (NSDate*)convertUnixDataToNSDate:(double)time
{
    NSDate* nsDate = [NSDate dateWithTimeIntervalSince1970:time];
    return nsDate;
}
- (NSString*)dateTimeString:(NSDate*)dateTime
{
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    [inputDateFormatter setDateFormat:@"yyyy/mm/dd"];
    return [inputDateFormatter stringFromDate:dateTime];
    
}

- (NSDate*)dateTime:(NSString*)dateTime
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"YYYY:MM:DD HH:MM:SS"];
    NSDate *formatterDate = [inputFormatter dateFromString:dateTime];
    if(formatterDate == nil){
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
        formatterDate = [inputFormatter dateFromString:dateTime];
        if( formatterDate == nil ){
            formatterDate = 0;
        }
    }
    return formatterDate;
}

- (NSNumber*)cnvertNumber:(NSString*)number
{
    int num = [number intValue];
    return [NSNumber numberWithInt:num];
}

- (void)createMainTable
{
    SQLiteManager* sqlManager = [SQLiteManager sharedSQLiteManager:(NSString*)cDBFileName];
    NSDictionary* column1 = @{@"name":@"DateTimeOriginal", @"type":@"double"};
    NSDictionary* column2 = @{@"name":@"groupName", @"type":@"text"};
    NSDictionary* column3 = @{@"name":@"sectionDate", @"type":@"text"};
    NSDictionary* column4 = @{@"name":@"url", @"type":@"text"};
    NSDictionary* column5 = @{@"name":@"groupUrl", @"type":@"text"};
    NSDictionary* column6 = @{@"name":@"Model", @"type":@"text"};
    NSDictionary* column7 = @{@"name":@"Maker", @"type":@"text"};
    NSDictionary* column8 = @{@"name":@"ExposureTime", @"type":@"text"};
    NSDictionary* column9 = @{@"name":@"FocalLength", @"type":@"text"};
    NSDictionary* column10 = @{@"name":@"Orientation", @"type":@"integer"};
    NSDictionary* column11 = @{@"name":@"Artist", @"type":@"text"};
    NSDictionary* column12 = @{@"name":@"FNumber", @"type":@"text"};
    NSDictionary* column13 = @{@"name":@"ISO", @"type":@"text"};
    NSDictionary* column14 = @{@"name":@"MaxApertureValue", @"type":@"text"};
    NSDictionary* column15 = @{@"name":@"ExposureCompensation", @"type":@"text"};
    NSDictionary* column16 = @{@"name":@"Flash", @"type":@"text"};
    NSDictionary* column17 = @{@"name":@"LensInfo", @"type":@"text"};
    NSDictionary* column18 = @{@"name":@"LensModel", @"type":@"text"};
    NSDictionary* column19 = @{@"name":@"Lens", @"type":@"text"};

    
    NSArray* columns = @[column1,column2,column3,column4,column5,column6,column7,column8,column9,column10,column11,column12,column13,column14,column15,column16,column17,column18,column19 ];
    [sqlManager createTable:@"imageInfoTable" columns:columns];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem* deleteBarbottun = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteImage)];
    self.navigationItem.leftBarButtonItem = deleteBarbottun;
    
    UIBarButtonItem* refleshBarbottun = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refleshImage)];
    self.navigationItem.rightBarButtonItem = refleshBarbottun;
    
    AssetManager* assetManager = [AssetManager sharedAssetManager];
    assetManager.delegate = (id)self;
    [assetManager setAssetManagerModeIsHoldItemData:NO];
    
    SQLiteManager* sqlManager = [SQLiteManager sharedSQLiteManager:(NSString*)cDBFileName];
    [sqlManager openDB];
    [self createMainTable];
    
    _fetchResultArray = [self performSelect:@"select * from" where:@"where Maker = 'Apple' order by sectionDate asc"];
    
    /*
    NSDictionary* resultCol1 = @{@"name":@"DateTimeOriginal", @"index":[NSNumber numberWithInt:0], @"type":[NSNumber numberWithInt:TypeReal]};
    NSDictionary* resultCol2 = @{@"name":@"groupName", @"index":[NSNumber numberWithInt:1], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol3 = @{@"name":@"sectionDate", @"index":[NSNumber numberWithInt:2], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol4 = @{@"name":@"url", @"index":[NSNumber numberWithInt:3], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol5 = @{@"name":@"groupUrl", @"index":[NSNumber numberWithInt:4], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol6 = @{@"name":@"Model", @"index":[NSNumber numberWithInt:5], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol7 = @{@"name":@"Maker", @"index":[NSNumber numberWithInt:6], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol8 = @{@"name":@"ExposureTime", @"index":[NSNumber numberWithInt:7], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol9 = @{@"name":@"FocalLength", @"index":[NSNumber numberWithInt:8], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol10 = @{@"name":@"Orientation", @"index":[NSNumber numberWithInt:9], @"type":[NSNumber numberWithInt:TypeInteger]};
    NSDictionary* resultCol11 = @{@"name":@"Artist", @"index":[NSNumber numberWithInt:10], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol12 = @{@"name":@"FNumber", @"index":[NSNumber numberWithInt:11], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol13 = @{@"name":@"ISO", @"index":[NSNumber numberWithInt:12], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol14 = @{@"name":@"MaxApertureValue", @"index":[NSNumber numberWithInt:13], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol15 = @{@"name":@"ExposureCompensation", @"index":[NSNumber numberWithInt:14], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol16 = @{@"name":@"Flash", @"index":[NSNumber numberWithInt:15], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol17 = @{@"name":@"LensInfo", @"index":[NSNumber numberWithInt:16], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol18 = @{@"name":@"LensModel", @"index":[NSNumber numberWithInt:17], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol19 = @{@"name":@"Lens", @"index":[NSNumber numberWithInt:18], @"type":[NSNumber numberWithInt:TypeText]};
    NSArray* resultFormat = @[resultCol1,resultCol2,resultCol3,resultCol4,resultCol5,resultCol6,resultCol7,resultCol8,resultCol9,resultCol10,resultCol11,resultCol12,resultCol13,resultCol14,resultCol15,resultCol16,resultCol17,resultCol18,resultCol19];

    NSString* selectString = @"select * from";
    NSString* whereString = @"where Maker = 'Apple' order by sectionDate asc";

    _fetchResultArray = [NSMutableArray arrayWithArray:[sqlManager fetchResultOnSelect:selectString whereAndOrder:whereString format:resultFormat]];
    //_fetchResultArray = [sqlManager fetchResultOnSelect:selectString whereAndOrder:whereString format:resultFormat];
    NSArray* array = [_fetchResultArray valueForKeyPath:@"Model"];
    NSLog(@"count =%d",array.count);
    */
 }

- (NSMutableArray*)performSelect:(NSString*)selectString where:(NSString*)whereString
{
    NSDictionary* resultCol1 = @{@"name":@"DateTimeOriginal", @"index":[NSNumber numberWithInt:0], @"type":[NSNumber numberWithInt:TypeReal]};
    NSDictionary* resultCol2 = @{@"name":@"groupName", @"index":[NSNumber numberWithInt:1], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol3 = @{@"name":@"sectionDate", @"index":[NSNumber numberWithInt:2], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol4 = @{@"name":@"url", @"index":[NSNumber numberWithInt:3], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol5 = @{@"name":@"groupUrl", @"index":[NSNumber numberWithInt:4], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol6 = @{@"name":@"Model", @"index":[NSNumber numberWithInt:5], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol7 = @{@"name":@"Maker", @"index":[NSNumber numberWithInt:6], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol8 = @{@"name":@"ExposureTime", @"index":[NSNumber numberWithInt:7], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol9 = @{@"name":@"FocalLength", @"index":[NSNumber numberWithInt:8], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol10 = @{@"name":@"Orientation", @"index":[NSNumber numberWithInt:9], @"type":[NSNumber numberWithInt:TypeInteger]};
    NSDictionary* resultCol11 = @{@"name":@"Artist", @"index":[NSNumber numberWithInt:10], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol12 = @{@"name":@"FNumber", @"index":[NSNumber numberWithInt:11], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol13 = @{@"name":@"ISO", @"index":[NSNumber numberWithInt:12], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol14 = @{@"name":@"MaxApertureValue", @"index":[NSNumber numberWithInt:13], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol15 = @{@"name":@"ExposureCompensation", @"index":[NSNumber numberWithInt:14], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol16 = @{@"name":@"Flash", @"index":[NSNumber numberWithInt:15], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol17 = @{@"name":@"LensInfo", @"index":[NSNumber numberWithInt:16], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol18 = @{@"name":@"LensModel", @"index":[NSNumber numberWithInt:17], @"type":[NSNumber numberWithInt:TypeText]};
    NSDictionary* resultCol19 = @{@"name":@"Lens", @"index":[NSNumber numberWithInt:18], @"type":[NSNumber numberWithInt:TypeText]};
    NSArray* resultFormat = @[resultCol1,resultCol2,resultCol3,resultCol4,resultCol5,resultCol6,resultCol7,resultCol8,resultCol9,resultCol10,resultCol11,resultCol12,resultCol13,resultCol14,resultCol15,resultCol16,resultCol17,resultCol18,resultCol19];
    
    SQLiteManager* sqlManager = [SQLiteManager sharedSQLiteManager:(NSString*)cDBFileName];
    return [NSMutableArray arrayWithArray:[sqlManager fetchResultOnSelect:selectString whereAndOrder:whereString format:resultFormat]];

}
- (void)deleteImage
{
    SQLiteManager* sqlManager = [SQLiteManager sharedSQLiteManager:(NSString*)cDBFileName];
    if( [sqlManager deleteObjectWhere:nil] == YES ){
        [_fetchResultArray removeAllObjects];
    }
    [self.tableView reloadData];
}

- (void)refleshImage
{
    AssetManager* assetManager = [AssetManager sharedAssetManager];
    [assetManager enumeAssetItems];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _fetchResultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RootTableCell" forIndexPath:indexPath];
    
    // Configure the cell...
    AssetManager* assetManager = [AssetManager sharedAssetManager];
    
    NSDictionary* info = _fetchResultArray[indexPath.row];
    UIImage* image = [assetManager getThumbnail:[NSURL URLWithString:[info valueForKey:@"url"]]];
    cell.imageView.image = image;
    cell.dateTime.text = [self dateTimeString:[self convertUnixDataToNSDate:[[info valueForKey:@"DateTimeOriginal"] doubleValue]]];
    cell.model.text = [info valueForKey:@"Model"];
    cell.maker.text = [info valueForKey:@"Maker"];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
