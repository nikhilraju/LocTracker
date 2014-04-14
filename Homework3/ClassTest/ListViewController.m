//
//  ListViewController.m
//  LocTracker
//
//  Created by nikhil raju on 3/28/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "ListViewController.h"
#import <COMSMapManager/COMSMapManager.h>

@interface ListViewController ()
@property (strong) NSMutableArray *favLocArray;
@end

@implementation ListViewController
@synthesize locTableData;

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
    
}
- (void)viewWillAppear:(BOOL)animated
{
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.locTableData=appDelegate.sharedResultDictionaryArray;
    
    if([self.locTableData count]==0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Results Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
    [self.resTable reloadData];
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
    return self.locTableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIButton *favoriteButton =[UIButton buttonWithType:UIButtonTypeCustom];
    favoriteButton.frame = CGRectMake(275.0f, 5.0f, 30.0f, 30.0f);
    [cell addSubview:favoriteButton];

    [favoriteButton addTarget:self
                     action:@selector(favButton:)
           forControlEvents:UIControlEventTouchUpInside];
    [favoriteButton setBackgroundImage:[UIImage imageNamed:@"greyStar.png"] forState:UIControlStateNormal];
    
    // Configure the cell...
    cell.textLabel.text = [[[[self.locTableData objectAtIndex:indexPath.row] objectForKey:@"name"]stringByAppendingString:@" "] stringByAppendingString:[[self.locTableData objectAtIndex:indexPath.row] objectForKey:@"distance"]];
    
    NSString *objId = [[NSString alloc] init];
    objId = [[self.locTableData objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    NSManagedObjectContext *contextobj= self.managedObjectContext;
    
    NSFetchRequest *getData = [[NSFetchRequest alloc] initWithEntityName:@"FavLoc"];
    getData.predicate = [NSPredicate predicateWithFormat:@"(objId = %@)", objId];
    NSArray *contextArray = [contextobj executeFetchRequest:getData error:nil];
    
    if(contextArray.count ==0)
    {
        NSLog(@"already there unselect");

        [favoriteButton setBackgroundImage:[UIImage imageNamed:@"greyStar.png"] forState:UIControlStateNormal];
        [favoriteButton setSelected:NO];
    }
    else
    {
        NSLog(@"not there select");
        [favoriteButton setBackgroundImage:[UIImage imageNamed:@"yellowStar.png"] forState:UIControlStateNormal];
        [favoriteButton setSelected:YES];
    }

    
    
    return cell;
}
#pragma  Context Management,Inserting and Deleting
- (IBAction)favButton:(id)sender
{

    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    //NSInteger row = indexPath.row;

    
    NSError *error = nil;

    
    UIButton* button = (UIButton* )sender;
    if(button.selected)
    {
        NSLog(@"record delete");
        //When the favorite button is selected and to Unselect the button
        
        
        [button setBackgroundImage:[UIImage imageNamed:@"greyStar.png"] forState:UIControlStateNormal];
        
        
        NSString *objId = [[NSString alloc] init];
        objId = [[self.locTableData objectAtIndex:indexPath.row] objectForKey:@"id"];
        
        NSManagedObjectContext *context= self.managedObjectContext;
        NSFetchRequest *getData = [[NSFetchRequest alloc] initWithEntityName:@"FavLoc"];
        getData.predicate = [NSPredicate predicateWithFormat:@"(objId = %@)", objId];
        NSArray *delArray = [context executeFetchRequest:getData error:&error];
        
        for (NSManagedObject *managedObject in delArray)
        {
            [context deleteObject:managedObject];
        }
       
        
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }

        
        
        [button setSelected:NO];
    }
    else
    {
        NSLog(@"record inserted");
        //select the favorite button when it is not selected 
        appDelegate.sharedCoreData =[appDelegate.sharedResultDictionaryArray objectAtIndex:indexPath.row];
        
        NSManagedObjectContext *context = self.managedObjectContext;
        NSManagedObject *newFavLoc = [NSEntityDescription insertNewObjectForEntityForName:@"FavLoc" inManagedObjectContext:context];
        NSLog(@"Shared Core Data");
        NSString *savedPrice=[[appDelegate.sharedCoreData objectForKey:@"price_level"] stringValue];
        NSString *savedRating=[[appDelegate.sharedCoreData objectForKey:@"rating"] stringValue];
        NSString *savedVicinity=[appDelegate.sharedCoreData objectForKey:@"vicinity"];
        
        //Add the attributes to be saved to Core Data
        [newFavLoc setValue:savedPrice forKey:@"price_level"];
        [newFavLoc setValue:savedRating forKey:@"rating"];
        [newFavLoc setValue:savedVicinity forKey:@"vicinity"];
        [newFavLoc setValue:[appDelegate.sharedCoreData objectForKey:@"name"] forKey:@"name"];
        [newFavLoc setValue:[appDelegate.sharedCoreData objectForKey:@"id"]forKey:@"objId"];
        [newFavLoc setValue:[appDelegate.sharedCoreData objectForKey:@"icon"] forKey:@"icon"];
        [newFavLoc setValue:[[[appDelegate.sharedCoreData objectForKey:@"photos"] objectAtIndex:0] objectForKey:@"photo_reference"]forKey:@"image"];
        
        NSLog(@"Core Data saved");
 

        
        [button setBackgroundImage:[UIImage imageNamed:@"goldStar.png"] forState:UIControlStateNormal];
        [button setSelected:YES];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Add code to display pop up
    UIViewController *popUpView=[self.storyboard instantiateViewControllerWithIdentifier:@"PopUpViewController"];
    [self.navigationController pushViewController:popUpView animated:YES];
    appDelegate.sharedDict=[appDelegate.sharedResultDictionaryArray objectAtIndex:indexPath.row];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
