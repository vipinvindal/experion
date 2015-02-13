//
//  MyProfileViewController.h
//  Experion
//
//  Created by Sam on 14/11/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonRequest.h"

@interface MyProfileViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate, UITabBarControllerDelegate>
{
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UITextField *userNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;
@property (nonatomic, retain) JsonRequest *request;

@property (nonatomic, retain) NSMutableArray *paymentDetailsArray;

//- (IBAction)Request:(id)sender;

-(IBAction)loginBtnClicked:(id)sender;

@end
