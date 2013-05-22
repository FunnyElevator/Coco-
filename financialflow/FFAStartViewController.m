//
//  FFAStartViewController.m
//  financialflow
//
//  Created by Fabian on 04.04.13.
//  Copyright (c) 2013 Fabian. All rights reserved.
//

#import "FFAStartViewController.h"

@interface FFAStartViewController () {
    IBOutlet UIButton *islandOneButton;
    IBOutlet UIButton *islandTwoButton;
    IBOutlet UIButton *islandThreeButton;
    IBOutlet UIButton *islandFourButton;
    
    
    
    IBOutlet UIButton *getDiplomaButton;
    IBOutlet UIButton *infoButton;
    IBOutlet UIButton *shareButton;
    
    IBOutlet UIView *infoScreen;
    IBOutlet UITextView *infoText;
    IBOutlet UIButton *resetButton;
    __weak IBOutlet UIButton *backButtonInfo;
    __weak IBOutlet UITextView *mainLabel1;
    __weak IBOutlet UITextView *mainLabel2;
    __weak IBOutlet UITextView *mainLabel3;
    __weak IBOutlet UITextView *mainLabel4;
    
}
@property (nonatomic, strong) UIPopoverController *activityPopoverController;

@end

//static FFAStartViewController *playerData;

@implementation FFAStartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // Addust fonts and set up view
    getDiplomaButton.titleLabel.font = [UIFont fontWithName:@"Trade Winds" size:24];
    infoText.font = [UIFont fontWithName:@"ArbutusSlab-Regular" size:16];
    resetButton.titleLabel.font = [UIFont fontWithName:@"ArbutusSlab-Regular" size:16];
    backButtonInfo.titleLabel.font = [UIFont fontWithName:@"ArbutusSlab-Regular" size:16];
    mainLabel1.font = [UIFont fontWithName:@"Trade Winds" size:22];
    mainLabel2.font = [UIFont fontWithName:@"Trade Winds" size:22];
    mainLabel3.font = [UIFont fontWithName:@"Trade Winds" size:22];
    mainLabel4.font = [UIFont fontWithName:@"Trade Winds" size:22];
    
    //infoButton.titleLabel.font = [UIFont fontWithName:@"ArbutusSlab-Regular" size:24];
    //shareButton.titleLabel.font = [UIFont fontWithName:@"ArbutusSlab-Regular" size:24];
    
    
    //load user data
    /*
    if (userdata is here) {
        // load user data into game
    } else {
        //initialize user data
    }
     */
    
    //FFAPlayer *playerData = [FFAPlayer sharedPlayer];
    //playerData.name = @"It's me!";
    NSLog(@"View loaded");
    
}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"View appear");
}

- (void)setUpStartscreen {
    FFAPlayer *playerData = [FFAPlayer sharedPlayer];
    if (playerData.unlockedLevelTwo== YES) {
        [self unlockButtonTwo];
        [self finishButtonOne];
        
    } else {
        [self resetButtonOne];
    }
    if (playerData.unlockedLevelThree == YES) {
        [self unlockButtonThree];
        [self finishButtonTwo];
    } 
    if (playerData.unlockedLevelFour == YES) {
        [self unlockButtonFour];
        [self finishButtonThree];
    }
    if (playerData.unlockedDiploma == YES) {
        [self finishButtonFour];
    }
    
}
- (void)resetButtonOne {
    
}
- (void)resetButtonTwo {
    
}
- (void)resetButtonThree {
    
}
- (void)resetButtonFour {
    
}
- (void)unlockButtonTwo {
    [islandTwoButton setImage:[UIImage imageNamed:@"main-level-bg.png"] forState:UIControlStateNormal];
}
- (void)unlockButtonThree {
    [islandThreeButton setImage:[UIImage imageNamed:@"main-level-bg.png"] forState:UIControlStateNormal];
}
- (void)unlockButtonFour {
    [islandFourButton setImage:[UIImage imageNamed:@"main-level-bg.png"] forState:UIControlStateNormal];
}
- (void)finishButtonOne {
    
}
- (void)finishButtonTwo {
    
}
- (void)finishButtonThree {
    
}
- (void)finishButtonFour {
    
}


#pragma mark - Info Screen & Game reset

- (IBAction)showInfoScreen:(id)sender {
    //NSLog(@"show info Screen");
    
    infoScreen.hidden = NO;
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [infoScreen setAlpha:1.0f];
                     }
     ];
}
- (IBAction)hideInfoScreen:(id)sender {
    [self hideScreen];
}
- (void)hideScreen
{
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [infoScreen setAlpha:0.0f];
                     }
                     completion:^(BOOL finished) {
                         infoScreen.hidden = YES;
                     }];
}

- (IBAction)resetGame:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really reset?" message:@"Do you really want to reset this game?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Reset"];
    [alert setTag:12];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 12) {    // it's the Error alert
        if (buttonIndex == 1) {     // and they clicked OK.
            FFAPlayer *playerData = [FFAPlayer sharedPlayer];
            playerData.name = @"";
            playerData.gender = UnKnown;
            playerData.age = 0;
            playerData.unlockedLevelTwo = NO;
            playerData.unlockedLevelThree = NO;
            playerData.unlockedLevelFour = NO;
            playerData.unlockedDiploma = NO;
            playerData.currentQuestion = 0;
            
            CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
            NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
            CFRelease(newUniqueId);
            playerData.deviceID = uuidString;
            [playerData.answerValues removeAllObjects];
            [self setUpStartscreen];
            
            [self hideScreen];
        }
    }
}


#pragma mark - App Sharing

- (IBAction)shareApp:(id)sender
{
    if ([self.activityPopoverController isPopoverVisible]) {
        [self.activityPopoverController dismissPopoverAnimated:YES];
    } else {
       /* NSString *shareText = [NSString stringWithFormat:@"Prove yourself with Coco"];
        UIImage *shareImage = [UIImage imageNamed:@"coco-logo.png"];
        NSArray *activityItems = @[shareText, shareImage];
        
        
        UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                         applicationActivities:nil];
        vc.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll];
        vc.completionHandler = ^(NSString *activityType, BOOL completed){
            [self.activityPopoverController dismissPopoverAnimated:YES];
        };
        
        if (self.activityPopoverController) {
            [self.activityPopoverController setContentViewController:vc];
        } else {
            self.activityPopoverController = [[UIPopoverController alloc] initWithContentViewController:vc];
        }
        
        [self.activityPopoverController presentPopoverFromRect:[(UIControl *)sender frame]
                                                        inView:self.view
                                      permittedArrowDirections:UIPopoverArrowDirectionAny
                                                      animated:YES];
        */
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sharing Disabled" message:@"Sharing has been disabled for Demo purposes. Sorry." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    if ([segue.identifier isEqualToString:@"showDiplomaScreen"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Diploma in demo mode" message:@"The diploma would be disabeld until all islands are finsihed. Here's a sample how it could look like." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end
