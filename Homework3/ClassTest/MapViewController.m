//
//  MapViewController.m
//  LocTracker
//
//  Created by Nikhil Raju on 2/10/14.
//  Uni nr2483

#import "MapViewController.h"
#import <COMSMapManager/COMSMapManager.h>
@interface MapViewController ()

//private location manager
@property (nonatomic, strong)CLLocationManager *locationManager;

@end

@implementation MapViewController
-(void)awakeFromNib{
    
    //instantiate location manager
    self.locationManager = [[CLLocationManager alloc]init];

}
//Min value set is 100 and Max value is 2000
-(IBAction)sliderChanged:(id)sender{
    NSLog(@"SliderValue %f",self.mySlider.value);
    [self.locationManager startUpdatingLocation];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.locationManager=[[CLLocationManager alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
     self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
    [self.mySlider setThumbImage:[UIImage imageNamed:@"slider.png"]
                        forState:UIControlStateNormal];
    [self.mySlider setThumbImage:[UIImage imageNamed:@"slider.png"]
                        forState:UIControlStateHighlighted];
    appDelegate=[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose off any resources that can be recreated.
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //extract the 2d coordinate for better readability
    CLLocation *loc = locations[0];
    CLLocationCoordinate2D coord = loc.coordinate;
    
    //NSDoubleAttributeType* curr_loc;
    
    
    //NSLog(@"Guten Tag %f",[coord.latitude doubleValue]);
    //query server for results
    NSString *queryString=[self.infoRequest description];
    queryString=[queryString stringByReplacingOccurrencesOfString:@" "withString:@"+"];

    [GoogleMapManager nearestVenuesForLatLong:coord withinRadius:[self.mySlider value] forQuery:queryString queryType:@"" googleMapsAPIKey:@"AIzaSyD7p3lc_bVBa8W9DYkC0fu5tyaQhAdmHYA" searchCompletion:^(NSMutableArray *results) {
        
        NSMutableArray* result_names=[[NSMutableArray alloc]init];
        NSMutableArray* dist_array=[[NSMutableArray alloc]init];
        CLLocationCoordinate2D center;
        [self.map removeAnnotations:[self.map annotations]];
        if ([results count] == 0){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Results Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        }	
        else{
            NSMutableArray* dictArray =[[NSMutableArray alloc] init];
            for (int i=0; i<[results count]; i++){
            
                NSMutableDictionary* r=[NSMutableDictionary dictionaryWithDictionary:[results objectAtIndex:i]];
                
                NSDictionary* g=[r objectForKey:@"geometry"];
                NSDictionary* l=[g objectForKey:@"location"];
                NSString* lat=[l objectForKey:@"lat"];
                NSString* lng=[l objectForKey:@"lng"];
                NSString* locname=[r objectForKey:@"name"];
                NSString* loc_rating=[[r objectForKey:@"rating"] stringValue];
                
                
                //Define
                CLLocationCoordinate2D poi;
            
                poi.latitude=[lat doubleValue];
                poi.longitude=[lng doubleValue];
                //Create CLLocation object from l
                CLLocation *targetLoc=[[CLLocation alloc] initWithLatitude:poi.latitude longitude:poi.longitude];
                
                CLLocation *myloc=[[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
                
                CLLocationDistance meters = [myloc distanceFromLocation:targetLoc];
              
                
                NSString* d=[NSString stringWithFormat:@"%g",meters];
                //double dist=[d doubleValue];
                
                
                [r setObject:d forKey:@"distance"];
                locname=[[locname stringByAppendingString:@" "] stringByAppendingString:d];
                [result_names addObject:locname];
                [dist_array addObject:d];
              
                if(i==0){
                    center.latitude=[lat doubleValue];
                    center.longitude=[lng doubleValue];
                }
            
                
                MKCoordinateRegion viewRegion=MKCoordinateRegionMakeWithDistance(center,2*[self.mySlider value],2*[self.mySlider value]);
                [self.map setRegion:viewRegion animated:YES];
                [self.map setShowsUserLocation:YES];
                
                //MKPointAnnotation point
                MKPointAnnotation* annot=[[MKPointAnnotation alloc] init];
                annot.coordinate=poi;
                annot.title=locname;
                
                
                
                NSString *joinString=[NSString stringWithFormat:@"Rating %@",loc_rating];
                if(joinString.length>0){
                    annot.subtitle=joinString;
                }
                [self.map addAnnotation:annot];
                
                
                [dictArray addObject:r];
            }
            
            //Sort dictArray and assign it to delegate
            NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
            [dictArray sortUsingDescriptors:[NSMutableArray arrayWithObject:sortDescriptor]];
            
            appDelegate.sharedResultDictionaryArray=dictArray;
            
        }
        [self.locationManager stopUpdatingLocation];
        
    }];
}
@end