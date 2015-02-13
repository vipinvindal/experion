//
//  ImagesPreviewController.h
//  Experion ipad
//
//  Created by Ranjeet on 14/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AcyImage.h"
#import "ProjectDetails.h"

@interface ImagesPreviewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *imagesScrollView;
    UIImageView *currentImageView;
    AcyImage *acyImageView;
    //UIView *imageBGView;
    //CGFloat lastScale;
    
    int currntpage ;
    int forSetImagePage;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *flexiSpace;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) NSString *titleStr;
@property (nonatomic, retain) NSMutableArray *imagesArr;
@property (nonatomic, retain) NSString *imageDirPathStr;
@property (assign) int imageIndex;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) ProjectDetails *projectDetails;

-(IBAction)dismissView;

@end
