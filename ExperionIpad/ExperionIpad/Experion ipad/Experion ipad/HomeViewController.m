//
//  HomeViewController.m
//  Experion ipad
//
//  Created by Ranjeet on 09/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import "HomeViewController.h"
#import "Constants.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @" Home ";
        self.tabBarItem.image = [UIImage imageNamed:@"Home.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    buttonWidth=768-45;
    ButtonHieht=50;
    
    [super viewDidLoad];
    btnIndex = 0;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        yButton=800;
        
        
    }
    else{
        yButton=770;
    }

    
    _bgImgView.userInteractionEnabled = YES;
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _bgImgView.image = [UIImage imageNamed:@"bg-568h"];
    }
    else
    {
        _bgImgView.image = [UIImage imageNamed:@"bg.png"];
    }
    
    
    _contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_contactBtn setTitle:@"   Contact" forState:UIControlStateNormal];
    _contactBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_contactBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_contactBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_contactBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    
        _contactBtn.frame = CGRectMake(20, yButton, buttonWidth, ButtonHieht);
   
    
    
    [_contactBtn addTarget:self action:@selector(contactBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _contactBtn.adjustsImageWhenHighlighted = YES;
    _contactBtn.tag = 1;
    [_bgImgView addSubview:_contactBtn];
    
    _ourOfficesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ourOfficesBtn setTitle:@"   Our Office" forState:UIControlStateNormal];
    _ourOfficesBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_ourOfficesBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_ourOfficesBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_ourOfficesBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    
        _ourOfficesBtn.frame = CGRectMake(20, yButton+ButtonHieht+20, buttonWidth, ButtonHieht);
  
    [_ourOfficesBtn addTarget:self action:@selector(ourOfficesBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _ourOfficesBtn.adjustsImageWhenHighlighted = YES;
    _ourOfficesBtn.tag = 2;
    [_bgImgView addSubview:_ourOfficesBtn];
    
    _contactBtnTextView = [[UITextView alloc]init];
    //_contactBtnTextView.frame = CGRectMake(15, 340, 290, 200);
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        _contactBtnTextView.frame = CGRectMake(20, yButton+50, buttonWidth, 0);
    }
    else
    {
        _contactBtnTextView.frame = CGRectMake(20, yButton+50, buttonWidth, 0);
        
        
    }
    
   
    _contactBtnTextView.font=[UIFont systemFontOfSize:16.0];
    _contactBtnTextView.userInteractionEnabled = YES;
    _contactBtnTextView.scrollEnabled = YES;
    _contactBtnTextView.editable = NO;
    _contactBtnTextView.delegate=self;
    //_contactBtnTextView.backgroundColor = [UIColor brownColor];
    //_contactBtnTextView.text = @"\nThis is not just a game.....This is not just a game.....This is not just a game.....This is not just a game.....This is not just a game.....";
    [_contactBtnTextView setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:0.8]];
    _contactBtnTextView.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
    [_bgImgView addSubview:_contactBtnTextView];
    // _contactBtnTextView.text = CONTACT;
    _contactBtnTextView.hidden = YES;
    
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
       
    }
    else
    {
      [self orientationChange];
        
    }
    

}

-(void)orientationChange{
    // UIImage *landscapeImage = [UIImage imageNamed:@"navBarLandScape.png"];
    // [self.navigationController.navigationBar setBackIndicatorImage:landscapeImage];
    float changeY=250.0;
    buttonWidth=1024-45;
    
    
    _contactBtn.frame =CGRectMake(_contactBtn.frame.origin.x, _contactBtn.frame.origin.y-changeY,buttonWidth, _contactBtn.frame.size.height);
   
    _ourOfficesBtn.frame =CGRectMake(_ourOfficesBtn.frame.origin.x, _ourOfficesBtn.frame.origin.y-changeY,buttonWidth, _ourOfficesBtn.frame.size.height);
   
    
    _contactBtnTextView.frame =CGRectMake(_contactBtnTextView.frame.origin.x, _contactBtnTextView.frame.origin.y-changeY,buttonWidth, _contactBtnTextView.frame.size.height);
    
    _bgImgView.image = [UIImage imageNamed:@"bglandScbe.png"];
    
    [self landScabeNavigation];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.tabBarController.delegate = self;
    [self resetView];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self resetView];
}

