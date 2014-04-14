//
//  FavoritesTableViewController.m
//  LocTracker
//
//  Created by nikhil raju on 4/6/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "FavoritesTableViewController.h"


@interface FavoritesTableViewController ()
{
    NSManagedObjectContext *record;
}

@end


@implementation FavoritesTableViewController
@synthesize favTableData;
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
    NSLog(@"Reached ViewDidLoad FavTab");
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    appDelegate=[[UIApplication sharedApplication] delegate];
    //self.locTableData=appDelegate.sharedResultDictionaryArray;
    
    //NSLog(@"------>%@",self.locTableData);
    NSLog(@"Fav View Will Appear called");
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"FavLoc"];
    
    self.favTableData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
   NSLog(@"FAV Debugging----------------- ");
    
   // NSLog(@"fav table---> %@",self.favTableData);

    if([self.favTableData count]==0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Results Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
     [self.tableView reloadData];
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
    return self.favTableData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FavCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavCellIdentifier"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    record = [self.favTableData objectAtIndex:indexPath.row];
    NSLog(@"*******record-------%@",[record valueForKey:@"objId"]);
    //NSString* v=[record valueForKey:@"vicinity"];
    //NSString* r=[record valueForKey:@"rating"];
    //NSString* p=[record valueForKey:@"price_level"];
    
    cell.textLabel.text = [record valueForKey:@"name"];
    cell.detailTextLabel.text=@"nikhil";
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

#pragma Delete From Favorites
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = [self managedObjectContext];
        [context deleteObject:[self.favTableData objectAtIndex:indexPath.row]];
        
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }

        // Delete the row from the data source
        
        [self.favTableData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


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

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
@end