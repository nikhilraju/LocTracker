//
//  COMSAppDelegate.h
//  LocTracker
//
//  Created by Nikhil Raju on 2/10/14.
//  Uni nr2483

#import <UIKit/UIKit.h>

@interface COMSAppDelegate : UIResponder <UIApplicationDelegate>

//Using App Delegate Properties to share dictionaries/arrays of dictionaries of results across the application
//testing git 2
@property (retain,nonatomic) NSMutableArray *sharedResultDictionaryArray;
@property (retain,nonatomic) NSMutableDictionary *sharedDict;
@property (retain,nonatomic) NSMutableDictionary *sharedCoreData;

@property (strong, nonatomic) UIWindow *window;
//Context Management fot Core Data
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end