#pragma mark - Tab Bar Delegate
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // NSLog(@"55 Selected INDEX OF TAB-BAR ==> %i", tabBarController.selectedIndex);
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark -
// Reseting All Outlets in View to original state
-(void)resetView
{
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
        buttonWidth=768-45;
        _contactBtnTextView.frame = CGRectMake(20, yButton+50, buttonWidth, 0);
        [_contactBtn setFrame:CGRectMake(20,yButton, buttonWidth, ButtonHieht)];
        [_ourOfficesBtn setFrame:CGRectMake(20, yButton+ButtonHieht+20, buttonWidth, ButtonHieht)];
        _bgImgView.image = [UIImage imageNamed:@"bg.png"];

        [self potraitNavigation];
    }
    else{
        buttonWidth=1024-45;
        float changeY=250.0;
       
        _contactBtnTextView.frame = CGRectMake(20, yButton-changeY+50, buttonWidth, 0);
        [_contactBtn setFrame:CGRectMake(20,yButton-changeY, buttonWidth, ButtonHieht)];
        [_ourOfficesBtn setFrame:CGRectMake(20, yButton-changeY+ButtonHieht+20, buttonWidth, ButtonHieht)];
     _bgImgView.image = [UIImage imageNamed:@"bglandScbe.png"];
        [self landScabeNavigation];
        
    }

    
    isExpanded = NO;
    isContactBtnOn = NO;
    isOurOffBtnOn = NO;
}

//Handling Animation for first button
-(void)contactBtnClicked:(id)sender
{
    btnIndex = 1;
    _contactBtnTextView.scrollEnabled=NO;
    _contactBtnTextView.text=nil;
    _contactBtnTextView.text = CONTACT;
    _contactBtnTextView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
    _contactBtnTextView.scrollEnabled=YES;
    
    //_contactBtnTextView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    [_contactBtnTextView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    // [_contactBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Up"] forState:UIControlStateNormal];
    
    if (!isContactBtnOn) {
        
        isOurOffBtnOn = NO;
        isContactBtnOn = YES;
        [self setButtonToInitialFrame];
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.5];
        //isExpanded = YES;
    }
    else
    {
        //isExpanded = NO;
        //[_contactBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
        isContactBtnOn = NO;
        [self setButtonToInitialFrame];
        
    }
    
}

//Handling Animation for second button
-(void)ourOfficesBtnClicked:(id)sender
{
    btnIndex = 2;
        //[_ourOfficesBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Up"] forState:UIControlStateNormal];
    if (!isOurOffBtnOn)
    {
        isOurOffBtnOn = YES;
        isContactBtnOn = NO;
        [self setButtonToInitialFrame];
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.5];
        
    }
    else
    {
        //[_ourOfficesBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
        isOurOffBtnOn = NO;
        [self setButtonToInitialFrame];
    }
}

