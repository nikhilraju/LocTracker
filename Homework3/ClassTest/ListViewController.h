//
//  ListViewController.h
//  LocTracker
//
//  Created by nikhil raju on 3/28/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COMSAppDelegate.h"


@interface ListViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>{
    COMSAppDelegate *appDelegate;
}
@property (nonatomic, retain) NSMutableArray *locTableData;
@property (strong, nonatomic) IBOutlet UITableView *resTable;

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSManagedObject *managedObject;
@property (strong,nonatomic) NSManagedObjectModel *managedObjectModel;
@end
