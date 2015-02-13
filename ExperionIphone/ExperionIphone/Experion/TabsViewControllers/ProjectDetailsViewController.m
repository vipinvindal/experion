//
//  ProjectDetailsViewController.m
//  Experion
//
//  Created by Sam on 14/11/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import "ProjectDetailsViewController.h"
#import "ImagesPreviewController.h"
#import "Constants.h"
//#import "PhotoViewController.h"
#import "CustomScrollViewController.h"
#import "DatabaseManager.h"
#import "AcyImage.h"


@interface ProjectDetailsViewController ()

@end

@implementation ProjectDetailsViewController

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
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 25, 25);
    [backButton setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMe) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    
    DatabaseManager *dbManager = [DatabaseManager getSharedInstance];
    
    _projectDetails = [dbManager getProjectDetails:_projectID];
    
    [self addGalleryImageScrollView];
    
   // _galleryImageArr = [[NSMutableArray alloc]init];
    
    
    
    for (int i = 0; i<_projectDetails.galleryImageLocalPathArr.count; i++) {
        
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(320*i, -14, _galleryScrollView.frame.size.width, _galleryScrollView.frame.size.height)];
        
        view.backgroundColor = [UIColor whiteColor];
        view.tag = i+1;
        
        
        NSString *tempDisplayedImgStr;
        
        if ([_projectNameStr rangeOfString:@"Westerlies"].location != NSNotFound)
        {
            tempDisplayedImgStr = @"Westerlies";
        }
        else if ([_projectNameStr rangeOfString:@"Windchants"].location != NSNotFound)
        {
            tempDisplayedImgStr = @"Windchants";
        }
        else if ([_projectNameStr rangeOfString:@"Heartsong"].location != NSNotFound)
        {
            tempDisplayedImgStr = @"Heartsong";
        }
        else
        {
            tempDisplayedImgStr = @"placeholder-big";
        }

        
        AcyImage *acyimgeview=[[AcyImage alloc]initWithFrame:CGRectMake(5, view.frame.origin.y+40, view.frame.size.width-10, view.frame.size.height-20) :tempDisplayedImgStr];
        [acyimgeview setBackgroundColor:[UIColor clearColor]];
        acyimgeview.tag=999999;
        
        [acyimgeview loadimage:[_projectDetails.galleryImageLocalPathArr objectAtIndex:i] :[_projectDetails.galleryImageURLArr objectAtIndex:i]];
        
        [view addSubview:acyimgeview];
        [_galleryScrollView addSubview:view];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageWasTapped:)];
        
        [tapGesture setCancelsTouchesInView:NO];
        [view addGestureRecognizer:tapGesture];
        
    }
    
    //   // saving Image in Doc Directory temporarily
    //    NSString *dirPath = [self getDocumentDirPath:@"Project1"];
    //
    //    for (int i = 0; i<5; i++)
    //    {
    //        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(320*i, -14, _galleryScrollView.frame.size.width, _galleryScrollView.frame.size.height)];
    //
    //        view.backgroundColor = [UIColor whiteColor];
    //        view.tag = i+1;
    //
    //        NSString *imageNameStr = [NSString stringWithFormat:@"%@%i",_projectNameStr, i+1];
    //        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageNameStr]];
    //        imgView.frame = CGRectMake(5, view.frame.origin.y+40, view.frame.size.width-10, view.frame.size.height-20);
    //        [_galleryImageArr addObject:imgView];
    //
    //        //TODO saving Image in Doc Directory temporarily
    //
    //        UIImage *currentImg = [UIImage imageNamed:imageNameStr];
    //        NSData *pngData = UIImagePNGRepresentation(currentImg);
    //        NSString *currentImageName = [NSString stringWithFormat:@"image%i.png",i+1];
    //        NSString *imagePath = [dirPath stringByAppendingPathComponent:currentImageName];
    //        [pngData writeToFile:imagePath atomically:YES];
    //
    //        [view addSubview:imgView];
    //        [_galleryScrollView addSubview:view];
    //
    //        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageWasTapped:)];
    //
    //        [tapGesture setCancelsTouchesInView:NO];
    //        [view addGestureRecognizer:tapGesture];
    //    }
    
    _galleryScrollView.contentSize = CGSizeMake(_galleryScrollView.frame.size.width * _projectDetails.galleryImageLocalPathArr.count, _galleryScrollView.frame.size.height);
    _galleryScrollView.pagingEnabled = YES;
    
    _galleryPageControl = [[UIPageControl alloc] init];
    _galleryPageControl.currentPage = 0;
    _galleryPageControl.numberOfPages = _projectDetails.galleryImageLocalPathArr.count;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        _galleryPageControl.frame = CGRectMake(141,220,38,36);
    }
    else
    {
        _galleryPageControl.frame = CGRectMake(141,190,38,36);
    }
    _galleryPageControl.userInteractionEnabled=NO;
    [self.view addSubview:_galleryPageControl];
    [_galleryPageControl addTarget:self action:@selector(changeGalleryImage:) forControlEvents:UIControlEventValueChanged];
    _galleryPageControl.backgroundColor = [UIColor clearColor];
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (ver >= 6.0) {
        _galleryPageControl.pageIndicatorTintColor = [UIColor whiteColor];
        //[UIColor colorWithRed:16.0/255.0 green:93.0/255.0 blue:145.0/255.0 alpha:1.0];
        _galleryPageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:16.0/255.0 green:93.0/255.0 blue:145.0/255.0 alpha:1.0];
        //[UIColor whiteColor];
    }
    
    
    
    //    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    //    [_galleryScrollView addGestureRecognizer:pinchGesture];
    //    lastScale = 0.1;
    
    [self setAllBtns];
}