//Generic Method to handle all Animation with frame accordingly
-(void)showHideContent
{
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
                                 [_contactBtn setFrame:CGRectMake(20, 464, buttonWidth, ButtonHieht)];
                             }
                             else
                             {
                                 [_contactBtn setFrame:CGRectMake(20, 400, buttonWidth, ButtonHieht)];
                             }
                         }
                         else
                         {
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_contactBtn setFrame:CGRectMake(20, 464, buttonWidth, ButtonHieht)];
                                 [_ourOfficesBtn setFrame:CGRectMake(20, 464+ButtonHieht+20, buttonWidth, ButtonHieht)];
                             }
                             else
                             {
                                 [_contactBtn setFrame:CGRectMake(20, 400, buttonWidth, ButtonHieht)];
                                 [_ourOfficesBtn setFrame:CGRectMake(20, 400+ButtonHieht+20, buttonWidth, ButtonHieht)];
                             }
                         }
                         // _contactBtn.frame = CGRectMake(10, 60, 300, 40);
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             // Do your method here after your animation.
                             [UIView beginAnimations:@"advancedAnimations" context:nil];
                             [UIView setAnimationDuration:0.5];
                             float textViewHeight = 0;
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 textViewHeight =320.0;
                             }
                             else
                             {
                                 textViewHeight = 320.0;
                             }

                             if (btnIndex == 1) {
                                 [_contactBtnTextView setFrame:CGRectMake(_contactBtn.frame.origin.x, _contactBtnTextView.frame.origin.y, _contactBtn.frame.size.width, textViewHeight)];
                                 
                                 _contactBtnTextView.scrollEnabled=NO;
                                 _contactBtnTextView.text=nil;
                                 _contactBtnTextView.text = CONTACT;
                                 _contactBtnTextView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
                                 _contactBtnTextView.scrollEnabled=YES;
                                 
                                 //_contactBtnTextView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
                                 [_contactBtnTextView setContentOffset:CGPointMake(0, 0) animated:NO];
                             }
                             else
                             {
                                 [_contactBtnTextView setFrame:CGRectMake(_ourOfficesBtn.frame.origin.x, _contactBtnTextView.frame.origin.y, _ourOfficesBtn.frame.size.width, textViewHeight)];
                                
                                 _contactBtnTextView.scrollEnabled=NO;
                                 _contactBtnTextView.text=nil;
                                 _contactBtnTextView.text = OUR_OFFICES;
                                 _contactBtnTextView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
                                 
                                 _contactBtnTextView.scrollEnabled=YES;
                                 [_contactBtnTextView setContentOffset:CGPointMake(0, 0) animated:NO];

                             }
                             
                              NSLog(@"frme of after text=====%f",_contactBtnTextView.frame.origin.y);
                              NSLog(@"frme of of office button=====%f",_ourOfficesBtn.frame.origin.y);
                             
                             NSLog(@"frme of of contatcus button=====%f",_contactBtn.frame.origin.y);
                             [UIView commitAnimations];
                             _contactBtnTextView.hidden = NO;
                             
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
                                     [_contactBtn setFrame:CGRectMake(20, 264, buttonWidth, ButtonHieht)];
                                 }
                                 else
                                 {
                                     [_contactBtn setFrame:CGRectMake(20, 200, buttonWidth, ButtonHieht)];
                                 }
                             }
                             else
                             {
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     [_contactBtn setFrame:CGRectMake(20, 264, buttonWidth, ButtonHieht)];
                                     [_ourOfficesBtn setFrame:CGRectMake(20, 264+ButtonHieht+20, buttonWidth, ButtonHieht)];
                                 }
                                 else
                                 {
                                     [_contactBtn setFrame:CGRectMake(20, 200, buttonWidth, ButtonHieht)];
                                     [_ourOfficesBtn setFrame:CGRectMake(20, 200+ButtonHieht+20, buttonWidth, ButtonHieht)];
                                 }
                             }
                             // _contactBtn.frame = CGRectMake(10, 60, 300, 40);
                         }
                         completion:^(BOOL finished){
                             if (finished) {
                                 // Do your method here after your animation.
                                 [UIView beginAnimations:@"advancedAnimations" context:nil];
                                 [UIView setAnimationDuration:0.5];
                                 float textViewHeight = 0;
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     textViewHeight =290.0;
                                 }
                                 else
                                 {
                                     textViewHeight = 290.0;
                                 }
                                 
                                 if (btnIndex == 1) {
                                     [_contactBtnTextView setFrame:CGRectMake(_contactBtn.frame.origin.x, _contactBtnTextView.frame.origin.y, _contactBtn.frame.size.width, textViewHeight)];
                                     _contactBtnTextView.scrollEnabled=NO;
                                     _contactBtnTextView.text=nil;
                                     _contactBtnTextView.text = CONTACT;
                                     _contactBtnTextView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
                                     _contactBtnTextView.scrollEnabled=YES;
                                     
                                     //_contactBtnTextView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
                                     [_contactBtnTextView setContentOffset:CGPointMake(0, 0) animated:NO];
                                 }
                                 else
                                 {
                                     [_contactBtnTextView setFrame:CGRectMake(_ourOfficesBtn.frame.origin.x, _contactBtnTextView.frame.origin.y, _ourOfficesBtn.frame.size.width, textViewHeight)];
                                     _contactBtnTextView.scrollEnabled=NO;
                                     _contactBtnTextView.text=nil;
                                     _contactBtnTextView.text = OUR_OFFICES;
                                     _contactBtnTextView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
                                     
                                     _contactBtnTextView.scrollEnabled=YES;
                                     [_contactBtnTextView setContentOffset:CGPointMake(0, 0) animated:NO];

                                 }
                                 
                                 
                                 
                                 [UIView commitAnimations];
                                 _contactBtnTextView.hidden = NO;
                                 
                             }
                         }];
    }
    isExpanded = YES;
  //  _contactBtnTextView.contentInset = UIEdgeInsetsMake(0,68,0,0);
    
}

-(void)showHideContentOfficeBtnClicked
{
    [self setButtonToInitialFrame];
    if (!isExpanded) {
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.5];
    }
    
}

