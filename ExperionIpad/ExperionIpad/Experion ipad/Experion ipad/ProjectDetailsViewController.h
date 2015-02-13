//
//  ProjectDetailsViewController.h
//  Experion ipad
//
//  Created by Ranjeet on 14/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ProjectDetails.h"

@interface ProjectDetailsViewController : UIViewController<UIScrollViewDelegate>
{
    //UIPageControl *galleryPageControl;
    CGFloat lastScale;
    
    CGFloat BTN_HEIGHT;
    CGFloat PADDING;
    CGFloat buttonWidth;
    
    CGFloat yButton;

    
    
    BOOL isExpanded;
    
    BOOL isAboutProjectOn;
    BOOL isProjectFeaturesOn;
    BOOL isLocationOn;
    BOOL isWalkthroughOn;
    int btnIndex;
    int currentPage;
}


@property (nonatomic, retain) IBOutlet UIPageControl *galleryPageControl;
@property (nonatomic, retain) IBOutlet UIScrollView *galleryScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *galleryImageView;
//@property (nonatomic, retain) NSMutableArray *galleryImageArr;

@property (nonatomic, retain) UIButton *aboutProjectBtn;
@property (nonatomic, retain) UIButton *projectFeaturesBtn;
@property (nonatomic, retain) UIButton *locationBtn;
@property (nonatomic, retain) UIButton *walkthroughBtn;
@property (nonatomic, retain) UITextView *commonTextView;
@property (nonatomic, assign) int projectID;

@property (nonatomic, retain) NSString *projectNameStr;
@property (nonatomic, retain) NSString *aboutProjectStr;
@property (nonatomic, retain) NSString *projectFeaturesStr;
@property (nonatomic, retain) NSString *tempLocationStr;
@property (nonatomic, retain) NSString *walkthroughStr;
//@property (nonatomic, retain) NSString *imageNameStr;
@property (nonatomic, retain) ProjectDetails *projectDetails;

-(IBAction) changeGalleryImage : (id) sender;

@end
