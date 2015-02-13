//
//  AboutUsViewController.m
//  Experion ipad
//
//  Created by Ranjeet on 09/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Constants.h"
#import "AppDelegate.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
@synthesize buttonBg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"About Us";
        self.tabBarItem.image = [UIImage imageNamed:@"About Us.png"];
        
       
    }
    return self;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        NSLog(@"Portrait");
    }
    else
    {
        NSLog(@"Landscape");
        landscape=true;
    }
    
    
    btnIndex = 0;
     buttonWith=768-45;
    BTN_HEIGHT = 50;
    // PADDING = 5;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    NSLog(@"widht=====%f",screenWidth);
    screenWidth=screenWidth-45.0;
    
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
         yButton=744;
        
        
    }
    else{
         yButton=680;
    }
    
    
   
    
    
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"demoBg"]]];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        PADDING = 10;
        topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 24, screenWidth+5, 660)];
    }
    else
    {
        PADDING =10;
        topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(16, -24, screenWidth+5, 660)];
    }
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    topImgView.image = [UIImage imageNamed:@"AboutUs-bg.jpg"];
    topImgView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:topImgView];
    
    _aboutUsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_aboutUsBtn setTitle:@" Company Profile" forState:UIControlStateNormal];
    _aboutUsBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_aboutUsBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_aboutUsBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_aboutUsBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    [_aboutUsBtn setBackgroundColor:[UIColor clearColor]];
    
   
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _aboutUsBtn.frame = CGRectMake(18, 305, 300, BTN_HEIGHT);
    }
    else
    {
        _aboutUsBtn.frame = CGRectMake(18, yButton,screenWidth, BTN_HEIGHT);
    }
    
    [_aboutUsBtn addTarget:self action:@selector(aboutUsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
   // _aboutUsBtn.adjustsImageWhenHighlighted = YES;
    _aboutUsBtn.tag = 1;
    [self.view addSubview:_aboutUsBtn];
    
    _managementTeamBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_managementTeamBtn setTitle:@" Vision" forState:UIControlStateNormal];
    _managementTeamBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_managementTeamBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_managementTeamBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_managementTeamBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _managementTeamBtn.frame = CGRectMake(18, 305+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT);
    }
    else
    {
        _managementTeamBtn.frame = CGRectMake(18, yButton+BTN_HEIGHT+PADDING, screenWidth, BTN_HEIGHT);
    }
    
    [_managementTeamBtn addTarget:self action:@selector(managementTeamBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _managementTeamBtn.adjustsImageWhenHighlighted = YES;
    _managementTeamBtn.tag = 2;
    [self.view addSubview:_managementTeamBtn];
    
    _ceoDeskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ceoDeskBtn setTitle:@" Values" forState:UIControlStateNormal];
    _ceoDeskBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_ceoDeskBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_ceoDeskBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_ceoDeskBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _ceoDeskBtn.frame = CGRectMake(18, 305+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
    }
    else
    {
        _ceoDeskBtn.frame = CGRectMake(18, yButton+2*(BTN_HEIGHT+PADDING), screenWidth, BTN_HEIGHT);
    }
    
    [_ceoDeskBtn addTarget:self action:@selector(ceoDeskBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _ceoDeskBtn.adjustsImageWhenHighlighted = YES;
    _ceoDeskBtn.tag = 3;
    [self.view addSubview:_ceoDeskBtn];
    buttonBg.hidden=YES;
    
    /*
     _partnersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     [_partnersBtn setTitle:@"   Partners" forState:UIControlStateNormal];
     _partnersBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
     [_partnersBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
     [_partnersBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
     [_partnersBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
     
     if ([[UIScreen mainScreen] bounds].size.height == 568)
     {
     _partnersBtn.frame = CGRectMake(10, 305+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
     }
     else
     {
     _partnersBtn.frame = CGRectMake(10, 240+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
     }
     
     [_partnersBtn addTarget:self action:@selector(partnersBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
     _partnersBtn.adjustsImageWhenHighlighted = YES;
     _partnersBtn.tag = 3;
     [self.view addSubview:_partnersBtn];
     */
    
    _commonTextView = [[UITextView alloc]init];
    _commonTextView.frame = CGRectMake(18, yButton+BTN_HEIGHT, buttonWith, 0);
    _commonTextView.font=[UIFont systemFontOfSize:16.0];
 
    _commonTextView.userInteractionEnabled = YES;
    _commonTextView.scrollEnabled = YES;
    _commonTextView.editable = NO;
    //_commonTextView.backgroundColor = [UIColor brownColor];
    [_commonTextView setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:0.95f]];
    _commonTextView.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
    [self.view addSubview:_commonTextView];
    //_commonTextView.hidden = YES;
    
    //    _partnersView = [[CustomPartnersView alloc]init];
    //    _partnersView.view.frame = CGRectMake(10, 200, 300, 100);
    //    [self.view addSubview:_partnersView.view];
    //    [_partnersView.view setHidden:YES];
    
    
    /*[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];*/
    
    if (landscape) {
        [self orientationChange];
    }
    
}

-(void)orientationChange{
   // UIImage *landscapeImage = [UIImage imageNamed:@"navBarLandScape.png"];
   // [self.navigationController.navigationBar setBackIndicatorImage:landscapeImage];
    float changeY=250.0;
    buttonWith=1024-36;
    topImgView.frame=CGRectMake(topImgView.frame.origin.x, topImgView.frame.origin.y,  buttonWith+5, 412);
    
    _aboutUsBtn.frame =CGRectMake(_aboutUsBtn.frame.origin.x, _aboutUsBtn.frame.origin.y-changeY,buttonWith, _aboutUsBtn.frame.size.height);
    _managementTeamBtn.frame =CGRectMake(_managementTeamBtn.frame.origin.x, _managementTeamBtn.frame.origin.y-changeY,buttonWith, _managementTeamBtn.frame.size.height);
    _ceoDeskBtn.frame =CGRectMake(_ceoDeskBtn.frame.origin.x, _ceoDeskBtn.frame.origin.y-changeY,buttonWith, _ceoDeskBtn.frame.size.height);
    
    _commonTextView.frame =CGRectMake(_commonTextView.frame.origin.x, _commonTextView.frame.origin.y-changeY,buttonWith, _commonTextView.frame.size.height);
    
    topImgView.image = [UIImage imageNamed:@"AboutUs-bgLandCabe.jpg"];
    
    [self landScabeNavigation];
    


}

-(void)viewWillAppear:(BOOL)animated
{
    apperAboutUs=true;
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.tabBarController.delegate = self;
    [self resetView];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    apperAboutUs=false;
    [self resetView];
}

#pragma mark - TabBar Delegate
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // NSLog(@"11 Selected INDEX OF TAB-BAR ==> %i", tabBarController.selectedIndex);
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark -
-(void)resetView
{
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
        buttonWith=768-36;
        _aboutUsBtn.frame = CGRectMake(18, yButton, buttonWith, BTN_HEIGHT);
        _managementTeamBtn.frame = CGRectMake(18, yButton+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT);
        _ceoDeskBtn.frame = CGRectMake(18, yButton+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT);
        // _partnersBtn.frame = CGRectMake(10, 240+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
        _commonTextView.frame = CGRectMake(18, yButton+BTN_HEIGHT, buttonWith, 0);
        topImgView.frame=CGRectMake(topImgView.frame.origin.x, topImgView.frame.origin.y,  buttonWith+5, 660);
        topImgView.image = [UIImage imageNamed:@"AboutUs-bg.jpg"];
        [self potraitNavigation];
        
    }
    else{
        buttonWith=1024-36;
         float changeY=250.0;
        _aboutUsBtn.frame = CGRectMake(18, yButton-changeY, buttonWith, BTN_HEIGHT);
        _managementTeamBtn.frame = CGRectMake(18, yButton-changeY+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT);
        _ceoDeskBtn.frame = CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT);
        // _partnersBtn.frame = CGRectMake(10, 240+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
        _commonTextView.frame = CGRectMake(18, yButton-changeY+BTN_HEIGHT, buttonWith, 0);
        topImgView.frame=CGRectMake(topImgView.frame.origin.x, topImgView.frame.origin.y,  buttonWith+5, 412);
       topImgView.image = [UIImage imageNamed:@"AboutUs-bgLandCabe.jpg"];
        [self landScabeNavigation];
        
           }
    
    /*_aboutUsBtn.frame = CGRectMake(20, yButton, buttonWith, BTN_HEIGHT);
    _managementTeamBtn.frame = CGRectMake(20, yButton+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT);
    _ceoDeskBtn.frame = CGRectMake(20, yButton+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT);
    // _partnersBtn.frame = CGRectMake(10, 240+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
    _commonTextView.frame = CGRectMake(20, yButton+BTN_HEIGHT, buttonWith, 0);*/

    
    
    
    
    isExpanded = NO;
    isManagementTeamBtnOn = NO;
    isAboutUsOn = NO;
    isCEOBtnOn = NO;
    isPartnersBtnOn = NO;
    //[_partnersView.view setHidden:YES];
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

