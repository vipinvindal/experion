//
//  UserDetailsViewController.m
//  Experion
//
//  Created by Alok Khanna on 11/28/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import "UserDetailsViewController.h"

@interface UserDetailsViewController ()

@end

@implementation UserDetailsViewController
@synthesize userDetailsView;

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
    // Do any additional setup after loading the view from its nib.
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 25, 25);
    [backButton setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMe) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    
    self.bgView.userInteractionEnabled = YES;
    self.paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.paymentButton setTitle:@"   Contact" forState:UIControlStateNormal];
    self.paymentButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.paymentButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.paymentButton setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.paymentButton setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        self.paymentButton.frame = CGRectMake(10, 420, 300, 40);
    }
    else
    {
        self.paymentButton.frame = CGRectMake(10, 340, 300, 40);
    }
    
    
    [self.paymentButton addTarget:self action:@selector(contactBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.paymentButton.adjustsImageWhenHighlighted = YES;
    self.paymentButton.tag = 1;
    [self.bgView addSubview:self.paymentButton];

    
    
    
//    userDetailsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Cell bg@2x.png"]];
    
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"Cell bg@2x.png"] drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    //userDetailsView.backgroundColor = [UIColor colorWithPatternImage:image];
}


-(void)contactBtnClicked:(id)sender
{
    btnIndex = 1;
    [self.paymentBtnTextView setContentOffset:CGPointMake(0, 0) animated:NO];
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

-(void) setButtonToInitialFrame
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         if ([[UIScreen mainScreen] bounds].size.height == 568)
                         {
                             self.paymentBtnTextView.frame = CGRectMake(10, 100+(btnIndex*40), 200, 0);
                         }
                         else
                         {
                             self.paymentBtnTextView.frame = CGRectMake(10, 60+(btnIndex*40), 200, 0);;
                         }
                         self.paymentBtnTextView.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             // Do your method here after your animation.
                             [UIView beginAnimations:@"advancedAnimations" context:nil];
                             [UIView setAnimationDuration:0.3];
                             if ([[UIScreen mainScreen] bounds].size.height == 568)
                             {
                                 self.paymentButton.frame = CGRectMake(10, 420, 300, 40);
                             }
                             else
                             {
                                 self.paymentButton.frame = CGRectMake(10, 340, 300, 40);
                             }
                             
                             [UIView commitAnimations];
                         }
                     }];
    isExpanded = NO;
    
}


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
                                 [self.paymentButton setFrame:CGRectMake(10, 240, 300, 40)];
                             }
                             else
                             {
                                 [self.paymentButton setFrame:CGRectMake(10, 190, 300, 40)];
                             }
                         }
                         else
                         {
                             if ([[UIScreen mainScreen] bounds].size.height == 568)
                             {
                                 [self.paymentButton setFrame:CGRectMake(10, 100, 300, 40)];
//                                 [_ourOfficesBtn setFrame:CGRectMake(10, 150, 300, 40)];
                             }
                             else
                             {
                                 [self.paymentButton setFrame:CGRectMake(10, 60, 300, 40)];
//                                 [_ourOfficesBtn setFrame:CGRectMake(10, 110, 300, 40)];
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
                                 [self.paymentBtnTextView setFrame:CGRectMake(self.paymentButton.frame.origin.x, self.paymentButton.frame.origin.y+40,self.paymentButton.frame.size.width, 230)];
                             }
//                             else
//                             {
//                                 [self.paymentBtnTextView setFrame:CGRectMake(_ourOfficesBtn.frame.origin.x, _ourOfficesBtn.frame.origin.y+40, _ourOfficesBtn.frame.size.width, 230)];
//                             }
//                             
                             [UIView commitAnimations];
                             self.paymentBtnTextView.hidden = NO;
                             
                         }
                     }];
    isExpanded = YES;
    
}


-(void)backMe
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUserDetailsView:nil];
    [self setName:nil];
    [self setProjectName:nil];
    [self setSubBlock:nil];
    [self setAreaDetails:nil];
    [self setBgView:nil];
    [super viewDidUnload];
}
@end
