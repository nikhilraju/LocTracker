//
//  FavoritesTableViewController.h
//  LocTracker
//
//  Created by nikhil raju on 4/6/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COMSAppDelegate.h"


@interface FavoritesTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>{
    COMSAppDelegate *appDelegate;
}
@property (nonatomic, retain) NSMutableArray *favTableData;
@property (strong, nonatomic) IBOutlet UITableView *favTable;

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSManagedObject *managedObject;
@property (strong,nonatomic) NSManagedObjectModel *managedObjectModel;


@end
