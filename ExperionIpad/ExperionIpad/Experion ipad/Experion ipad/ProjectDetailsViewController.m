//
//  ProjectDetailsViewController.m
//  Experion
//
//  Created by Ranjeet on 14/04/14.
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
    
    buttonWidth=768-20;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        yButton=690;
        
        
    }
    else{
        yButton=630;
    }
    
    

    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 35, 25);
    [backButton setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMe) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    
    DatabaseManager *dbManager = [DatabaseManager getSharedInstance];
    
    _projectDetails = [dbManager getProjectDetails:_projectID];
    
    [self addGalleryImageScrollView];
    
    // _galleryImageArr = [[NSMutableArray alloc]init];
    
    
    
    for (int i = 0; i<_projectDetails.galleryImageLocalPathArr.count; i++) {
        
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(768*i, -14, _galleryScrollView.frame.size.width, _galleryScrollView.frame.size.height)];
        
        view.backgroundColor = [UIColor clearColor];
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
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))  {
        _galleryPageControl.frame = CGRectMake(0,589,768,36);
    }
    else
    {
        _galleryPageControl.frame = CGRectMake(0,535,768,36);
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
      currentPage=_galleryPageControl.currentPage;
    
    
    //    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    //    [_galleryScrollView addGestureRecognizer:pinchGesture];
    //    lastScale = 0.1;
    
    [self setAllBtns];
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        [self potraitNavigation];
        
    }
    else
    {
       
        [self orientationChange];
         [self landScabeNavigation];
    }

}

-(void)orientationChange
{
   
    float changeY=220.0;
    buttonWidth=1024-20;

    
    _aboutProjectBtn.frame =CGRectMake(_aboutProjectBtn.frame.origin.x, _aboutProjectBtn.frame.origin.y-changeY,buttonWidth, _aboutProjectBtn.frame.size.height);
    _projectFeaturesBtn.frame =CGRectMake(_projectFeaturesBtn.frame.origin.x, _projectFeaturesBtn.frame.origin.y-changeY,buttonWidth, _projectFeaturesBtn.frame.size.height);
    _walkthroughBtn.frame =CGRectMake(_walkthroughBtn.frame.origin.x, _walkthroughBtn.frame.origin.y-changeY,buttonWidth, _walkthroughBtn.frame.size.height);
    
    _locationBtn.frame =CGRectMake(_locationBtn.frame.origin.x, _locationBtn.frame.origin.y-changeY,buttonWidth, _locationBtn.frame.size.height);
    
    _commonTextView.frame =CGRectMake(_commonTextView.frame.origin.x, _commonTextView.frame.origin.y-changeY,buttonWidth, _commonTextView.frame.size.height);
   
    
    
}

#pragma mark - Custom Tabs Methods