#pragma mark - Custom Tabs Methods

-(void)setAllBtns
{
    btnIndex = 0;
    
    BTN_HEIGHT = 30;
    // PADDING = 5;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        PADDING = 10;
    }
    else
    {
        PADDING = 5;
    }
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    _aboutProjectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSString *projectNameWithSpaceStr;
//    if (!_projectNameStr.length && !_projectNameStr) {
//        projectNameWithSpaceStr = [NSString stringWithFormat:ABOUT_PROJECT_TITLE];
//    }
//    else
//    {
//        projectNameWithSpaceStr = [NSString stringWithFormat:@"   %@",_projectNameStr];
//    }
    
    projectNameWithSpaceStr = [NSString stringWithFormat:ABOUT_PROJECT_TITLE];
    [_aboutProjectBtn setTitle:projectNameWithSpaceStr forState:UIControlStateNormal];
    _aboutProjectBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_aboutProjectBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_aboutProjectBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_aboutProjectBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _aboutProjectBtn.frame = CGRectMake(10, 280, 300, BTN_HEIGHT);    }
    else
    {
        _aboutProjectBtn.frame = CGRectMake(10, 225, 300, BTN_HEIGHT);
    }
    
    [_aboutProjectBtn addTarget:self action:@selector(aboutProjectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _aboutProjectBtn.adjustsImageWhenHighlighted = YES;
    _aboutProjectBtn.tag = 1;
    [self.view addSubview:_aboutProjectBtn];
    
    _projectFeaturesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_projectFeaturesBtn setTitle:PROJECT_FEATURES_TITLE forState:UIControlStateNormal];
    _projectFeaturesBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_projectFeaturesBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_projectFeaturesBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_projectFeaturesBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _projectFeaturesBtn.frame = CGRectMake(10, 280+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT);
    }
    else
    {
        _projectFeaturesBtn.frame = CGRectMake(10, 225+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT);
    }
    
    [_projectFeaturesBtn addTarget:self action:@selector(projectFeaturesBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _projectFeaturesBtn.adjustsImageWhenHighlighted = YES;
    _projectFeaturesBtn.tag = 2;
    [self.view addSubview:_projectFeaturesBtn];
    
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locationBtn setTitle:LOCATION_TITLE forState:UIControlStateNormal];
    _locationBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_locationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_locationBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_locationBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _locationBtn.frame = CGRectMake(10, 280+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
    }
    else
    {
        _locationBtn.frame = CGRectMake(10, 225+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
    }
    
    [_locationBtn addTarget:self action:@selector(locationBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _locationBtn.adjustsImageWhenHighlighted = YES;
    _locationBtn.tag = 3;
    [self.view addSubview:_locationBtn];
    
    
    _walkthroughBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_walkthroughBtn setTitle:WALKTHROUGH_TITLE forState:UIControlStateNormal];
    _walkthroughBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_walkthroughBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_walkthroughBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_walkthroughBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _walkthroughBtn.frame = CGRectMake(10, 280+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
    }
    else
    {
        _walkthroughBtn.frame = CGRectMake(10, 225+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
    }
    
    [_walkthroughBtn addTarget:self action:@selector(walkthroughBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _walkthroughBtn.adjustsImageWhenHighlighted = YES;
    _walkthroughBtn.tag = 3;
    [self.view addSubview:_walkthroughBtn];
    
    
    _commonTextView = [[UITextView alloc]init];
    //_contactBtnTextView.frame = CGRectMake(15, 340, 280, 200);
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _commonTextView.frame = CGRectMake(10, 80+BTN_HEIGHT, 300, 0);
    }
    else
    {
        _commonTextView.frame = CGRectMake(10, 40+BTN_HEIGHT, 300, 0);
    }
    _commonTextView.userInteractionEnabled = YES;
    _commonTextView.scrollEnabled = YES;
    _commonTextView.editable = NO;
    //_commonTextView.backgroundColor = [UIColor brownColor];
    [_commonTextView setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:0.95f]];
    _commonTextView.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
    [self.view addSubview:_commonTextView];
    _commonTextView.hidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self resetView];
}

-(void)resetView
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _aboutProjectBtn.frame = CGRectMake(10, 280, 300, BTN_HEIGHT);
        _projectFeaturesBtn.frame = CGRectMake(10, 280+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT);
        _locationBtn.frame = CGRectMake(10, 280+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
        _walkthroughBtn.frame = CGRectMake(10, 280+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
        _commonTextView.frame = CGRectMake(10, 80+BTN_HEIGHT, 300, 0);
    }
    else
    {
        _aboutProjectBtn.frame = CGRectMake(10, 225, 300, BTN_HEIGHT);
        _projectFeaturesBtn.frame = CGRectMake(10, 225+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT);
        _locationBtn.frame = CGRectMake(10, 225+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
        _walkthroughBtn.frame = CGRectMake(10, 225+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
        _commonTextView.frame = CGRectMake(10, 40+BTN_HEIGHT, 300, 0);
    }
    isExpanded = NO;
    isProjectFeaturesOn = NO;
    isAboutProjectOn = NO;
    isLocationOn = NO;
    isWalkthroughOn = NO;
    //[_partnersView.view setHidden:YES];
}

-(void)aboutProjectBtnClicked:(id)sender
{
    btnIndex = 1;
    
    
    [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
    _commonTextView.text = _projectDetails.longDescription;
    
    if (!isAboutProjectOn) {
        
        isAboutProjectOn = YES;
        isProjectFeaturesOn = NO;
        isLocationOn = NO;
        isWalkthroughOn = NO;
        [self setButtonToInitialFrame];
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.5];
        //isExpanded = YES;
    }
    else
    {
        //isExpanded = NO;
        isAboutProjectOn = NO;
        [self setButtonToInitialFrame];
        
    }
}

-(void)projectFeaturesBtnClicked:(id)sender
{
    btnIndex = 2;
    
    [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
    _commonTextView.text = _projectDetails.projectFeatures;
    
    
    if (!isProjectFeaturesOn)
    {
        isProjectFeaturesOn = YES;
        isAboutProjectOn = NO;
        isLocationOn = NO;
        isWalkthroughOn = NO;
        [self setButtonToInitialFrame];
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.5];
        
    }
    else
    {
        isProjectFeaturesOn = NO;
        [self setButtonToInitialFrame];
    }
}

-(void)locationBtnClicked : (id) sender
{
    btnIndex = 3;
    
    CustomScrollViewController *customPreview = [[CustomScrollViewController alloc]init];
    
    //SET LOCATION
    
    customPreview.imageNameStr = [NSString stringWithFormat:@"%@-location",_projectNameStr];
    
    customPreview.projectDetails = _projectDetails;
    
    [self presentModalViewController:customPreview animated:YES];
    //    [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
    //
    //    _commonTextView.text = _tempLocationStr;
    //
    //    if (!isLocationOn) {
    //        isLocationOn = YES;
    //        isAboutProjectOn = NO;
    //        isProjectFeaturesOn = NO;
    //        isWalkthroughOn = NO;
    //        [self setButtonToInitialFrame];
    //        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.5];
    //    }
    //    else
    //    {
    //        isLocationOn = NO;
    //        [self setButtonToInitialFrame];
    //    }
    
}

#pragma mark -

-(void)walkthroughBtnClicked:(id)sender
{
    btnIndex = 4;
    
    [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    _commonTextView.text = _projectDetails.walkthrough;
    _commonTextView.dataDetectorTypes =UIDataDetectorTypeLink;
    
    //  //  _partnersView = [[CustomPartnersView alloc]init];
    //   // _partnersView = (CustomPartnersView*)[self viewFromNibName:@"CustomPartnersView"];
    //    //_partnersView.center = self.view.center;
    //    //_partnersView.view.frame = CGRectMake(10, 200, 300, 400);
    //
    //    //[self.view addSubview:_partnersView.view];
    //    [_partnersView.view setHidden:NO];
    
    
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(130, _commonTextView.contentSize.height, 60, 60)];
    //    view.backgroundColor = [UIColor greenColor]; // for testing
    //   // [view addSubView:_commonTextView];
    //    [view addSubview:_commonTextView];
    
    
    //    if (btnIndex == 4) {
    //        UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 155, 120, 27)];
    //        [imgView1 setImage:[UIImage imageNamed:@"arcop"]];
    //        // [view addSubview:imgView];
    //        [_commonTextView addSubview:imgView1];
    //
    //        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 220, 238, 66)];
    //        [imgView2 setImage:[UIImage imageNamed:@"siteConcepts"]];
    //        // [view addSubview:imgView];
    //        [_commonTextView addSubview:imgView2];
    //    }
    
    
    if (!isWalkthroughOn) {
        isWalkthroughOn = YES;
        isAboutProjectOn = NO;
        isProjectFeaturesOn = NO;
        isLocationOn = NO;
        [self setButtonToInitialFrame];
        [self performSelector:@selector(showHideContent) withObject:nil afterDelay:0.5];
    }
    else
    {
        isWalkthroughOn = NO;
        [self setButtonToInitialFrame];
    }
    
}

-(UIView *)viewFromNibName:(NSString *)nibName
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
}

-(void)showHideContent
{
    // _commonTextView.frame = CGRectMake(10, 65+(btnIndex*30), 300, 0);
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
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 80, 300, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 40, 300, BTN_HEIGHT)];
                             }
                         }
                         else if (btnIndex == 2)
                         {
                             if ([[UIScreen mainScreen] bounds].size.height == 568)
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 80, 300, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 80+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 40, 300, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 40+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT)];
                             }
                         }
                         else if (btnIndex == 3)
                         {
                             if ([[UIScreen mainScreen] bounds].size.height == 568)
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 80, 300, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 80+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT)];
                                 [_locationBtn setFrame:CGRectMake(10, 80+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 40, 300, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 40+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT)];
                                 [_locationBtn setFrame:CGRectMake(10, 40+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT)];
                             }
                         }
                         else
                         {
                             if ([[UIScreen mainScreen] bounds].size.height == 568)
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 80, 300, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 80+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT)];
                                 [_locationBtn setFrame:CGRectMake(10, 80+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT)];
                                 [_walkthroughBtn setFrame:CGRectMake(10, 80+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 40, 300, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 40+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT)];
                                 [_locationBtn setFrame:CGRectMake(10, 40+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT)];
                                 [_walkthroughBtn setFrame:CGRectMake(10, 40+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT)];
                             }
                         }
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             // Do your method here after your animation.
                             [UIView beginAnimations:@"advancedAnimations" context:nil];
                             [UIView setAnimationDuration:0.5];
                             
                             float textViewHeight = 0;
                             if ([[UIScreen mainScreen] bounds].size.height == 568)
                             {
                                 textViewHeight = 200.0;
                             }
                             else
                             {
                                 textViewHeight = 180.0;
                             }
                             
                             if (btnIndex == 1) {
                                 [_commonTextView setFrame:CGRectMake(_aboutProjectBtn.frame.origin.x, _aboutProjectBtn.frame.origin.y+BTN_HEIGHT, _aboutProjectBtn.frame.size.width, textViewHeight)];
                             }
                             else if (btnIndex == 2)
                             {
                                 [_commonTextView setFrame:CGRectMake(_projectFeaturesBtn.frame.origin.x, _projectFeaturesBtn.frame.origin.y+BTN_HEIGHT, _projectFeaturesBtn.frame.size.width, textViewHeight)];
                             }
                             else if (btnIndex == 3)
                             {
                                 [_commonTextView setFrame:CGRectMake(_locationBtn.frame.origin.x, _locationBtn.frame.origin.y+BTN_HEIGHT, _locationBtn.frame.size.width, textViewHeight)];
                             }
                             else
                             {
                                 [_commonTextView setFrame:CGRectMake(_walkthroughBtn.frame.origin.x, _walkthroughBtn.frame.origin.y+BTN_HEIGHT, _walkthroughBtn.frame.size.width, textViewHeight)];
                             }
                             
                             [UIView commitAnimations];
                             _commonTextView.hidden = NO;
                             
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