//Setting Buttons to their initial state/frame
-(void) setButtonToInitialFrame
{
   
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         if (btnIndex==1) {
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 _contactBtnTextView.frame = CGRectMake(20, 464+(btnIndex*50) , buttonWidth, 0);
                             }
                             else
                             {
                                 _contactBtnTextView.frame = CGRectMake(20, 400+(btnIndex*50), buttonWidth, 0);;
                             }
  
                         }
                         else{
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 _contactBtnTextView.frame = CGRectMake(20, 464+(btnIndex*50)+20 , buttonWidth, 0);
                             }
                             else
                             {
                                 _contactBtnTextView.frame = CGRectMake(20, 400+(btnIndex*50)+20, buttonWidth, 0);;
                             }

                             
                         }
                         
                         NSLog(@"frme of in initial uitext=====%f",_contactBtnTextView.frame.origin.y);
                         _contactBtnTextView.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             // Do your method here after your animation.
                             [UIView beginAnimations:@"advancedAnimations" context:nil];
                             [UIView setAnimationDuration:0.3];
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_contactBtn setFrame:CGRectMake(20, yButton, buttonWidth, ButtonHieht)];
                                 [_ourOfficesBtn setFrame:CGRectMake(20, yButton+ButtonHieht+20, buttonWidth, ButtonHieht)];
                             }
                             else
                             {
                                 [_contactBtn setFrame:CGRectMake(20, yButton, buttonWidth, ButtonHieht)];
                                 [_ourOfficesBtn setFrame:CGRectMake(20, yButton+ButtonHieht+20, buttonWidth, ButtonHieht)];
                             }
                            // NSLog(@"frme of of uitext=====%f",_ourOfficesBtn.frame.origin.y);

                             
                             [UIView commitAnimations];
                         }
                     }];
    }
    else{
        
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             if (btnIndex==1) {
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     _contactBtnTextView.frame = CGRectMake(20, 264+(btnIndex*50), buttonWidth, 0);
                                 }
                                 else
                                 {
                                     _contactBtnTextView.frame = CGRectMake(20, 200+(btnIndex*50), buttonWidth, 0);;
                                 }
                             }
                             else{
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     _contactBtnTextView.frame = CGRectMake(20, 264+(btnIndex*50)+20, buttonWidth, 0);
                                 }
                                 else
                                 {
                                     _contactBtnTextView.frame = CGRectMake(20, 200+(btnIndex*50)+20, buttonWidth, 0);;
                                 }
                             }
                             
                             _contactBtnTextView.hidden = YES;
                         }
                         completion:^(BOOL finished){
                             if (finished) {
                                 // Do your method here after your animation.
                                 [UIView beginAnimations:@"advancedAnimations" context:nil];
                                 [UIView setAnimationDuration:0.3];
                                 float changeY=250.0;
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     [_contactBtn setFrame:CGRectMake(20, yButton-changeY, buttonWidth, ButtonHieht)];
                                     [_ourOfficesBtn setFrame:CGRectMake(20, yButton-changeY+ButtonHieht+20, buttonWidth, ButtonHieht)];
                                 }
                                 else
                                 {
                                     [_contactBtn setFrame:CGRectMake(20, yButton-changeY, buttonWidth, ButtonHieht)];
                                     [_ourOfficesBtn setFrame:CGRectMake(20, yButton-changeY+ButtonHieht+20, buttonWidth, ButtonHieht)];
                                 }
                                 
                                 [UIView commitAnimations];
                             }
                         }];

        
    }
    isExpanded = NO;
   
    
}



- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
         _bgImgView.image = [UIImage imageNamed:@"bglandScbe.png"];
         buttonWidth=1024-45;
        if (isExpanded) {
            [self landScapeButton1];
        }
        else{
            
            buttonWidth=1024-45;
            float changeY=250.0;
            
            _contactBtnTextView.frame = CGRectMake(20, yButton-changeY+50, buttonWidth, 0);
            [_contactBtn setFrame:CGRectMake(20,yButton-changeY, buttonWidth, ButtonHieht)];
            [_ourOfficesBtn setFrame:CGRectMake(20, yButton-changeY+ButtonHieht+20, buttonWidth, ButtonHieht)];

        }
        
        [self landScabeNavigation];
        
        
        
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
         _bgImgView.image = [UIImage imageNamed:@"bglandScbe.png"];
         buttonWidth=1024-45;
        if (isExpanded) {
             [self landScapeButton1];
        }
        else{
           
            buttonWidth=1024-45;
            float changeY=250.0;
            
            _contactBtnTextView.frame = CGRectMake(20, yButton-changeY+50, buttonWidth, 0);
            [_contactBtn setFrame:CGRectMake(20,yButton-changeY, buttonWidth, ButtonHieht)];
            [_ourOfficesBtn setFrame:CGRectMake(20, yButton-changeY+ButtonHieht+20, buttonWidth, ButtonHieht)];

        }
        
        [self landScabeNavigation];
        
    }
    else{
        
         buttonWidth=768-45;
        if (isExpanded) {
             [self potraitButton1];
        }
        else{
            buttonWidth=768-45;
            _contactBtnTextView.frame = CGRectMake(20, yButton+50, buttonWidth, 0);
            [_contactBtn setFrame:CGRectMake(20,yButton, buttonWidth, ButtonHieht)];
            [_ourOfficesBtn setFrame:CGRectMake(20, yButton+ButtonHieht+20, buttonWidth, ButtonHieht)];
        }
        _bgImgView.image = [UIImage imageNamed:@"bg.png"];

        [self potraitNavigation];
        
    }
    
    
}


