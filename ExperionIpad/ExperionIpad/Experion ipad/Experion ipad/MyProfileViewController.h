//
//  MyProfileViewController.h
//  Experion ipad
//
//  Created by Ranjeet on 09/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonRequest.h"
#import <QuartzCore/QuartzCore.h>
@class TPKeyboardAvoidingScrollView;

@interface MyProfileViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate, UITabBarControllerDelegate>
{
    
    
    CGPoint currentCenterScroll;
    BOOL viewCall;
    
}

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *userNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;
@property (nonatomic, retain) JsonRequest *request;

@property (nonatomic, retain) NSMutableArray *paymentDetailsArray;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

//- (IBAction)Request:(id)sender;

-(IBAction)loginBtnClicked:(id)sender;

@end