-(void) setButtonToInitialFrame
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         if ([[UIScreen mainScreen] bounds].size.height == 568)
                         {
                             _commonTextView.frame = CGRectMake(10, 70+(btnIndex*(BTN_HEIGHT+PADDING)), 300, 0);
                         }
                         else
                         {
                             _commonTextView.frame = CGRectMake(10, 35+(btnIndex*(BTN_HEIGHT+PADDING)), 300, 0);
                         }
                         
                         //                          if ([[UIScreen mainScreen] bounds].size.height == 568)
                         //                          {
                         //                              _contactBtnTextView.frame = CGRectMake(10, 100, 300, 0);
                         //                          }
                         //                         else
                         //                         {
                         //                         _contactBtnTextView.frame = CGRectMake(10, 100, 300, 0);
                         //                         }
                         //  [_contactBtnTextView setFrame:CGRectMake(_contactBtn.frame.origin.x, _contactBtn.frame.origin.y+40, _contactBtn.frame.size.width, 0)];
                         _commonTextView.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             // Do your method here after your animation.
                             [UIView beginAnimations:@"advancedAnimations" context:nil];
                             [UIView setAnimationDuration:0.3];
                             if ([[UIScreen mainScreen] bounds].size.height == 568)
                             {
                                 _aboutProjectBtn.frame = CGRectMake(10, 280, 300, BTN_HEIGHT);
                                 _projectFeaturesBtn.frame = CGRectMake(10, 280+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT);
                                 _locationBtn.frame = CGRectMake(10, 280+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
                                 _walkthroughBtn.frame = CGRectMake(10, 280+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
                                 
                             }
                             else
                             {
                                 _aboutProjectBtn.frame = CGRectMake(10, 225, 300, BTN_HEIGHT);
                                 _projectFeaturesBtn.frame = CGRectMake(10, 225+BTN_HEIGHT+PADDING, 300, BTN_HEIGHT);
                                 _locationBtn.frame = CGRectMake(10, 225+2*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
                                 _walkthroughBtn.frame = CGRectMake(10, 225+3*(BTN_HEIGHT+PADDING), 300, BTN_HEIGHT);
                                 
                             }
                             [UIView commitAnimations];
                         }
                     }];
    isExpanded = NO;
    
}


