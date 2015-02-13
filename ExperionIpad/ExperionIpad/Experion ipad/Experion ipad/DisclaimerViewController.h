//
//  DisclaimerViewController.h
//  Experion ipad
//
//  Created by Ranjeet on 14/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisclaimerViewController : UIViewController{
    IBOutlet UIToolbar *toolbar;
    NSMutableArray *items;
}
@property (strong, nonatomic) IBOutlet UITextView *disclaimerText;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *flexiWidth;
-(IBAction)dismissView;

@end