-(void)landScapeButton1{
    if (btnIndex == 1)
    {
        float changeY=250.0;
        //contact button
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            [_contactBtn setFrame:CGRectMake(20, 264, buttonWidth, ButtonHieht)];
             [_ourOfficesBtn setFrame:CGRectMake(20, yButton-changeY+ButtonHieht+20, buttonWidth, ButtonHieht)];
        }
        else
        {
            [_contactBtn setFrame:CGRectMake(20, 200, buttonWidth, ButtonHieht)];
            [_ourOfficesBtn setFrame:CGRectMake(20, yButton-changeY+ButtonHieht+20, buttonWidth, ButtonHieht)];
        }
    }
    else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            [_contactBtn setFrame:CGRectMake(20, 264, buttonWidth, ButtonHieht)];
            [_ourOfficesBtn setFrame:CGRectMake(20, 264+ButtonHieht+20, buttonWidth, ButtonHieht)];
        }
        else
        {
            [_contactBtn setFrame:CGRectMake(20, 200, buttonWidth, ButtonHieht)];
            [_ourOfficesBtn setFrame:CGRectMake(20, 200+ButtonHieht+20, buttonWidth, ButtonHieht)];
        }
    }

    float textViewHeight = 0;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        textViewHeight =290.0;
    }
    else
    {
        textViewHeight = 290.0;
    }
    
    if (btnIndex == 1) {
        [_contactBtnTextView setFrame:CGRectMake(_contactBtn.frame.origin.x, _contactBtn.frame.origin.y+ButtonHieht, _contactBtn.frame.size.width, textViewHeight)];
    }
    else
    {
        [_contactBtnTextView setFrame:CGRectMake(_ourOfficesBtn.frame.origin.x, _ourOfficesBtn.frame.origin.y+ButtonHieht, _ourOfficesBtn.frame.size.width, textViewHeight)];
    }
    

    
}

-(void)potraitButton1{
    
    if (btnIndex == 1)
    {
        //contact button
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            [_contactBtn setFrame:CGRectMake(20, 464, buttonWidth, ButtonHieht)];
           [_ourOfficesBtn setFrame:CGRectMake(20, yButton+ButtonHieht+20, buttonWidth, ButtonHieht)];
        }
        else
        {
            [_contactBtn setFrame:CGRectMake(20, 400, buttonWidth, ButtonHieht)];
           [_ourOfficesBtn setFrame:CGRectMake(20, yButton+ButtonHieht+20, buttonWidth, ButtonHieht)];
        }
    }
    else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            [_contactBtn setFrame:CGRectMake(20, 464, buttonWidth, ButtonHieht)];
            [_ourOfficesBtn setFrame:CGRectMake(20, 464+ButtonHieht+20, buttonWidth, ButtonHieht)];
        }
        else
        {
            [_contactBtn setFrame:CGRectMake(20, 400, buttonWidth, ButtonHieht)];
            [_ourOfficesBtn setFrame:CGRectMake(20, 400+ButtonHieht+20, buttonWidth, ButtonHieht)];
        }
    }

    
    float textViewHeight = 0;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        textViewHeight =320.0;
    }
    else
    {
        textViewHeight = 320.0;
    }
    
    if (btnIndex == 1) {
        [_contactBtnTextView setFrame:CGRectMake(_contactBtn.frame.origin.x, _contactBtn.frame.origin.y+ButtonHieht, _contactBtn.frame.size.width, textViewHeight)];
    }
    else
    {
        [_contactBtnTextView setFrame:CGRectMake(_ourOfficesBtn.frame.origin.x, _ourOfficesBtn.frame.origin.y+ButtonHieht, _ourOfficesBtn.frame.size.width, textViewHeight)];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
