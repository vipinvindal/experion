//
//  DisclaimerViewController.m
//  Experion ipad
//
//  Created by Ranjeet on 14/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import "DisclaimerViewController.h"

@interface DisclaimerViewController ()

@end

@implementation DisclaimerViewController
@synthesize disclaimerText=_disclaimerText;

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
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
      
        toolbar.barTintColor = [UIColor colorWithRed:33.0/255.0 green:98.0/255.0 blue:171.0/255.0 alpha:1];

    }else{
        toolbar.tintColor = [UIColor colorWithRed:33.0/255.0 green:98.0/255.0 blue:171.0/255.0 alpha:1];

    }
     self.disclaimerText.textAlignment=NSTextAlignmentJustified;
 
    [super viewDidLoad];
    [self orientationChange];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)orientationChange{
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
        _flexiWidth.width=680;
    }
    else{
        
        _flexiWidth.width=930;
    
        
    }
    
    
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        
        _flexiWidth.width=930;
         [self landScabeNavigation];
            
       }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        
        
        _flexiWidth.width=930;
        [self landScabeNavigation];
            
     }
    else {
        
       _flexiWidth.width=680;
         [self potraitNavigation];
    }
}

-(void)landScabeNavigation{
    UIImage *NavigationLandscapeBackground = [[UIImage imageNamed:@"navBarLandScape.png"]
                                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    
    //[[UINavigationBar appearance] setBackgroundImage:NavigationLandscapeBackground forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:NavigationLandscapeBackground forBarMetrics:UIBarMetricsDefault];
    
    
    
}
-(void)potraitNavigation{
    UIImage *navBarImg = [[UIImage imageNamed:@"navBar.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];    //[[UINavigationBar appearance] setBackgroundImage:NavigationLandscapeBackground forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    
    
    
}



-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


@end
