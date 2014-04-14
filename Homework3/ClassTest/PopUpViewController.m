//
//  PopUpViewController.m
//  LocTracker
//
//  Created by nikhil raju on 4/5/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate2=[[UIApplication sharedApplication] delegate];
    NSString* apiKey=@"AIzaSyD7p3lc_bVBa8W9DYkC0fu5tyaQhAdmHYA";
    
    self.nameLabel.text=[appDelegate2.sharedDict objectForKey:@"name"] ;
    self.priceLabel.text=[[appDelegate2.sharedDict objectForKey:@"price_level"] stringValue];
    self.ratingLabel.text=[[appDelegate2.sharedDict objectForKey:@"rating"] stringValue];
    self.vicinityLabel.text=[appDelegate2.sharedDict objectForKey:@"vicinity"];
    
    NSString *icon_url_string=[appDelegate2.sharedDict objectForKey:@"icon"];
    NSURL *icon_url=[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=%@&sensor=false&maxwidth=320",icon_url_string,apiKey]];
    NSData *data1=[[NSData alloc]initWithContentsOfURL:icon_url];
    UIImage *typeImg=[[UIImage alloc]initWithData:data1];
    self.placeTypeIcon.image=typeImg;
    
    NSString* img_url=[[[appDelegate2.sharedDict objectForKey:@"photos"] objectAtIndex:0] objectForKey:@"photo_reference"];
    NSURL *url =[NSURL URLWithString: [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=%@&sensor=false&maxwidth=320", img_url,apiKey ]];
    
    NSData* data2=[[NSData alloc] initWithContentsOfURL:url];
    UIImage *locImg=[[UIImage alloc] initWithData:data2];
    self.locIcon.image=locImg;

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
