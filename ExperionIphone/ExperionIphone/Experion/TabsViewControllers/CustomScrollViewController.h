//
//  CustomScrollViewController.h
//  Experion
//
//  Created by Sam on 26/11/13.
//  Copyright (c) 2013 Bets. All rights reserved.
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

-(IBAction)dismissView;

@end