-(void)aboutUsBtnClicked:(id)sender
{
    btnIndex = 1;
    
    
       
    if (!isAboutUsOn) {
        
        isAboutUsOn = YES;
        isManagementTeamBtnOn = NO;
        isCEOBtnOn = NO;
        isPartnersBtnOn = NO;
        [self setButtonToInitialFrame];
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.7];
        //isExpanded = YES;
    }
    else
    {
        //isExpanded = NO;
        isAboutUsOn = NO;
        [self setButtonToInitialFrame];
        
    }
}

-(void)managementTeamBtnClicked:(id)sender
{
    btnIndex = 2;
    
    
   
    
    
    if (!isManagementTeamBtnOn)
    {
        isManagementTeamBtnOn = YES;
        isAboutUsOn = NO;
        isCEOBtnOn = NO;
        isPartnersBtnOn = NO;
        [self setButtonToInitialFrame];
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.7];
        
    }
    else
    {
        isManagementTeamBtnOn = NO;
        [self setButtonToInitialFrame];
    }
}

-(void)ceoDeskBtnClicked : (id) sender
{
    btnIndex = 3;
    
    if (!isCEOBtnOn) {
        isCEOBtnOn = YES;
        isAboutUsOn = NO;
        isManagementTeamBtnOn = NO;
        isPartnersBtnOn = NO;
        [self setButtonToInitialFrame];
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.7];
    }
    else
    {
        isCEOBtnOn = NO;
        [self setButtonToInitialFrame];
    }
    
}

