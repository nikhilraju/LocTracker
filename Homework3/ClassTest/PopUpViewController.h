//
//  PopUpViewController.h
//  LocTracker
//
//  Created by nikhil raju on 4/5/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COMSAppDelegate.h"
@interface PopUpViewController : UIViewController{
    COMSAppDelegate *appDelegate2;
}

@property (strong, nonatomic) IBOutlet UIImageView *placeTypeIcon;

@property (strong, nonatomic) IBOutlet UIImageView *locIcon;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *vicinityLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@end
