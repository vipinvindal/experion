//
//  ImagesPreviewController.h
//  Experion
//
//  Created by Sam on 26/11/13.
//  Copyright (c) 2013 Bets. All rights reserved.
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
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) NSString *titleStr;
@property (nonatomic, retain) NSMutableArray *imagesArr;
@property (nonatomic, retain) NSString *imageDirPathStr;
@property (assign) int imageIndex;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) ProjectDetails *projectDetails;

-(IBAction)dismissView;

@end
