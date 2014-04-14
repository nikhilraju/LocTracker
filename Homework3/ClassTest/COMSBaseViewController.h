//
//  COMSBaseViewController.h
//  LocTracker
//
//  Created by Nikhil Raju on 2/10/14.
//  Uni nr2483

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//import the class where the CLLocationManagerDelegate protocol is implemented
@import CoreLocation;

//here between the <> we dictate what protocols we will implement. If we don't import the class that has that protocol declared, this won't work
@interface COMSBaseViewController :UIViewController

//connect our view controllers to the UIKit items on the storyboard
@property (strong, nonatomic) IBOutlet UIButton *helpButton;

@property (strong, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) IBOutlet UILabel *display;
@property(nonatomic) UIDynamicAnimator *animator;
@property(nonatomic) UIGravityBehavior *gravity;
@property(nonatomic) UICollisionBehavior *collision;
- (IBAction)sendInfo:(id)sender;
- (IBAction)mainButtonPressed:(UIButton *)sender;
- (IBAction)buttonDragged:(UIPanGestureRecognizer *)sender;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@end
