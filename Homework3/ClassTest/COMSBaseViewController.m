//
//  COMSBaseViewController.m
//  LocTracker
//
//  Created by Nikhil Raju on 2/10/14.
//  Uni nr2483

#import "COMSBaseViewController.h"
#import <COMSMapManager/COMSMapManager.h>
#import "MapViewController.h"

@interface COMSBaseViewController ()

@end

@implementation COMSBaseViewController

#pragma mark - Loading methods
/*
 Automatically called by the view controller
 */
-(void)awakeFromNib{
    
}

/*
 Automatically called by the view controller
 */
- (void)viewDidLoad
{
    NSLog(@"Reached view did load");
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [super viewDidLoad];
    self.searchButton.enabled=NO;
    
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(buttonDragged:)];
    
    [self.helpButton addGestureRecognizer:pan];
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    self.gravity = [[UIGravityBehavior alloc]init];
    [self.gravity setAngle:M_PI/2 magnitude:3];
    [self.animator addBehavior:self.gravity];
    
    //add collision
    self.collision = [[UICollisionBehavior alloc]initWithItems:@[self.helpButton]];
    
    [self.animator addBehavior:self.collision];
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    //launches something on delay
    double delayInSeconds = 2.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.gravity addItem:self.helpButton];
    });
    
    
   
    
    
	// Do any additional setup after loading the view.
}

- (IBAction)mainButtonPressed:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Need Help?" message:@"1.Tab1 -> Enter Query\n2. Tab2 -> View Results\n3. Tab3 ->  Favorites" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert show];
    
}
- (IBAction)buttonDragged:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView:self.view.window];
    
    sender.view.center = CGPointMake(sender.view.center.x+translation.x, sender.view.center.y+translation.y);
    
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    
}


#pragma mark - Core location
/*
 Automatically called by location manager because we are it's delegate
 */


#pragma mark - UITextField delegate methods
/*
 Called by the textfield right before the text changes, great place to call a network for requests, etc... Here we'll use it to change the coor of the screen
 */

#pragma mark - IBActions

/*
 Actions when the main (only) button is pressed
 */
- (IBAction)updateLabelPressed:(UIButton *)sender {
    
    //set the display label text to that of the textfield
    //self.display.text = self.inputTextField.text;
    NSString* message=@"You Searched for ";
    self.display.text=[message stringByAppendingString:self.inputTextField.text];
    //resign first responder (hide the keyboard)
    if (self.inputTextField.isFirstResponder) {
        [self.inputTextField resignFirstResponder];
    }
}

- (IBAction)sendInfo:(id)sender {
}

#pragma mark - Gesture recognizers
/*
 Actions when a certain view is tapped. In this case we added this recognizer to the main view (self.view) so that the keyboard will dismiss when the screen is tapped
 */
- (IBAction)checkInput:(id)sender {
    if (self.inputTextField.text.length>0){
        self.searchButton.enabled=YES;
    }
    else{
        self.searchButton.enabled=NO;
    }
}
- (IBAction)screenTapped:(UITapGestureRecognizer *)sender {
    
    //The textfield has a property called first responder. The keyboard is this textfields accessory view. When the textfield is in first responder mode, it means it is the primary focus on the screen (the textfield cursor is blinking, keyboard is up). To dismiss the keyboard, we tell it to resignFirstResponder status
    if (self.inputTextField.isFirstResponder) {
        [self.inputTextField resignFirstResponder];
    }
}

    
    
/*
 Use this method to signal a passing of control to the Map view controller (Destination View Controller)
 When the search Button is pressed by the user, 
*/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"sendInfo"]) {
        MapViewController *mvcontroller=[segue destinationViewController];
        NSLog(@"text :%@",self.inputTextField);
        mvcontroller.infoRequest=self.inputTextField.text;
        
    }
}
@end