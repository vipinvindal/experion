//
//  CustomScrollViewController.h
//  Experion ipad
//
//  Created by Ranjeet on 14/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectDetails.h"
#import "AcyImage.h"

@interface CustomScrollViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSString *imageNameStr;
@property (nonatomic, retain) ProjectDetails *projectDetails;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *flexiSpace;

-(IBAction)dismissView;

@end