-(void)partnersBtnClicked:(id)sender
{
    btnIndex = 4;
    
    [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
    _commonTextView.text = PARTNERS;
    
    //  //  _partnersView = [[CustomPartnersView alloc]init];
    //   // _partnersView = (CustomPartnersView*)[self viewFromNibName:@"CustomPartnersView"];
    //    //_partnersView.center = self.view.center;
    //    //_partnersView.view.frame = CGRectMake(10, 200, 300, 400);
    //
    //    //[self.view addSubview:_partnersView.view];
    //    [_partnersView.view setHidden:NO];
    
    
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(130, _commonTextView.contentSize.height, 60, 60)];
    //    view.backgroundColor = [UIColor greenColor]; // for testing
    //   // [view addSubView:_commonTextView];
    //    [view addSubview:_commonTextView];
    
    
    //    if (btnIndex == 4) {
    //        UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 155, 120, 27)];
    //        [imgView1 setImage:[UIImage imageNamed:@"arcop"]];
    //        // [view addSubview:imgView];
    //        [_commonTextView addSubview:imgView1];
    //
    //        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 220, 238, 66)];
    //        [imgView2 setImage:[UIImage imageNamed:@"siteConcepts"]];
    //        // [view addSubview:imgView];
    //        [_commonTextView addSubview:imgView2];
    //    }
    
    
    if (!isPartnersBtnOn) {
        isPartnersBtnOn = YES;
        isAboutUsOn = NO;
        isManagementTeamBtnOn = NO;
        isCEOBtnOn = NO;
        [self setButtonToInitialFrame];
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.5];
    }
    else
    {
        isPartnersBtnOn = NO;
        [self setButtonToInitialFrame];
    }
    
}

-(UIView *)viewFromNibName:(NSString *)nibName
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
}