#pragma mark -

- (void)imageWasTapped:(UITapGestureRecognizer *) sender
{
    UIView *view = sender.view; //cast pointer to the derived class if needed
   // NSLog(@"%d", view.tag);
    
    ImagesPreviewController *imagesPreviewVC = [[ImagesPreviewController alloc]init];
    imagesPreviewVC.titleStr = [NSString stringWithFormat:@"%@", _projectNameStr];
    imagesPreviewVC.imageIndex = view.tag;
    
    imagesPreviewVC.projectDetails = _projectDetails;
    
   // imagesPreviewVC.imageDirPathStr = [self getDocumentDirPath:@"Project1"];
    [self presentModalViewController:imagesPreviewVC animated:YES];
}

-(NSString*)getDocumentDirPath : (NSString*)projectName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *projectPathWithName = [NSString stringWithFormat:@"/Project/%@",projectName];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:projectPathWithName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    BOOL isDirExists = [fileManager fileExistsAtPath:myPathDocs isDirectory:&isDir];
    if (!isDirExists) [fileManager createDirectoryAtPath:myPathDocs withIntermediateDirectories:YES attributes:nil error:nil];
    
    return myPathDocs;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _galleryScrollView.frame.size.width;
    int page = floor((_galleryScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _galleryPageControl.currentPage = page;
	
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	//pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	//pageControlBeingUsed = NO;
}

-(void)backMe
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Page Control Methods

-(void)addGalleryImageScrollView
{
    _galleryScrollView = [[UIScrollView alloc]init];
    _galleryScrollView.delegate = self;
    _galleryScrollView.backgroundColor = [UIColor clearColor];
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _galleryScrollView.frame = CGRectMake(0, -24, 320, 280);
    }
    else
    {
        _galleryScrollView.frame = CGRectMake(0, -24, 320, 250);
    }
    _galleryScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_galleryScrollView];
}

-(IBAction) changeGalleryImage : (id) sender
{
    [_galleryScrollView scrollRectToVisible:CGRectMake(_galleryScrollView.frame.size.width * _galleryPageControl.currentPage, _galleryScrollView.frame.origin.x, _galleryScrollView.frame.size.width, _galleryScrollView.frame.size.height) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
