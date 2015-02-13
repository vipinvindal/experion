//
//  MyProfileViewController.m
//  Experion ipad
//
//  Created by Ranjeet on 09/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import "MyProfileViewController.h"
#import "MyProfileViewController.h"
#import "EKKeyboardAvoiding.h"
#import "MBProgressHUD.h"
#import "UserDetailsViewController.h"
#import "HttpConnection.h"
#import "AppDelegate.h"
#import "TPKeyboardAvoidingScrollView.h"


@interface MyProfileViewController ()

@end

@implementation MyProfileViewController
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"My Profile";
        self.tabBarItem.image = [UIImage imageNamed:@"My Profile.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    viewCall=false;
    _loginBtn.layer.borderColor=[[UIColor grayColor] CGColor];
    _loginBtn.layer.borderWidth=1.0;
    _loginBtn.clipsToBounds=YES;
    
      currentCenterScroll=scrollView.center;
      NSLog(@"cwntert====%f,%f",currentCenterScroll.x,currentCenterScroll.y);
      [self.scrollView contentSizeToFit];
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    _request = [[JsonRequest alloc] init];
    
    [scrollView setContentSize:[scrollView frame].size];
   
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(viewWasTapped:)];
    [singleTap setCancelsTouchesInView:NO];
    [[self view] addGestureRecognizer:singleTap];
    
    _userNameTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    _paymentDetailsArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    [self orientationChange];
    
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideHUD];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.tabBarController.delegate = self;
    
    _userNameTextField.text = @"";
    _passwordTextField.text = @"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSuccessAuthentication) name:@"successAuthentication" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onsuccessDataFetch:) name:@"successDataFetch" object:nil];
    
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRegFailure) name:@"regFailed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHUD) name:@"hideHUD" object:nil];
    [self resetView];
}


-(void) viewDidDisappear:(BOOL)animated
{
   
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"successAuthentication" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"successDataFetch" object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"regFailed" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideHUD" object:nil];
    
    //    NSURLConnection *connection = [HttpConnection sharedSingleton];
    //    if (connection) {
    //        connection = nil;
    //    }
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //NSLog(@"22 Selected INDEX OF TAB-BAR ==> %i", tabBarController.selectedIndex);
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
}

-(IBAction)loginBtnClicked:(id)sender
{
    if ([_userNameTextField.text isEqualToString:@""] || _userNameTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Experion" message:@"Please enter Client ID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if ([_passwordTextField.text isEqualToString:@""] || _passwordTextField.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Experion" message:@"Please enter Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"Logging in...";
            //self.view.userInteractionEnabled = NO;
            hud.userInteractionEnabled = NO;
            JsonRequest *request = [[JsonRequest alloc] init];
            [request userAuthenticationRequest:_userNameTextField.text password:_passwordTextField.text];
        }
    }
}

-(void)onSuccessAuthentication
{
    if (!_request) {
        _request = [[JsonRequest alloc] init];
    }
    [_request fetchinghUserCustomerData:_userNameTextField.text];
}

-(void)onsuccessDataFetch : (NSNotification *)notification
{
    [self hideHUD];
    
    //getting Array of Customer Ledger Array of Dictionary to show in next View Controller
    NSMutableArray *userInfo = [[notification userInfo]valueForKey:@"customerLegderArr"];
    
    //Pushing View Controller to UserDetails after successful authentication
    UserDetailsViewController *userDetailsVC = [[UserDetailsViewController alloc]init];
    userDetailsVC.paymentDetailsArray = userInfo;
    [self.navigationController pushViewController:userDetailsVC animated:YES];
}


-(void)hideHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (IBAction)Request:(id)sender {
    
    if (!_request) {
        _request = [[JsonRequest alloc] init];
    }
    // [_request userAuthenticationRequest:@"namita.mehta@rediffmail.com" password:@"234"];
}

-(void)resetView{
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
     
        scrollView.center=CGPointMake(768/2,1024/2);
        [self potraitNavigation];
    }
    else{
        
        scrollView.center=CGPointMake(1024/2,768/2);
        
        [self landScabeNavigation];
    }
    
    
}

-(void)orientationChange{
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
        [self potraitNavigation];
    }
    else{
        scrollView.center=CGPointMake(1024/2,768/2);
        [self landScabeNavigation];
    }
    

}

#pragma mark -
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[self view] endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _userNameTextField.text =[_userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    _passwordTextField.text =[_passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
}

#pragma mark -
#pragma mark touches

- (void)viewWasTapped:(UITapGestureRecognizer *) singleTap
{
    [[self view] endEditing:YES];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
     viewCall=true;
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        scrollView.center=CGPointMake(1024/2,768/2);
        //[scrollView setContentSize:[scrollView frame].size];
        [self landScabeNavigation];
      
        
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        
         scrollView.center=CGPointMake(1024/2,768/2);
        //[scrollView setContentSize:[scrollView frame].size];
        [self landScabeNavigation];
     

    }
    else{
        
        scrollView.center=CGPointMake(768/2,1024/2);
       // [scrollView setContentSize:[scrollView frame].size];
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
