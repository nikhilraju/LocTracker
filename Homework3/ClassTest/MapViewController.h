//
//  MapViewController.h
//  LocTracker
//
//  Created by Nikhil Raju on 2/10/14.
//  Uni nr2483

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "COMSAppDelegate.h"

//Importing Core Location
@import CoreLocation;

@interface MapViewController : UIViewController<CLLocationManagerDelegate>{
    COMSAppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic,strong) id infoRequest;
@property (strong, nonatomic) IBOutlet UISlider *mySlider;
-(IBAction)sliderChanged:(id)sender;
@end
