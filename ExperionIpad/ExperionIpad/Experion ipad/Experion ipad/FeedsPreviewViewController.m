//
//  FeedsPreviewViewController.m
//  Experion ipad
//
//  Created by Ranjeet on 14/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import "FeedsPreviewViewController.h"
#import "AcyImage.h"

@interface FeedsPreviewViewController ()

@end

@implementation FeedsPreviewViewController

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
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 30, 25);
    [backButton setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMe) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    AcyImage *acyimgeview=[[AcyImage alloc]initWithFrame:CGRectMake(25,48,90,80) :@"placeholder"];
    
    acyimgeview.layer.shadowColor=[[UIColor grayColor] CGColor];
    acyimgeview.layer.cornerRadius = 4;
    acyimgeview.layer.shadowOffset=CGSizeMake(3, 3);
    acyimgeview.layer.shadowOpacity=1.0;
    acyimgeview.layer.shadowRadius=1.0;
    //acyimgeview.clipsToBounds = YES;
    
    [acyimgeview setBackgroundColor:[UIColor clearColor]];
    acyimgeview.tag=888;
    
    [acyimgeview loadimage:@"" :_imageURLStr];
    [self.view addSubview:acyimgeview];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        [acyimgeview setFrame:CGRectMake(25,112,90,80)];
    
    }
    
    _feedsText.userInteractionEnabled = YES;
    _feedsText.scrollEnabled = YES;
    _feedsText.editable = NO;
    //_contactBtnTextView.backgroundColor = [UIColor brownColor];
    
    [_feedsText setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:0.8]];
    _feedsText.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
    _feedsText.text = _feedsDescriptionText;
    _feedsText.font=[UIFont systemFontOfSize:16.5];
    
    [self resetView];
  
}
-(void)resetView{
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
        
        
        [self potraitNavigation];
   
    
    }
    else{
        
        
        
        [self landScabeNavigation];
   
    
    }
    
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        
        
        [self landScabeNavigation];
        
        
        
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        
        
        [self landScabeNavigation];
        
        
    }
    else{
        
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


-(void)backMe
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end