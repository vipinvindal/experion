//
//  HomeViewController.m
//  Experion
//
//  Created by Sam on 14/11/13.
//  Copyright (c) 2013 Bets. All rights reserved.
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
        self.title = @"Home";
        self.tabBarItem.image = [UIImage imageNamed:@"Home.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnIndex = 0;
    
    _bgImgView.userInteractionEnabled = YES;
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _bgImgView.image = [UIImage imageNamed:@"bg-568h"]; 
    }
    else
    {
        _bgImgView.image = [UIImage imageNamed:@"bg"];  
    }
    _contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_contactBtn setTitle:@"   Contact" forState:UIControlStateNormal];
    _contactBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_contactBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_contactBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_contactBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _contactBtn.frame = CGRectMake(10, 380, 300, 40);
    }
    else
    {
        _contactBtn.frame = CGRectMake(10, 300, 300, 40);
    }
    
    
    [_contactBtn addTarget:self action:@selector(contactBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _contactBtn.adjustsImageWhenHighlighted = YES;
    _contactBtn.tag = 1;
    [_bgImgView addSubview:_contactBtn];
    
    _ourOfficesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ourOfficesBtn setTitle:@"   Our Office" forState:UIControlStateNormal];
    _ourOfficesBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_ourOfficesBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_ourOfficesBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_ourOfficesBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _ourOfficesBtn.frame = CGRectMake(10, 430, 300, 40);
    }
    else
    {
        _ourOfficesBtn.frame = CGRectMake(10, 350, 300, 40);
    }
    [_ourOfficesBtn addTarget:self action:@selector(ourOfficesBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _ourOfficesBtn.adjustsImageWhenHighlighted = YES;
    _ourOfficesBtn.tag = 2;
    [_bgImgView addSubview:_ourOfficesBtn];
    
    _contactBtnTextView = [[UITextView alloc]init];
    //_contactBtnTextView.frame = CGRectMake(15, 340, 290, 200);
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _contactBtnTextView.frame = CGRectMake(10, 140, 300, 0);
    }
    else
    {
        _contactBtnTextView.frame = CGRectMake(10, 100, 300, 0);
    }
    
    _contactBtnTextView.userInteractionEnabled = YES;
    _contactBtnTextView.scrollEnabled = YES;
    _contactBtnTextView.editable = NO;
    //_contactBtnTextView.backgroundColor = [UIColor brownColor];
    //_contactBtnTextView.text = @"\nThis is not just a game.....This is not just a game.....This is not just a game.....This is not just a game.....This is not just a game.....";
    [_contactBtnTextView setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:0.8]];
    _contactBtnTextView.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
    [_bgImgView addSubview:_contactBtnTextView];
    // _contactBtnTextView.text = CONTACT;
    _contactBtnTextView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.tabBarController.delegate = self;
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
    if ([[UIScreen mainScreen] bounds].size.height == 568)
        
    {
        _contactBtnTextView.frame = CGRectMake(10, 140, 300, 0);
        [_contactBtn setFrame:CGRectMake(10, 380, 300, 40)];
        [_ourOfficesBtn setFrame:CGRectMake(10, 430, 300, 40)];
    }
    else
    {
        _contactBtnTextView.frame = CGRectMake(10, 100, 300, 0);
        [_contactBtn setFrame:CGRectMake(10, 300, 300, 40)];
        [_ourOfficesBtn setFrame:CGRectMake(10, 350, 300, 40)];
    }
    //[_contactBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    // [_ourOfficesBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    isExpanded = NO;
    isContactBtnOn = NO;
    isOurOffBtnOn = NO;
}

//Handling Animation for first button
-(void)contactBtnClicked:(id)sender
{
    btnIndex = 1;
    _contactBtnTextView.text = CONTACT;
    _contactBtnTextView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
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
    _contactBtnTextView.text = OUR_OFFICES;
    _contactBtnTextView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
    [_contactBtnTextView setContentOffset:CGPointMake(0, 0) animated:NO];
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
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         // Do your animations here.
                         if (btnIndex == 1)
                         {
                             //contact button
                             if ([[UIScreen mainScreen] bounds].size.height == 568)
                             {
                                 [_contactBtn setFrame:CGRectMake(10, 100, 300, 40)];
                             }
                             else
                             {
                                 [_contactBtn setFrame:CGRectMake(10, 60, 300, 40)];
                             }
                         }
                         else
                         {
                             if ([[UIScreen mainScreen] bounds].size.height == 568)
                             {
                                 [_contactBtn setFrame:CGRectMake(10, 100, 300, 40)];
                                 [_ourOfficesBtn setFrame:CGRectMake(10, 150, 300, 40)];
                             }
                             else
                             {
                                 [_contactBtn setFrame:CGRectMake(10, 60, 300, 40)];
                                 [_ourOfficesBtn setFrame:CGRectMake(10, 110, 300, 40)];
                             }
                         }
                         // _contactBtn.frame = CGRectMake(10, 60, 300, 40);
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             // Do your method here after your animation.
                             [UIView beginAnimations:@"advancedAnimations" context:nil];
                             [UIView setAnimationDuration:0.5];
                             if (btnIndex == 1) {
                                 [_contactBtnTextView setFrame:CGRectMake(_contactBtn.frame.origin.x, _contactBtn.frame.origin.y+40, _contactBtn.frame.size.width, 230)];
                             }
                             else
                             {
                                 [_contactBtnTextView setFrame:CGRectMake(_ourOfficesBtn.frame.origin.x, _ourOfficesBtn.frame.origin.y+40, _ourOfficesBtn.frame.size.width, 230)];
                             }
                             
                             [UIView commitAnimations];
                             _contactBtnTextView.hidden = NO;
                             
                         }
                     }];
    isExpanded = YES;
    
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
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         if ([[UIScreen mainScreen] bounds].size.height == 568)
                         {
                             _contactBtnTextView.frame = CGRectMake(10, 100+(btnIndex*40), 300, 0);
                         }
                         else
                         {
                             _contactBtnTextView.frame = CGRectMake(10, 60+(btnIndex*40), 300, 0);;
                         }
                         _contactBtnTextView.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             // Do your method here after your animation.
                             [UIView beginAnimations:@"advancedAnimations" context:nil];
                             [UIView setAnimationDuration:0.3];
                             if ([[UIScreen mainScreen] bounds].size.height == 568)
                             {
                                 [_contactBtn setFrame:CGRectMake(10, 380, 300, 40)];
                                 [_ourOfficesBtn setFrame:CGRectMake(10, 430, 300, 40)];
                             }
                             else
                             {
                                 [_contactBtn setFrame:CGRectMake(10, 300, 300, 40)];
                                 [_ourOfficesBtn setFrame:CGRectMake(10, 350, 300, 40)];
                             }
                             
                             [UIView commitAnimations];
                         }
                     }];
    isExpanded = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