-(void)showHideContent
{
    // _commonTextView.frame = CGRectMake(10, 65+(btnIndex*30), 300, 0);
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         // Do your animations here.
                         if (btnIndex == 1)
                         {
                             //contact button
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_aboutUsBtn setFrame:CGRectMake(18,464, buttonWith, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutUsBtn setFrame:CGRectMake(18,400, buttonWith, BTN_HEIGHT)];
                             }
                         }
                         else if (btnIndex == 2)
                         {
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_aboutUsBtn setFrame:CGRectMake(18, 464, buttonWith, BTN_HEIGHT)];
                                 [_managementTeamBtn setFrame:CGRectMake(18,464+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutUsBtn setFrame:CGRectMake(18, 400, buttonWith, BTN_HEIGHT)];
                                 [_managementTeamBtn setFrame:CGRectMake(18, 400+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                             }
                         }
                         else if (btnIndex == 3)
                         {
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_aboutUsBtn setFrame:CGRectMake(18, 464, buttonWith, BTN_HEIGHT)];
                                 [_managementTeamBtn setFrame:CGRectMake(18, 464+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                                 [_ceoDeskBtn setFrame:CGRectMake(18, 464+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutUsBtn setFrame:CGRectMake(18, 400, buttonWith, BTN_HEIGHT)];
                                 [_managementTeamBtn setFrame:CGRectMake(18, 400+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                                 [_ceoDeskBtn setFrame:CGRectMake(18, 400+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
                             }
                         }
                         else
                         {
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_aboutUsBtn setFrame:CGRectMake(18, 464, buttonWith, BTN_HEIGHT)];
                                 [_managementTeamBtn setFrame:CGRectMake(10, 464+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                                 [_ceoDeskBtn setFrame:CGRectMake(20, 464+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
                                 // [_partnersBtn setFrame:CGRectMake(10, 170, 300, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutUsBtn setFrame:CGRectMake(18, 400, buttonWith, BTN_HEIGHT)];
                                 [_managementTeamBtn setFrame:CGRectMake(18, 400+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                                 [_ceoDeskBtn setFrame:CGRectMake(18, 400+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
                                 // [_partnersBtn setFrame:CGRectMake(10, 130, 300, BTN_HEIGHT)];
                             }
                         }
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             // Do your method here after your animation.
                             [UIView beginAnimations:@"advancedAnimations" context:nil];
                             [UIView setAnimationDuration:0.5];
                             
                             float textViewHeight = 0;
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 textViewHeight =280.0;
                             }
                             else
                             {
                                 textViewHeight = 280.0;
                             }
                             
                             if (btnIndex == 1) {
                                 [_commonTextView setFrame:CGRectMake(_aboutUsBtn.frame.origin.x, _aboutUsBtn.frame.origin.y+BTN_HEIGHT, _aboutUsBtn.frame.size.width, textViewHeight)];
                                 
                                 _commonTextView.text = ABOUT_US;
                                 //[_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];

                             }
                             else if (btnIndex == 2)
                             {
                                 [_commonTextView setFrame:CGRectMake(_managementTeamBtn.frame.origin.x, _managementTeamBtn.frame.origin.y+BTN_HEIGHT, _managementTeamBtn.frame.size.width, textViewHeight)];
                                 _commonTextView.text = VISION;
                                 //[_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
                             }
                             else if (btnIndex == 3)
                             {
                                 [_commonTextView setFrame:CGRectMake(_ceoDeskBtn.frame.origin.x, _ceoDeskBtn.frame.origin.y+BTN_HEIGHT, _ceoDeskBtn.frame.size.width, textViewHeight)];
                                 _commonTextView.text = VALUES;
                                 //[_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];

                             }
                             else
                             {
                                 // [_commonTextView setFrame:CGRectMake(_partnersBtn.frame.origin.x, _partnersBtn.frame.origin.y+BTN_HEIGHT, _partnersBtn.frame.size.width, textViewHeight)];
                             }
                             
                             [UIView commitAnimations];
                             _commonTextView.hidden = NO;
                             
                         }
                     }];
    }
    else{
        
        
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             // Do your animations here.
                             if (btnIndex == 1)
                             {
                                 //contact button
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     [_aboutUsBtn setFrame:CGRectMake(18, 264, buttonWith, BTN_HEIGHT)];
                                 }
                                 else
                                 {
                                     [_aboutUsBtn setFrame:CGRectMake(18,200, buttonWith, BTN_HEIGHT)];
                                 }
                             }
                             else if (btnIndex == 2)
                             {
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     [_aboutUsBtn setFrame:CGRectMake(18, 264, buttonWith, BTN_HEIGHT)];
                                     [_managementTeamBtn setFrame:CGRectMake(18, 264+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                                 }
                                 else
                                 {
                                     [_aboutUsBtn setFrame:CGRectMake(18, 200, buttonWith, BTN_HEIGHT)];
                                     [_managementTeamBtn setFrame:CGRectMake(18, 200+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                                 }
                             }
                             else if (btnIndex == 3)
                             {
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     [_aboutUsBtn setFrame:CGRectMake(18, 264, buttonWith, BTN_HEIGHT)];
                                     [_managementTeamBtn setFrame:CGRectMake(18, 264+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                                     [_ceoDeskBtn setFrame:CGRectMake(18, 264+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
                                 }
                                 else
                                 {
                                     [_aboutUsBtn setFrame:CGRectMake(18, 200, buttonWith, BTN_HEIGHT)];
                                     [_managementTeamBtn setFrame:CGRectMake(18, 200+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                                     [_ceoDeskBtn setFrame:CGRectMake(18, 200+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
                                 }
                             }
                             else
                             {
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     [_aboutUsBtn setFrame:CGRectMake(18, 264, buttonWith, BTN_HEIGHT)];
                                     [_managementTeamBtn setFrame:CGRectMake(18, 264+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                                     [_ceoDeskBtn setFrame:CGRectMake(18, 264+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
                                     // [_partnersBtn setFrame:CGRectMake(10, 170, 300, BTN_HEIGHT)];
                                 }
                                 else
                                 {
                                     [_aboutUsBtn setFrame:CGRectMake(18, 200, buttonWith, BTN_HEIGHT)];
                                     [_managementTeamBtn setFrame:CGRectMake(18, 200+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                                     [_ceoDeskBtn setFrame:CGRectMake(18, 200+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
                                     // [_partnersBtn setFrame:CGRectMake(10, 130, 300, BTN_HEIGHT)];
                                 }
                             }
                         }
                         completion:^(BOOL finished){
                             if (finished) {
                                 // Do your method here after your animation.
                                 [UIView beginAnimations:@"advancedAnimations" context:nil];
                                 [UIView setAnimationDuration:0.5];
                                 
                                 float textViewHeight = 0;
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     textViewHeight = 230.0;
                                 }
                                 else
                                 {
                                     textViewHeight =230.0;
                                 }
                                 
                                 if (btnIndex == 1) {
                                     [_commonTextView setFrame:CGRectMake(_aboutUsBtn.frame.origin.x, _aboutUsBtn.frame.origin.y+BTN_HEIGHT, _aboutUsBtn.frame.size.width, textViewHeight)];
                                     _commonTextView.text = ABOUT_US;
                                     [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
                                 }
                                 else if (btnIndex == 2)
                                 {
                                     [_commonTextView setFrame:CGRectMake(_managementTeamBtn.frame.origin.x, _managementTeamBtn.frame.origin.y+BTN_HEIGHT, _managementTeamBtn.frame.size.width, textViewHeight)];
                                     _commonTextView.text = VISION;
                                     [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
                                 }
                                 else if (btnIndex == 3)
                                 {
                                     [_commonTextView setFrame:CGRectMake(_ceoDeskBtn.frame.origin.x, _ceoDeskBtn.frame.origin.y+BTN_HEIGHT, _ceoDeskBtn.frame.size.width, textViewHeight)];
                                     _commonTextView.text = VALUES;
                                     [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];

                                 }
                                 else
                                 {
                                     // [_commonTextView setFrame:CGRectMake(_partnersBtn.frame.origin.x, _partnersBtn.frame.origin.y+BTN_HEIGHT, _partnersBtn.frame.size.width, textViewHeight)];
                                 }
                                 
                                 [UIView commitAnimations];
                                 _commonTextView.hidden = NO;
                                 
                             }
                         }];
        
        
    }
    isExpanded = YES;
    
}

-(void)showHideContentOfficeBtnClicked
{
    [self setButtonToInitialFrame];
    if (!isExpanded) {
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.5];
    }
    
}

-(void) setButtonToInitialFrame
{
    [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
   
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                         {
                             _commonTextView.frame = CGRectMake(18,459+(btnIndex*(BTN_HEIGHT+PADDING-5)), buttonWith, 0);
                         }
                         else
                         {
                             _commonTextView.frame = CGRectMake(18, 395+(btnIndex*(BTN_HEIGHT+PADDING-5)), buttonWith, 0);
                         }
                         
                         //                          if ([[UIScreen mainScreen] bounds].size.height == 568)
                         //                          {
                         //                              _contactBtnTextView.frame = CGRectMake(10, 100, 300, 0);
                         //                          }
                         //                         else
                         //                         {
                         //                         _contactBtnTextView.frame = CGRectMake(10, 100, 300, 0);
                         //                         }
                         //  [_contactBtnTextView setFrame:CGRectMake(_contactBtn.frame.origin.x, _contactBtn.frame.origin.y+40, _contactBtn.frame.size.width, 0)];
                         _commonTextView.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             // Do your method here after your animation.
                             [UIView beginAnimations:@"advancedAnimations" context:nil];
                             [UIView setAnimationDuration:0.3];
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 _aboutUsBtn.frame = CGRectMake(18, yButton, buttonWith, BTN_HEIGHT);
                                 _managementTeamBtn.frame = CGRectMake(18, yButton+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT);
                                 _ceoDeskBtn.frame = CGRectMake(18, yButton+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT);
                                 //_partnersBtn.frame = CGRectMake(10, 380, 300, BTN_HEIGHT);
                                 
                             }
                             else
                             {
                                 
                                 _aboutUsBtn.frame = CGRectMake(18, yButton, buttonWith, BTN_HEIGHT);
                                 _managementTeamBtn.frame = CGRectMake(18, yButton+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT);
                                 _ceoDeskBtn.frame = CGRectMake(18, yButton+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT);
                                 // _partnersBtn.frame = CGRectMake(10, 320, 300, BTN_HEIGHT);
                                 
                             }
                             [UIView commitAnimations];
                         }
                     }];
    }
    else{
        
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 _commonTextView.frame = CGRectMake(18, 259+(btnIndex*(BTN_HEIGHT+PADDING-5)), buttonWith, 0);
                             }
                             else
                             {
                                 _commonTextView.frame = CGRectMake(18, 195+(btnIndex*(BTN_HEIGHT+PADDING-5)), buttonWith, 0);
                             }
                             
                             //                          if ([[UIScreen mainScreen] bounds].size.height == 568)
                             //                          {
                             //                              _contactBtnTextView.frame = CGRectMake(10, 100, 300, 0);
                             //                          }
                             //                         else
                             //                         {
                             //                         _contactBtnTextView.frame = CGRectMake(10, 100, 300, 0);
                             //                         }
                             //  [_contactBtnTextView setFrame:CGRectMake(_contactBtn.frame.origin.x, _contactBtn.frame.origin.y+40, _contactBtn.frame.size.width, 0)];
                             _commonTextView.hidden = YES;
                         }
                         completion:^(BOOL finished){
                             if (finished) {
                                 // Do your method here after your animation.
                                 [UIView beginAnimations:@"advancedAnimations" context:nil];
                                 [UIView setAnimationDuration:0.3];
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                      float changeY=250.0;
                                     _aboutUsBtn.frame = CGRectMake(18, yButton-changeY, buttonWith, BTN_HEIGHT);
                                     _managementTeamBtn.frame = CGRectMake(18, yButton-changeY+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT);
                                     _ceoDeskBtn.frame = CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT);
                                     //_partnersBtn.frame = CGRectMake(10, 380, 300, BTN_HEIGHT);
                                     
                                 }
                                 else
                                 {
                                      float changeY=250.0;
                                     _aboutUsBtn.frame = CGRectMake(18, yButton-changeY, buttonWith, BTN_HEIGHT);
                                     _managementTeamBtn.frame = CGRectMake(18, yButton-changeY+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT);
                                     _ceoDeskBtn.frame = CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT);
                                     // _partnersBtn.frame = CGRectMake(10, 320, 300, BTN_HEIGHT);
                                     
                                 }
                                 [UIView commitAnimations];
                             }
                         }];

    }
    isExpanded = NO;
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    if (!apperAboutUs) {
        return;
    }
   
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
       
         buttonWith=1024-36;
        if (isExpanded) {
            
            [self landScabeModeButtons];
        }
        else{
            float changeY=250.0;
            _aboutUsBtn.frame = CGRectMake(18, yButton-changeY, buttonWith, BTN_HEIGHT);
            _managementTeamBtn.frame = CGRectMake(18, yButton-changeY+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT);
            _ceoDeskBtn.frame = CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT);
            // _partnersBtn.frame = CGRectMake(10, 240+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
            _commonTextView.frame = CGRectMake(18, yButton-changeY+BTN_HEIGHT, buttonWith, 0);
            topImgView.frame=CGRectMake(topImgView.frame.origin.x, topImgView.frame.origin.y,  buttonWith+5, 412);
 
            
        }
        
      
        topImgView.frame=CGRectMake(topImgView.frame.origin.x, topImgView.frame.origin.y,  buttonWith+5, 412);
       topImgView.image = [UIImage imageNamed:@"AboutUs-bgLandCabe.jpg"];
        /*
        
        _aboutUsBtn.frame =CGRectMake(_aboutUsBtn.frame.origin.x, _aboutUsBtn.frame.origin.y-changeY,buttonWith, _aboutUsBtn.frame.size.height);
        _managementTeamBtn.frame =CGRectMake(_managementTeamBtn.frame.origin.x, _managementTeamBtn.frame.origin.y-changeY,buttonWith, _managementTeamBtn.frame.size.height);
        _ceoDeskBtn.frame =CGRectMake(_ceoDeskBtn.frame.origin.x, _ceoDeskBtn.frame.origin.y-changeY,buttonWith, _ceoDeskBtn.frame.size.height);
        
         _commonTextView.frame =CGRectMake(_commonTextView.frame.origin.x, _commonTextView.frame.origin.y-changeY,buttonWith, _commonTextView.frame.size.height);*/
        [self landScabeNavigation];
       
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        buttonWith=1024-36;
        if (isExpanded) {
            [self landScabeModeButtons];

        }
        else{
            float changeY=250.0;
            _aboutUsBtn.frame = CGRectMake(18, yButton-changeY, buttonWith, BTN_HEIGHT);
            _managementTeamBtn.frame = CGRectMake(18, yButton-changeY+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT);
            _ceoDeskBtn.frame = CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT);
            // _partnersBtn.frame = CGRectMake(10, 240+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
            _commonTextView.frame = CGRectMake(18, yButton-changeY+BTN_HEIGHT, buttonWith, 0);
            topImgView.frame=CGRectMake(topImgView.frame.origin.x, topImgView.frame.origin.y,  buttonWith+5, 412);
  
        }
      
       topImgView.frame=CGRectMake(topImgView.frame.origin.x, topImgView.frame.origin.y,  buttonWith+5, 412);
        topImgView.image = [UIImage imageNamed:@"AboutUs-bgLandCabe.jpg"];
        
         /*
        _aboutUsBtn.frame =CGRectMake(_aboutUsBtn.frame.origin.x, _aboutUsBtn.frame.origin.y-changeY,buttonWith, _aboutUsBtn.frame.size.height);
        _managementTeamBtn.frame =CGRectMake(_managementTeamBtn.frame.origin.x, _managementTeamBtn.frame.origin.y-changeY,buttonWith, _managementTeamBtn.frame.size.height);
        _ceoDeskBtn.frame =CGRectMake(_ceoDeskBtn.frame.origin.x, _ceoDeskBtn.frame.origin.y-changeY,buttonWith, _ceoDeskBtn.frame.size.height);
        
        _commonTextView.frame =CGRectMake(_commonTextView.frame.origin.x, _commonTextView.frame.origin.y-changeY,buttonWith, _commonTextView.frame.size.height);*/
       [self landScabeNavigation];


    }
    else {
      
         //[buttonBg setFrame:CGRectMake(0, 0, 768, 1024)];
        
       // buttonBg.center=CGPointMake(768/2,1024/2);
        buttonWith=768-36;
        
        if (isExpanded) {
            [self potraitModeButtons];
        }
        else{
            _aboutUsBtn.frame = CGRectMake(18, yButton, buttonWith, BTN_HEIGHT);
            _managementTeamBtn.frame = CGRectMake(18, yButton+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT);
            _ceoDeskBtn.frame = CGRectMake(18, yButton+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT);
            // _partnersBtn.frame = CGRectMake(10, 240+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
            _commonTextView.frame = CGRectMake(18, yButton+BTN_HEIGHT, buttonWith, 0);

        }
        topImgView.frame=CGRectMake(topImgView.frame.origin.x, topImgView.frame.origin.y, buttonWith+5, 660);
        
        topImgView.image = [UIImage imageNamed:@"AboutUs-bg.jpg"];
        
        [self potraitNavigation];
        
        /*
        _aboutUsBtn.frame =CGRectMake(_aboutUsBtn.frame.origin.x, _aboutUsBtn.frame.origin.y+changeY,buttonWith, _aboutUsBtn.frame.size.height);
        _managementTeamBtn.frame =CGRectMake(_managementTeamBtn.frame.origin.x, _managementTeamBtn.frame.origin.y+changeY,buttonWith, _managementTeamBtn.frame.size.height);
        _ceoDeskBtn.frame =CGRectMake(_ceoDeskBtn.frame.origin.x, _ceoDeskBtn.frame.origin.y+changeY,buttonWith, _ceoDeskBtn.frame.size.height);
        
        _commonTextView.frame =CGRectMake(_commonTextView.frame.origin.x, _commonTextView.frame.origin.y+changeY,buttonWith, _commonTextView.frame.size.height);*/

        
    }
}

-(void)landScabeModeButtons{
    
        // Do your animations here.
        
        float changeY=250.0;
        if (btnIndex == 1)
        {
            //contact button
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutUsBtn setFrame:CGRectMake(18, 264, buttonWith, BTN_HEIGHT)];
                 [_managementTeamBtn setFrame:CGRectMake(18, yButton-changeY+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                [_ceoDeskBtn setFrame:CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];

               
            }
            else
            {
                [_aboutUsBtn setFrame:CGRectMake(18,200, buttonWith, BTN_HEIGHT)];
                [_managementTeamBtn setFrame:CGRectMake(18, yButton-changeY+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                [_ceoDeskBtn setFrame:CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];


            }
        }
        else if (btnIndex == 2)
        {
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutUsBtn setFrame:CGRectMake(18, 264, buttonWith, BTN_HEIGHT)];
                [_managementTeamBtn setFrame:CGRectMake(18, 264+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                [_ceoDeskBtn setFrame:CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
            }
            else
            {
                [_aboutUsBtn setFrame:CGRectMake(18, 200, buttonWith, BTN_HEIGHT)];
                [_managementTeamBtn setFrame:CGRectMake(18, 200+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                [_ceoDeskBtn setFrame:CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
            }
        }
        else if (btnIndex == 3)
        {
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutUsBtn setFrame:CGRectMake(18, 264, buttonWith, BTN_HEIGHT)];
                [_managementTeamBtn setFrame:CGRectMake(18, 264+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                [_ceoDeskBtn setFrame:CGRectMake(18, 264+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
            }
            else
            {
                [_aboutUsBtn setFrame:CGRectMake(18, 200, buttonWith, BTN_HEIGHT)];
                [_managementTeamBtn setFrame:CGRectMake(18, 200+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
                [_ceoDeskBtn setFrame:CGRectMake(18, 200+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
            }
        }
    
    float textViewHeight = 0;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        textViewHeight = 230.0;
    }
    else
    {
        textViewHeight =230.0;
    }
    
    if (btnIndex == 1) {
        [_commonTextView setFrame:CGRectMake(_aboutUsBtn.frame.origin.x, _aboutUsBtn.frame.origin.y+BTN_HEIGHT, _aboutUsBtn.frame.size.width, textViewHeight)];
           }
    else if (btnIndex == 2)
    {
        [_commonTextView setFrame:CGRectMake(_managementTeamBtn.frame.origin.x, _managementTeamBtn.frame.origin.y+BTN_HEIGHT, _managementTeamBtn.frame.size.width, textViewHeight)];
           }
    else if (btnIndex == 3)
    {
        [_commonTextView setFrame:CGRectMake(_ceoDeskBtn.frame.origin.x, _ceoDeskBtn.frame.origin.y+BTN_HEIGHT, _ceoDeskBtn.frame.size.width, textViewHeight)];
        
    }

    
    
    
}
-(void)potraitModeButtons{
    // Do your animations here.
    float changeY=0.0;
    if (btnIndex == 1)
    {
        //contact button
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            [_aboutUsBtn setFrame:CGRectMake(18,464, buttonWith, BTN_HEIGHT)];
            [_managementTeamBtn setFrame:CGRectMake(18,yButton-changeY+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
            [_ceoDeskBtn setFrame:CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
        }
        else
        {
            [_aboutUsBtn setFrame:CGRectMake(18,400, buttonWith, BTN_HEIGHT)];
             [_managementTeamBtn setFrame:CGRectMake(18, yButton-changeY+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
             [_ceoDeskBtn setFrame:CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
            
        }
    }
    else if (btnIndex == 2)
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            [_aboutUsBtn setFrame:CGRectMake(18, 464, buttonWith, BTN_HEIGHT)];
            [_managementTeamBtn setFrame:CGRectMake(18,464+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
             [_ceoDeskBtn setFrame:CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
        }
        else
        {
            [_aboutUsBtn setFrame:CGRectMake(18, 400, buttonWith, BTN_HEIGHT)];
            [_managementTeamBtn setFrame:CGRectMake(18, 400+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
             [_ceoDeskBtn setFrame:CGRectMake(18, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
        }
    }
    else if (btnIndex == 3)
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            [_aboutUsBtn setFrame:CGRectMake(18, 464, buttonWith, BTN_HEIGHT)];
            [_managementTeamBtn setFrame:CGRectMake(18, 464+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
            [_ceoDeskBtn setFrame:CGRectMake(18, 464+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
        }
        else
        {
            [_aboutUsBtn setFrame:CGRectMake(18, 400, buttonWith, BTN_HEIGHT)];
            [_managementTeamBtn setFrame:CGRectMake(18, 400+BTN_HEIGHT+PADDING, buttonWith, BTN_HEIGHT)];
            [_ceoDeskBtn setFrame:CGRectMake(18, 400+2*(BTN_HEIGHT+PADDING), buttonWith, BTN_HEIGHT)];
        }
    }
    
    float textViewHeight = 0;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        textViewHeight =280.0;
    }
    else
    {
        textViewHeight = 280.0;
    }
    
    if (btnIndex == 1) {
        [_commonTextView setFrame:CGRectMake(_aboutUsBtn.frame.origin.x, _aboutUsBtn.frame.origin.y+BTN_HEIGHT, _aboutUsBtn.frame.size.width, textViewHeight)];
      
    }
    else if (btnIndex == 2)
    {
        [_commonTextView setFrame:CGRectMake(_managementTeamBtn.frame.origin.x, _managementTeamBtn.frame.origin.y+BTN_HEIGHT, _managementTeamBtn.frame.size.width, textViewHeight)];
        
    }
    else if (btnIndex == 3)
    {
        [_commonTextView setFrame:CGRectMake(_ceoDeskBtn.frame.origin.x, _ceoDeskBtn.frame.origin.y+BTN_HEIGHT, _ceoDeskBtn.frame.size.width, textViewHeight)];
        
    }

    
}

- (void)didRotateFromInterfaceOrientation: (UIInterfaceOrientation)fromInterfaceOrientation
{
	int i = 0;
	
	switch (self.interfaceOrientation){
		case UIInterfaceOrientationPortrait:
			i = 0;
			break;
		case UIInterfaceOrientationPortraitUpsideDown:
			i = 180;
			break;
		case UIInterfaceOrientationLandscapeLeft:
			i = -90;
			break;
		case UIInterfaceOrientationLandscapeRight:
			i = 90;
			break;
	}
	
	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