-(void)setAllBtns
{
    btnIndex = 0;
    
    BTN_HEIGHT = 50;
    // PADDING = 5;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        PADDING = 10;
    }
    else
    {
        PADDING =10;
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
    _aboutProjectBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_aboutProjectBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_aboutProjectBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_aboutProjectBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _aboutProjectBtn.frame = CGRectMake(10, yButton, buttonWidth, BTN_HEIGHT);
    }
    else
    {
        _aboutProjectBtn.frame = CGRectMake(10, yButton, buttonWidth, BTN_HEIGHT);
    }
    
    [_aboutProjectBtn addTarget:self action:@selector(aboutProjectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _aboutProjectBtn.adjustsImageWhenHighlighted = YES;
    _aboutProjectBtn.tag = 1;
    [self.view addSubview:_aboutProjectBtn];
    
    _projectFeaturesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_projectFeaturesBtn setTitle:PROJECT_FEATURES_TITLE forState:UIControlStateNormal];
    _projectFeaturesBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_projectFeaturesBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_projectFeaturesBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_projectFeaturesBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _projectFeaturesBtn.frame = CGRectMake(10, yButton+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT);
    }
    else
    {
        _projectFeaturesBtn.frame = CGRectMake(10, yButton+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT);
    }
    
    [_projectFeaturesBtn addTarget:self action:@selector(projectFeaturesBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _projectFeaturesBtn.adjustsImageWhenHighlighted = YES;
    _projectFeaturesBtn.tag = 2;
    [self.view addSubview:_projectFeaturesBtn];
    
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locationBtn setTitle:LOCATION_TITLE forState:UIControlStateNormal];
    _locationBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_locationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_locationBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_locationBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _locationBtn.frame = CGRectMake(10, yButton+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
    }
    else
    {
        _locationBtn.frame = CGRectMake(10, yButton+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
    }
    
    [_locationBtn addTarget:self action:@selector(locationBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _locationBtn.adjustsImageWhenHighlighted = YES;
    _locationBtn.tag = 3;
    [self.view addSubview:_locationBtn];
    
    
    _walkthroughBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_walkthroughBtn setTitle:WALKTHROUGH_TITLE forState:UIControlStateNormal];
    _walkthroughBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_walkthroughBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_walkthroughBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_walkthroughBtn setBackgroundImage:[UIImage imageNamed:@"Button-bar-Down"] forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _walkthroughBtn.frame = CGRectMake(10, yButton+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
    }
    else
    {
        _walkthroughBtn.frame = CGRectMake(10, yButton+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
    }
    
    [_walkthroughBtn addTarget:self action:@selector(walkthroughBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _walkthroughBtn.adjustsImageWhenHighlighted = YES;
    _walkthroughBtn.tag = 3;
    [self.view addSubview:_walkthroughBtn];
    
    
    _commonTextView = [[UITextView alloc]init];
    //_contactBtnTextView.frame = CGRectMake(15, 340, 280, 200);
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        _commonTextView.frame = CGRectMake(10, 455+BTN_HEIGHT, buttonWidth,0);
    }
    else
    {
        _commonTextView.frame = CGRectMake(10,359+BTN_HEIGHT, buttonWidth,0);
    }
    _commonTextView.font=[UIFont systemFontOfSize:16.0];
     _commonTextView.text=nil;
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
-(void)viewWillAppear:(BOOL)animated{
    
     currentPage=_galleryPageControl.currentPage;
    
     if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
         if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
         {
             _galleryScrollView.frame = CGRectMake(_galleryScrollView.frame.origin.x,_galleryScrollView.frame.origin.y, 768, 600);
         }
         else
         {
             _galleryScrollView.frame = CGRectMake(_galleryScrollView.frame.origin.x,_galleryScrollView.frame.origin.y, 768,600);
         }
         
         [self potraitViewOrientation];
     }
     else{
         
         if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
         {
             _galleryScrollView.frame = CGRectMake(_galleryScrollView.frame.origin.x,_galleryScrollView.frame.origin.y, 1024, 440);
         }
         else
         {
             _galleryScrollView.frame = CGRectMake(_galleryScrollView.frame.origin.x,_galleryScrollView.frame.origin.y, 1024,440);
         }
         
         [self landscapeOrientation];

     }
}

-(void)resetView
{
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
        float changeY=0.0;
        buttonWidth=1024-20;
        
        
        _aboutProjectBtn.frame =CGRectMake(_aboutProjectBtn.frame.origin.x,yButton-changeY,buttonWidth, _aboutProjectBtn.frame.size.height);
        _projectFeaturesBtn.frame = CGRectMake(10, yButton-changeY+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT);
        _walkthroughBtn.frame = CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
        _locationBtn.frame = CGRectMake(10, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
        
        _commonTextView.frame = CGRectMake(10,359-changeY+BTN_HEIGHT, buttonWidth,0);
        [self potraitNavigation];
        

        
    }else{
        float changeY=220.0;
        buttonWidth=1024-20;
        
        
        _aboutProjectBtn.frame =CGRectMake(_aboutProjectBtn.frame.origin.x,yButton-changeY,buttonWidth, _aboutProjectBtn.frame.size.height);
        _projectFeaturesBtn.frame = CGRectMake(10, yButton-changeY+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT);
        _walkthroughBtn.frame = CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
        _locationBtn.frame = CGRectMake(10, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
        
        _commonTextView.frame = CGRectMake(10,359-changeY+BTN_HEIGHT, buttonWidth,0);
        
        [self landScabeNavigation];

        
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
   // [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
    //_commonTextView.text = _projectDetails.longDescription;
    

    
    
}

-(void)projectFeaturesBtnClicked:(id)sender
{
    btnIndex = 2;
    
    
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
   
    //_commonTextView.text = _projectDetails.projectFeatures;

   
}

-(void)locationBtnClicked : (id) sender
{
    
    btnIndex = 3;
    
    CustomScrollViewController *customPreview = [[CustomScrollViewController alloc]init];
    
    //SET LOCATION
    
    customPreview.imageNameStr = [NSString stringWithFormat:@"%@-location",_projectNameStr];
    
    customPreview.projectDetails = _projectDetails;
    
    [self presentViewController:customPreview animated:YES completion:nil];
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
       //[_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
    
   
    
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
    
    //_commonTextView.text = _projectDetails.walkthrough;
   
    

    
}

-(UIView *)viewFromNibName:(NSString *)nibName
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
}

-(void)showHideContent
{
    // _commonTextView.frame = CGRectMake(10, 65+(btnIndex*30), 300, 0);
   
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         // Do your animations here.
                         if (btnIndex == 1)
                         {
                             //contact button
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 360, buttonWidth, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 300, buttonWidth, BTN_HEIGHT)];
                             }
                         }
                         else if (btnIndex == 2)
                         {
                            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 360, buttonWidth, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 360+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 300, buttonWidth, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 300+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                             }
                         }
                         else if (btnIndex == 3)
                         {
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 360, buttonWidth, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 360+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                                 [_locationBtn setFrame:CGRectMake(10, 360+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 300, buttonWidth, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 300+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                                 [_locationBtn setFrame:CGRectMake(10, 300+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                             }
                         }
                         else
                         {
                            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 360, buttonWidth, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 360+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                                 [_locationBtn setFrame:CGRectMake(10, 360+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                                 [_walkthroughBtn setFrame:CGRectMake(10, 360+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                             }
                             else
                             {
                                 [_aboutProjectBtn setFrame:CGRectMake(10, 300, buttonWidth, BTN_HEIGHT)];
                                 [_projectFeaturesBtn setFrame:CGRectMake(10, 300+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                                 [_locationBtn setFrame:CGRectMake(10, 300+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                                 [_walkthroughBtn setFrame:CGRectMake(10, 300+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                             }
                         }
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             // Do your method here after your animation.
                             [UIView beginAnimations:@"advancedAnimations" context:nil];
                             [UIView setAnimationDuration:0.5];
                             
                             float textViewHeight = 0;
                            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 textViewHeight =330.0;
                             }
                             else
                             {
                                 textViewHeight =330.0;
                             }
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_commonTextView setSelectable:NO];
 
                             }
                            
                             //_commonTextView.text=nil;
                             //_commonTextView.scrollEnabled=NO;
                             
                             if (btnIndex == 1) {
                                 
                                 
                                 [_commonTextView setFrame:CGRectMake(_aboutProjectBtn.frame.origin.x, _aboutProjectBtn.frame.origin.y+BTN_HEIGHT, _aboutProjectBtn.frame.size.width, textViewHeight)];
                                   _commonTextView.text = _projectDetails.longDescription;
                                 _commonTextView.editable = NO;
                                 //_commonTextView.dataDetectorTypes =UIDataDetectorTypeLink;
                                 _commonTextView.dataDetectorTypes =UIDataDetectorTypeNone;
                                 //_commonTextView.scrollEnabled=YES;
                                 
                             }
                             else if (btnIndex == 2)
                             {
                                 
                                 [_commonTextView setFrame:CGRectMake(_projectFeaturesBtn.frame.origin.x, _projectFeaturesBtn.frame.origin.y+BTN_HEIGHT, _projectFeaturesBtn.frame.size.width, textViewHeight)];
                                 
                                  _commonTextView.text = _projectDetails.projectFeatures;
                                 _commonTextView.editable = NO;
                                 //_commonTextView.dataDetectorTypes =UIDataDetectorTypeLink;
                                _commonTextView.dataDetectorTypes =UIDataDetectorTypeNone;
                                 //_commonTextView.scrollEnabled=YES;
                             
                             }
                             else if (btnIndex == 3)
                             {
                                 
                                 [_commonTextView setFrame:CGRectMake(_locationBtn.frame.origin.x, _locationBtn.frame.origin.y+BTN_HEIGHT, _locationBtn.frame.size.width, textViewHeight)];
                               
                             }
                             else
                             {
                                
                                 [_commonTextView setFrame:CGRectMake(_walkthroughBtn.frame.origin.x, _walkthroughBtn.frame.origin.y+BTN_HEIGHT, _walkthroughBtn.frame.size.width, textViewHeight)];
                                  _commonTextView.text = _projectDetails.walkthrough;
                                 _commonTextView.editable = NO;
                                  _commonTextView.dataDetectorTypes =UIDataDetectorTypeNone;
                                  _commonTextView.dataDetectorTypes =UIDataDetectorTypeLink;
                                 //_commonTextView.scrollEnabled=YES;
                             }
                             
                             [UIView commitAnimations];
                             _commonTextView.hidden = NO;
                             
                             //_commonTextView.text = _projectDetails.walkthrough;
                             [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 [_commonTextView setSelectable:YES];
                             }
                             
                             [_commonTextView setNeedsDisplay];

                             
                         }
                     }];
    }
    else{
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             // Do your animations here.
                             if (btnIndex == 1)
                             {
                                 //contact button
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     [_aboutProjectBtn setFrame:CGRectMake(10, 260, buttonWidth, BTN_HEIGHT)];
                                 }
                                 else
                                 {
                                     [_aboutProjectBtn setFrame:CGRectMake(10, 200, buttonWidth, BTN_HEIGHT)];
                                 }
                             }
                             else if (btnIndex == 2)
                             {
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     [_aboutProjectBtn setFrame:CGRectMake(10, 260, buttonWidth, BTN_HEIGHT)];
                                     [_projectFeaturesBtn setFrame:CGRectMake(10, 260+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                                 }
                                 else
                                 {
                                     [_aboutProjectBtn setFrame:CGRectMake(10, 200, buttonWidth, BTN_HEIGHT)];
                                     [_projectFeaturesBtn setFrame:CGRectMake(10, 200+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                                 }
                             }
                             else if (btnIndex == 3)
                             {
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     [_aboutProjectBtn setFrame:CGRectMake(10, 260, buttonWidth, BTN_HEIGHT)];
                                     [_projectFeaturesBtn setFrame:CGRectMake(10, 260+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                                     [_locationBtn setFrame:CGRectMake(10, 260+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                                 }
                                 else
                                 {
                                     [_aboutProjectBtn setFrame:CGRectMake(10, 200, buttonWidth, BTN_HEIGHT)];
                                     [_projectFeaturesBtn setFrame:CGRectMake(10, 200+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                                     [_locationBtn setFrame:CGRectMake(10, 200+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                                 }
                             }
                             else
                             {
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     [_aboutProjectBtn setFrame:CGRectMake(10, 260, buttonWidth, BTN_HEIGHT)];
                                     [_projectFeaturesBtn setFrame:CGRectMake(10, 260+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                                     [_locationBtn setFrame:CGRectMake(10, 260+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                                     [_walkthroughBtn setFrame:CGRectMake(10, 260+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                                 }
                                 else
                                 {
                                     [_aboutProjectBtn setFrame:CGRectMake(10, 200, buttonWidth, BTN_HEIGHT)];
                                     [_projectFeaturesBtn setFrame:CGRectMake(10, 200+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                                     [_locationBtn setFrame:CGRectMake(10, 200+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                                     [_walkthroughBtn setFrame:CGRectMake(10, 200+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                                 }
                             }
                         }
                         completion:^(BOOL finished){
                             if (finished) {
                                 // Do your method here after your animation.
                                 [UIView beginAnimations:@"advancedAnimations" context:nil];
                                 [UIView setAnimationDuration:0.5];
                                 
                                 float textViewHeight = 0;
                                 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                 {
                                     textViewHeight =200.0;
                                 }
                                 else
                                 {
                                     textViewHeight =200.0;
                                 }
                                 //_commonTextView.text=nil;
                                 //_commonTextView.scrollEnabled=NO;
                                 
                                 
                                 if (btnIndex == 1) {
                                     
                                     [_commonTextView setFrame:CGRectMake(_aboutProjectBtn.frame.origin.x, _aboutProjectBtn.frame.origin.y+BTN_HEIGHT, _aboutProjectBtn.frame.size.width, textViewHeight)];
                                     _commonTextView.text = _projectDetails.longDescription;
                                     _commonTextView.editable = NO;
                                     _commonTextView.dataDetectorTypes =UIDataDetectorTypeNone;
                                     //_commonTextView.scrollEnabled=YES;
                                     
                                 }
                                 else if (btnIndex == 2)
                                 {
                                     [_commonTextView setFrame:CGRectMake(_projectFeaturesBtn.frame.origin.x, _projectFeaturesBtn.frame.origin.y+BTN_HEIGHT, _projectFeaturesBtn.frame.size.width, textViewHeight)];
                                     
                                     _commonTextView.text = _projectDetails.projectFeatures;
                                     _commonTextView.editable = NO;
                                     _commonTextView.dataDetectorTypes =UIDataDetectorTypeNone;
                                     //_commonTextView.scrollEnabled=YES;
                                     
                                 }
                                 else if (btnIndex == 3)
                                 {
                                     
                                     [_commonTextView setFrame:CGRectMake(_locationBtn.frame.origin.x, _locationBtn.frame.origin.y+BTN_HEIGHT, _locationBtn.frame.size.width, textViewHeight)];
                                     
                                 }
                                 else
                                 {
                                     
                                     [_commonTextView setFrame:CGRectMake(_walkthroughBtn.frame.origin.x, _walkthroughBtn.frame.origin.y+BTN_HEIGHT, _walkthroughBtn.frame.size.width, textViewHeight)];
                                     _commonTextView.text = _projectDetails.walkthrough;
                                     _commonTextView.editable = NO;
                                     _commonTextView.dataDetectorTypes =UIDataDetectorTypeLink;
                                     //_commonTextView.scrollEnabled=YES;
                                 }
                                 
                                 [UIView commitAnimations];
                                 _commonTextView.hidden = NO;
                                 
                                 //_commonTextView.text = _projectDetails.walkthrough;
                                 //[_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
                                 [_commonTextView setNeedsDisplay];
                                 
                                 
                             }
                         }];
    }
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
    [_commonTextView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    //_commonTextView.text=nil;
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                         {
                             _commonTextView.frame = CGRectMake(10,355+(btnIndex*(BTN_HEIGHT+PADDING-5)), buttonWidth, 0);
                         }
                         else
                         {
                             _commonTextView.frame = CGRectMake(10, 295+(btnIndex*(BTN_HEIGHT+PADDING-5)), buttonWidth, 0);
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
                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                             {
                                 _aboutProjectBtn.frame = CGRectMake(10, yButton, buttonWidth, BTN_HEIGHT);
                                 _projectFeaturesBtn.frame = CGRectMake(10, yButton+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT);
                                 _locationBtn.frame = CGRectMake(10, yButton+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
                                 _walkthroughBtn.frame = CGRectMake(10, yButton+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
                                 
                             }
                             else
                             {
                                 _aboutProjectBtn.frame = CGRectMake(10, yButton, buttonWidth, BTN_HEIGHT);
                                 _projectFeaturesBtn.frame = CGRectMake(10, yButton+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT);
                                 _locationBtn.frame = CGRectMake(10, yButton+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
                                 _walkthroughBtn.frame = CGRectMake(10, yButton+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
                                 
                             }
                             [UIView commitAnimations];
                         }
                     }];
     }
     else{
         [UIView animateWithDuration:0.3f
                               delay:0.0f
                             options:UIViewAnimationOptionTransitionNone
                          animations:^{
                              if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                              {
                                  _commonTextView.frame = CGRectMake(10,255+(btnIndex*(BTN_HEIGHT+PADDING-5)), buttonWidth, 0);
                              }
                              else
                              {
                                  _commonTextView.frame = CGRectMake(10, 195+(btnIndex*(BTN_HEIGHT+PADDING-5)), buttonWidth, 0);
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
                                  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
                                  {
                                      float changeY=220.0;
                                      _aboutProjectBtn.frame = CGRectMake(10, yButton-changeY, buttonWidth, BTN_HEIGHT);
                                      _projectFeaturesBtn.frame = CGRectMake(10, yButton-changeY+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT);
                                      _locationBtn.frame = CGRectMake(10, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
                                      _walkthroughBtn.frame = CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
                                      
                                  }
                                  else
                                  {
                                       float changeY=220.0;
                                      _aboutProjectBtn.frame = CGRectMake(10, yButton-changeY, buttonWidth, BTN_HEIGHT);
                                      _projectFeaturesBtn.frame = CGRectMake(10, yButton-changeY+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT);
                                      _locationBtn.frame = CGRectMake(10, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
                                      _walkthroughBtn.frame = CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
                                      
                                  }
                                  [UIView commitAnimations];
                              }
                          }];
     }
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
     [self presentViewController:imagesPreviewVC animated:YES completion:nil];
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
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        _galleryScrollView.frame = CGRectMake(0,30, 768, 610);
    }
    else
    {
        _galleryScrollView.frame = CGRectMake(0, -24, 768,610);
    }
    _galleryScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_galleryScrollView];
}

-(IBAction) changeGalleryImage : (id) sender
{
    [_galleryScrollView scrollRectToVisible:CGRectMake(_galleryScrollView.frame.size.width * _galleryPageControl.currentPage, _galleryScrollView.frame.origin.x, _galleryScrollView.frame.size.width, _galleryScrollView.frame.size.height) animated:YES];
}

#pragma mark - Orientation Change

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
     currentPage=(int)_galleryPageControl.currentPage;
    
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            _galleryScrollView.frame = CGRectMake(_galleryScrollView.frame.origin.x,_galleryScrollView.frame.origin.y, 1024, 440);
        }
        else
        {
            _galleryScrollView.frame = CGRectMake(_galleryScrollView.frame.origin.x,_galleryScrollView.frame.origin.y, 1024,440);
        }

        [self landscapeOrientation];
        
    }
    else if(toInterfaceOrientation==UIInterfaceOrientationLandscapeRight){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            _galleryScrollView.frame = CGRectMake(_galleryScrollView.frame.origin.x,_galleryScrollView.frame.origin.y, 1024, 440);
        }
        else
        {
            _galleryScrollView.frame = CGRectMake(_galleryScrollView.frame.origin.x,_galleryScrollView.frame.origin.y, 1024,440);
        }
        
         [self landscapeOrientation];
    }
    else{
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            _galleryScrollView.frame = CGRectMake(_galleryScrollView.frame.origin.x,_galleryScrollView.frame.origin.y, 768, 610);
        }
        else
        {
            _galleryScrollView.frame = CGRectMake(_galleryScrollView.frame.origin.x,_galleryScrollView.frame.origin.y, 768,610);
        }
        
        [self potraitViewOrientation];

    }
}

-(void)landScabeNavigation{
    UIImage *NavigationLandscapeBackground = [[UIImage imageNamed:@"navBarLandScape.png"]
                                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    
    //[[UINavigationBar appearance] setBackgroundImage:NavigationLandscapeBackground forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:NavigationLandscapeBackground forBarMetrics:UIBarMetricsDefault];
    
    
    
}
-(void)potraitNavigation{
    UIImage *navBarImg = [[UIImage imageNamed:@"navBar.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];    //[[UINavigationBar appearance] setBackgroundImage:NavigationLandscapeBackground forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    
    
    
}


-(void)landscapeOrientation{
        int i=0;
    for(UIView *view in _galleryScrollView.subviews){
        
        view.frame=CGRectMake(_galleryScrollView.frame.size.width*i,view.frame.origin.y, _galleryScrollView.frame.size.width, _galleryScrollView.frame.size.height);
        i=i+1;
       
        for (UIView *AcyView in view.subviews) {
            if ([AcyView isKindOfClass:[AcyView class]]) {
               
                AcyView.frame=CGRectMake(AcyView.frame.origin.x,AcyView.frame.origin.y, view.frame.size.width-10, view.frame.size.height-20);
                AcyView.clipsToBounds=YES;
                for (UIImageView *iMAGEView in AcyView.subviews){
                    
                    if ([iMAGEView isKindOfClass:[UIImageView class]]){
                        
                        iMAGEView.frame=CGRectMake(iMAGEView.frame.origin.x,iMAGEView.frame.origin.y, AcyView.frame.size.width, AcyView.frame.size.height+70);
                        iMAGEView.clipsToBounds = YES;
                        //iMAGEView.contentMode = UIViewContentModeScaleAspectFill;
                       // iMAGEView.contentMode=UIViewContentModeTop;
                       /*iMAGEView.image=[self scale:iMAGEView.image toSize:CGSizeMake(iMAGEView.frame.size.width, iMAGEView.frame.size.height)];*/
                        
                    }
                }
            
            }
            
            
        }
        
    }
    _galleryScrollView.contentSize = CGSizeMake(_galleryScrollView.frame.size.width * _projectDetails.galleryImageLocalPathArr.count, _galleryScrollView.frame.size.height);
    
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))  {
        
        _galleryPageControl.frame = CGRectMake(_galleryPageControl.frame.origin.x,429,_galleryPageControl.frame.size.width,_galleryPageControl.frame.size.height);
    }
    else
    {
       
        _galleryPageControl.frame = CGRectMake(_galleryPageControl.frame.origin.x,375,_galleryPageControl.frame.size.width,_galleryPageControl.frame.size.height);
    }
    float w = _galleryScrollView.frame.size.width;
    float h = _galleryScrollView.frame.size.height;

    NSLog(@"current page====%d",currentPage);
    CGRect toVisible = CGRectMake(_galleryScrollView.frame.size.width*currentPage, 0, w, h);
    NSLog(@"origin====%f,%f,%f,%f",toVisible.origin.x,toVisible.origin.y,toVisible.size.width,toVisible.size.height);
    
    [_galleryScrollView scrollRectToVisible:toVisible animated:NO];
    
    
    if (isExpanded) {
        float changeY=220.0;
          buttonWidth=1024-20;
        // Do your animations here.
        if (btnIndex == 1)
        {
            //contact button
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 260, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, yButton-changeY+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                
            }
            else
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 200, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, yButton-changeY+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                 [_locationBtn setFrame:CGRectMake(10, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                 [_walkthroughBtn setFrame:CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];

            }
        }
        else if (btnIndex == 2)
        {
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 260, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 260+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                 [_locationBtn setFrame:CGRectMake(10, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];

            }
            else
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 200, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 200+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];

            }
        }
        else if (btnIndex == 3)
        {
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 260, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 260+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, 260+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
            }
            else
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 200, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 200+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, 200+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                 [_walkthroughBtn setFrame:CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
            }
        }
        else
        {
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 260, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 260+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, 260+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, 260+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
            }
            else
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 200, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 200+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, 200+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, 200+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
            }
        }
    
    
    float textViewHeight = 0;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        textViewHeight =200.0;
    }
    else
    {
        textViewHeight =200.0;
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
    
    
       
    }
    else{
       
        float changeY=220.0;
        buttonWidth=1024-20;
        
        
        _aboutProjectBtn.frame =CGRectMake(_aboutProjectBtn.frame.origin.x,yButton-changeY,buttonWidth, _aboutProjectBtn.frame.size.height);
       _projectFeaturesBtn.frame = CGRectMake(10, yButton-changeY+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT);
       _walkthroughBtn.frame = CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
     _locationBtn.frame = CGRectMake(10, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
        
       _commonTextView.frame = CGRectMake(10,359-changeY+BTN_HEIGHT, buttonWidth,0);

        
    }
    
    [self landScabeNavigation];

    
}
-(void)potraitViewOrientation{
   

    int i=0;
    for(UIView *view in _galleryScrollView.subviews){
        
        view.frame=CGRectMake(_galleryScrollView.frame.size.width*i,view.frame.origin.y, _galleryScrollView.frame.size.width, _galleryScrollView.frame.size.height);
        i=i+1;
        
        for (UIView *AcyView in view.subviews) {
            if ([AcyView isKindOfClass:[AcyView class]]) {
                
                AcyView.frame=CGRectMake(AcyView.frame.origin.x,AcyView.frame.origin.y, view.frame.size.width-10, view.frame.size.height-20);
                for (UIImageView *iMAGEView in AcyView.subviews){
                    if ([iMAGEView isKindOfClass:[UIImageView class]]){
                        iMAGEView.frame=CGRectMake(iMAGEView.frame.origin.x,iMAGEView.frame.origin.y, AcyView.frame.size.width, AcyView.frame.size.height);
                        iMAGEView.clipsToBounds = YES;
                        
                        //iMAGEView.contentMode = UIViewContentModeScaleAspectFill;
                        //iMAGEView.contentMode=UIViewContentModeTop;


                        /*iMAGEView.image=[self scale:iMAGEView.image toSize:CGSizeMake(iMAGEView.frame.size.width, iMAGEView.frame.size.height)];*/
                    }
                }
                
            }
            
            
        }
        
    }
    
  _galleryScrollView.contentSize = CGSizeMake(_galleryScrollView.frame.size.width * _projectDetails.galleryImageLocalPathArr.count, _galleryScrollView.frame.size.height);
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))  {
        _galleryPageControl.frame = CGRectMake(_galleryPageControl.frame.origin.x,589,_galleryPageControl.frame.size.width,_galleryPageControl.frame.size.height);
    }
    else
    {
        _galleryPageControl.frame = CGRectMake(_galleryPageControl.frame.origin.x,535,_galleryPageControl.frame.size.width,_galleryPageControl.frame.size.height);
    }
    //NSLog(@"_gallery======%f",_galleryPageControl.frame.origin.x);
    
    float w = _galleryScrollView.frame.size.width;
    float h = _galleryScrollView.frame.size.height;
 
      CGRect toVisible = CGRectMake(_galleryScrollView.frame.size.width*currentPage, 0, w, h);
    
    [_galleryScrollView scrollRectToVisible:toVisible animated:NO];
    
    
    
    if (isExpanded) {
        float changeY=0.0;
        buttonWidth=768-20;
        // Do your animations here.
        if (btnIndex == 1)
        {
            //contact button
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 360, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, yButton+changeY+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, yButton+changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, yButton+changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                
            }
            else
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 300, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, yButton+changeY+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, yButton+changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, yButton+changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                
            }
        }
        else if (btnIndex == 2)
        {
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 360, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 360+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, yButton+changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, yButton+changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                
            }
            else
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 300, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 300+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, yButton+changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, yButton+changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                
            }
        }
        else if (btnIndex == 3)
        {
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 360, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 360+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, 360+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, yButton+changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
            }
            else
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 300, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 300+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, 200+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, yButton+changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
            }
        }
        else
        {
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 360, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 360+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, 360+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, 360+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
            }
            else
            {
                [_aboutProjectBtn setFrame:CGRectMake(10, 300, buttonWidth, BTN_HEIGHT)];
                [_projectFeaturesBtn setFrame:CGRectMake(10, 300+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT)];
                [_locationBtn setFrame:CGRectMake(10, 300+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
                [_walkthroughBtn setFrame:CGRectMake(10, 300+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT)];
            }
        }
        
        
        float textViewHeight = 0;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            textViewHeight =330.0;
        }
        else
        {
            textViewHeight =330.0;
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
        
        
        
    }
    else{
        float changeY=0.0;
        buttonWidth=768-20;
        
        
        _aboutProjectBtn.frame =CGRectMake(_aboutProjectBtn.frame.origin.x,yButton-changeY,buttonWidth, _aboutProjectBtn.frame.size.height);
        _projectFeaturesBtn.frame = CGRectMake(10, yButton-changeY+BTN_HEIGHT+PADDING, buttonWidth, BTN_HEIGHT);
        _walkthroughBtn.frame = CGRectMake(10, yButton-changeY+3*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
        _locationBtn.frame = CGRectMake(10, yButton-changeY+2*(BTN_HEIGHT+PADDING), buttonWidth, BTN_HEIGHT);
        
        _commonTextView.frame = CGRectMake(10,359-changeY+BTN_HEIGHT, buttonWidth,0);
        
        
    }

    [self potraitNavigation];
    
    
}
- (UIImage *)scale:(UIImage *)sourceImage toSize:(CGSize)size
{
    
   /* CGSize sourceSize = sourceImage.size;
    CGSize targetSize;
    targetSize.width = (int) (sourceSize.width / 2);
    targetSize.height = (int) (sourceSize.height / 2);
    
    // Access the source data bytes
    NSData* sourceData = (NSData*) CFBridgingRelease(CGDataProviderCopyData(CGImageGetDataProvider(sourceImage.CGImage)));
    unsigned char* sourceBytes = (unsigned char *)[sourceData bytes];
    
    // Some info we'll need later
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(sourceImage.CGImage);
    int bitsPerComponent = CGImageGetBitsPerComponent(sourceImage.CGImage);
    int bitsPerPixel = CGImageGetBitsPerPixel(sourceImage.CGImage);
    int __attribute__((unused)) bytesPerPixel = bitsPerPixel / 8;
    int sourceBytesPerRow = CGImageGetBytesPerRow(sourceImage.CGImage);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(sourceImage.CGImage);
    
    assert(bytesPerPixel == 4);
    assert(bitsPerComponent == 8);
    
    // Bytes per row is (apparently) rounded to some boundary
    assert(sourceBytesPerRow >= ((int) sourceSize.width) * 4);
    assert([sourceData length] == ((int) sourceSize.height) * sourceBytesPerRow);
    
    // Allocate target data bytes
    int targetBytesPerRow = ((int) targetSize.width) * 4;
    // Algorigthm happier if bytes/row a multiple of 16
    targetBytesPerRow = (targetBytesPerRow + 15) & 0xFFFFFFF0;
    int targetBytesSize = ((int) targetSize.height) * targetBytesPerRow;
    unsigned char* targetBytes = (unsigned char*) malloc(targetBytesSize);
    UIImage* targetImage = nil;
    
    // Copy source to target, averaging 4 pixels into 1
    for (int row = 0; row < targetSize.height; row++) {
        unsigned char* sourceRowStart = sourceBytes + (2 * row * sourceBytesPerRow);
        unsigned char* targetRowStart = targetBytes + (row * targetBytesPerRow);
        for (int column = 0; column < targetSize.width; column++) {
            
            int sourceColumnOffset = 2 * column * 4;
            int targetColumnOffset = column * 4;
            
            unsigned char* sourcePixel = sourceRowStart + sourceColumnOffset;
            unsigned char* nextRowSourcePixel = sourcePixel + sourceBytesPerRow;
            unsigned char* targetPixel = targetRowStart + targetColumnOffset;
            
            uint32_t* sourceWord = (uint32_t*) sourcePixel;
            uint32_t* nextRowSourceWord = (uint32_t*) nextRowSourcePixel;
            uint32_t* targetWord = (uint32_t*) targetPixel;
            
            uint32_t sourceWord0 = sourceWord[0];
            uint32_t sourceWord1 = sourceWord[1];
            uint32_t sourceWord2 = nextRowSourceWord[0];
            uint32_t sourceWord3 = nextRowSourceWord[1];
            
            // This apparently bizarre sequence scales the data bytes by 4 so that when added together we'll get an average.  We do lose the least significant bits this way, and thus about half a bit of resolution.
            sourceWord0 = (sourceWord0 & 0xFCFCFCFC) >> 2;
            sourceWord1 = (sourceWord1 & 0xFCFCFCFC) >> 2;
            sourceWord2 = (sourceWord2 & 0xFCFCFCFC) >> 2;
            sourceWord3 = (sourceWord3 & 0xFCFCFCFC) >> 2;
            
            uint32_t resultWord = sourceWord0 + sourceWord1 + sourceWord2 + sourceWord3;
            targetWord[0] = resultWord;
        }
    }
    
    // Convert the bits to an image.  Supposedly CGCreateImage will dispose of the target bytes buffer.
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, targetBytes, targetBytesSize, NULL);
    CGImageRef targetRef = CGImageCreate(targetSize.width, targetSize.height, bitsPerComponent, bitsPerPixel, targetBytesPerRow, colorSpace, bitmapInfo, provider, NULL, FALSE, kCGRenderingIntentDefault);
    targetImage = [UIImage imageWithCGImage:targetRef];
    
    // Clean up
    CGColorSpaceRelease(colorSpace);
    
    // Return result
    return targetImage;*/
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    [sourceImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
