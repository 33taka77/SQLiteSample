//
//  GroupTableViewController.m
//  SQLiteSample
//
//  Created by 相澤 隆志 on 2014/04/21.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import "GroupTableViewController.h"
#import "GroupTableViewCell.h"
#import "AssetManager.h"
#import "RNGridMenu.h"
#import "TableViewHeaderCell.h"

@interface GroupTableViewController () <RNGridMenuDelegate>
@property (nonatomic,strong) NSMutableArray* sections;
@property (nonatomic,strong) NSString* sectionString;
@property (nonatomic,strong) NSMutableArray* sectionItems;
@end

@implementation GroupTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex
{
    NSLog(@"Dismissed with item %ld: %@", (long)itemIndex, item.title);
    if( itemIndex == 0 ){
        [self rebuildSectionItems:@"Model"];
        [self.tableView reloadData];
    }
}

- (void)showGrid {
    NSInteger numberOfOptions = 5;
    NSArray *items = @[
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"camera"] title:@"Camera"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] title:@"Date"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"block"] title:@"Cancel"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"bluetooth"] title:@"Bluetooth"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"cube"] title:@"Deliver"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"download"] title:@"Download"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"enter"] title:@"Enter"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"file"] title:@"Source Code"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"github"] title:@"Github"]
                       ];
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    //    av.bounces = NO;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem* refleshBarbottun = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(selectMenue)];
    self.navigationItem.rightBarButtonItem = refleshBarbottun;
    
    [self rebuildSectionItems:@"sectionDate"];
}

- (void)rebuildSectionItems:(NSString*)sectionName
{
    _sectionString = sectionName;
    NSArray* array = [_groupArray valueForKeyPath:_sectionString];
    if( _sections == nil ){
        _sections = [[NSMutableArray alloc] init ];
    }
    [_sections removeAllObjects];
    for( NSString* name in array ){
        if( ![_sections containsObject:name] ){
            [_sections addObject:name];
        }
    }
    if( _sectionItems == nil){
        _sectionItems = [[NSMutableArray alloc] init];
    }
    [_sectionItems removeAllObjects];
    for( NSString* name in _sections){
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K = %@",sectionName, name];
        NSArray* items = [_groupArray filteredArrayUsingPredicate:predicate];
        [_sectionItems addObject:items];
    }
}

- (void)selectMenue
{
    [self showGrid];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSArray* items = _sectionItems[section];
    return items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupTableCell" forIndexPath:indexPath];
    
    // Configure the cell...
    AssetManager* assetManager = [AssetManager sharedAssetManager];
    NSArray* items = _sectionItems[indexPath.section];
    NSDictionary* info = items[indexPath.row];
    cell.imageView.image = [assetManager getThumbnail:[NSURL URLWithString:[info valueForKey:@"url"]]];
    cell.dateLabel.text = [info valueForKey:@"sectionDate"];
    cell.makerLabel.text = [info valueForKey:@"Maker"];
    cell.modelLabel.text = [info valueForKey:@"Model"];
    return cell;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    TableViewHeaderCell* header = (TableViewHeaderCell*)[tableView dequeueReusableCellWithIdentifier:@"setionHeaderCell"];
    header.headerTitle.text = _sections[section];
    return header;
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
