//
//  ImagesPreviewController.m
//  Experion ipad
//
//  Created by Ranjeet on 14/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import "ImagesPreviewController.h"

@interface ImagesPreviewController ()

@end

@implementation ImagesPreviewController

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
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    if ([_titleStr isEqualToString:@""] || !_titleStr)
    {
        _titleStr = @"Preview";
    }
    
    _titleLabel.text = _titleStr;
    
    // NSLog(@"image index = %i", _imageIndex);
    
    // currentImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,45,320, 400)];
    
    imagesScrollView = [[UIScrollView alloc]init];
    currntpage=0;
    forSetImagePage=0;
   if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))  {
        [imagesScrollView setFrame:CGRectMake(0,65,768,940)];
        // [self preparePhotos];
    }
    else{
        
       [imagesScrollView setFrame:CGRectMake(0,45,768,960)];
        // [self preparePhotos5];
    }
    
    imagesScrollView.backgroundColor = [UIColor blackColor];
    imagesScrollView.delegate=self;
    
    
    for (int i = 0; i<_projectDetails.galleryImageLocalPathArr.count; i++) {
        
        
        UIView *imageBGView = [[UIView alloc]initWithFrame:CGRectMake(768*i, 0, 768, imagesScrollView.frame.size.height)];
        imageBGView.backgroundColor = [UIColor clearColor];
        [imagesScrollView addSubview:imageBGView];
        imageBGView.tag = i;
        
        NSString *tempDisplayedImgStr;
        
        if ([_titleStr rangeOfString:@"Westerlies"].location != NSNotFound)
        {
            tempDisplayedImgStr = @"Westerlies";
        }
        else if ([_titleStr rangeOfString:@"Windchants"].location != NSNotFound)
        {
            tempDisplayedImgStr = @"Windchants";
        }
        else if ([_titleStr rangeOfString:@"Heartsong"].location != NSNotFound)
        {
            tempDisplayedImgStr = @"Heartsong";
        }
        else
        {
            tempDisplayedImgStr = @"placeholder-big";
        }
        
        AcyImage *acyimgeview=[[AcyImage alloc]initWithFrame:CGRectMake(10,20,748,imageBGView.frame.size.height-40) :tempDisplayedImgStr];
        [acyimgeview setBackgroundColor:[UIColor clearColor]];
        acyimgeview.tag=999999;
        
        [acyimgeview loadimage:[_projectDetails.galleryImageLocalPathArr objectAtIndex:i] :[_projectDetails.galleryImageURLArr objectAtIndex:i]];
        
        [imageBGView addSubview:acyimgeview];
        
    }
    
    [self.view addSubview:imagesScrollView];
    
    //[self setImagesToScrollView];
    
    imagesScrollView.contentSize = CGSizeMake(768*_projectDetails.galleryImageLocalPathArr.count, imagesScrollView.frame.size.height);
    imagesScrollView.pagingEnabled = YES;
    imagesScrollView.showsHorizontalScrollIndicator = NO;
    imagesScrollView.showsVerticalScrollIndicator = NO;
    
    [imagesScrollView scrollRectToVisible:CGRectMake(imagesScrollView.frame.size.width*(_imageIndex-1), 0, imagesScrollView.frame.size.width, imagesScrollView.frame.size.height) animated:YES];
    imagesScrollView.delegate = self;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        
        _toolBar.barTintColor = [UIColor colorWithRed:33.0/255.0 green:98.0/255.0 blue:171.0/255.0 alpha:1];
        
    }else{
        _toolBar.tintColor = [UIColor colorWithRed:33.0/255.0 green:98.0/255.0 blue:171.0/255.0 alpha:1];
        
    }

    
}

-(void)setImagesToScrollView
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    BOOL isDirExists = [fileManager fileExistsAtPath:_imageDirPathStr isDirectory:&isDir];
    
    
    
    if (isDirExists)
    {
        
        NSArray *imagesArr= [fileManager contentsOfDirectoryAtPath:_imageDirPathStr error:nil];
        
        // int imagesCount = [imagesArr count];
        NSMutableArray *pngFileArr = [[NSMutableArray alloc]init];
        
        for (NSString *tString in imagesArr) {
            if ([tString hasSuffix:@".png"]) {
                
                [pngFileArr addObject:tString];
                
            }
        }
        
        // int xAxis = 0;
        
        for (int i = 0; i<pngFileArr.count; i++) {
            
            
            UIView *imageBGView = [[UIView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 416)];
            imageBGView.backgroundColor = [UIColor clearColor];
            [imagesScrollView addSubview:imageBGView];
            imageBGView.tag = i;
            
            UIImageView *selectedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 300, 350)];
            selectedImageView.backgroundColor = [UIColor clearColor];
            
            NSString *imagePath = [NSString stringWithFormat:@"%@/image%i.png",_imageDirPathStr, i+1];
            NSData *pngData = [NSData dataWithContentsOfFile:imagePath];
            selectedImageView.image = [UIImage imageWithData:pngData];
            [imageBGView addSubview:selectedImageView];
            
            [selectedImageView setContentMode:UIViewContentModeScaleToFill];
            
            
        }
        
        imagesScrollView.contentSize = CGSizeMake(320*pngFileArr.count, imagesScrollView.frame.size.height);
        imagesScrollView.pagingEnabled = YES;
        imagesScrollView.showsHorizontalScrollIndicator = NO;
        imagesScrollView.showsVerticalScrollIndicator = NO;
        
        [imagesScrollView scrollRectToVisible:CGRectMake(320*(_imageIndex-1), 0, 320, 416*1.2) animated:YES];
        
        /*
         // Set up the minimum & maximum zoom scales
         CGRect scrollViewFrame = imagesScrollView.frame;
         CGFloat scaleWidth = scrollViewFrame.size.width / imagesScrollView.contentSize.width;
         CGFloat scaleHeight = scrollViewFrame.size.height / imagesScrollView.contentSize.height;
         CGFloat minScale = MIN(scaleWidth, scaleHeight);
         */
        imagesScrollView.minimumZoomScale = 0.3f;
        imagesScrollView.maximumZoomScale = 1.0f;
        imagesScrollView.zoomScale = 0.3f;
        imagesScrollView.delegate = self;
        
        //[self centerScrollViewContents];
        
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    /*[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    self.toolBar.hidden = NO;*/
    
    self.toolBar.hidden = NO;
    
     forSetImagePage=currntpage;
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            imagesScrollView.frame = CGRectMake(imagesScrollView.frame.origin.x,imagesScrollView.frame.origin.y, 768, 940);
        }
        else
        {
            imagesScrollView.frame = CGRectMake(imagesScrollView.frame.origin.x,imagesScrollView.frame.origin.y, 768,960);
        }
        
        [self potraitViewOrientation];
    }
    else
    {
     
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            imagesScrollView.frame = CGRectMake(imagesScrollView.frame.origin.x,imagesScrollView.frame.origin.y, 1024, 684);
        }
        else
        {
            imagesScrollView.frame = CGRectMake(imagesScrollView.frame.origin.x,imagesScrollView.frame.origin.y, 1024,704);
        }
        
        [self landscapeOrientation];
        
    }
}


-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didRotate:(NSNotification *)notification {
    UIDeviceOrientation orientation = [[notification object] orientation];
    
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        
        // [self.view setTransform:CGAffineTransformMakeRotation(M_PI / 2.0)];
        [self rotateImage:(M_PI / 2.0)];
        
        self.toolBar.hidden = YES;
        self.titleLabel.hidden = YES;
    }
    else if (orientation == UIDeviceOrientationLandscapeRight) {
        
        //[self.view setTransform:CGAffineTransformMakeRotation(M_PI / -2.0)];
        [self rotateImage:(M_PI / -2.0)];
        self.toolBar.hidden = YES;
        self.titleLabel.hidden = YES;
        
        //    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        //        [[UIApplication sharedApplication] setStatusBarHidden:YES ];
        //        [self.view setTransform:CGAffineTransformMakeRotation(M_PI)];
        //         self.toolBar.hidden = YES;
        //         self.titleLabel.hidden = YES;
    } else if (orientation == UIDeviceOrientationPortrait) {
        
        //[self.view setTransform:CGAffineTransformMakeRotation(0.0)];
        [self rotateImage:(0.0)];
        self.toolBar.hidden = NO;
        self.titleLabel.hidden = NO;
    }
}


-(void)rotateImage: (float)piValue
{
    //    [UIView animateWithDuration:0.5
    //                          delay:0.0
    //                        options:3
    //                     animations:^{
    //                         self.view.transform = CGAffineTransformMakeRotation(piValue);                     }
    //                     completion:^(BOOL finished){
    //
    //                     }
    //     ];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    self.view.transform = CGAffineTransformMakeRotation(piValue);
    
    [UIView commitAnimations];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
   
    forSetImagePage=currntpage;

    
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            imagesScrollView.frame = CGRectMake(imagesScrollView.frame.origin.x,imagesScrollView.frame.origin.y, 1024, 684);
        }
        else
        {
            imagesScrollView.frame = CGRectMake(imagesScrollView.frame.origin.x,imagesScrollView.frame.origin.y, 1024,704);
        }
        
        [self landscapeOrientation];
        
    }
    else if(toInterfaceOrientation==UIInterfaceOrientationLandscapeRight){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            imagesScrollView.frame = CGRectMake(imagesScrollView.frame.origin.x,imagesScrollView.frame.origin.y, 1024, 684);
        }
        else
        {
            imagesScrollView.frame = CGRectMake(imagesScrollView.frame.origin.x,imagesScrollView.frame.origin.y, 1024,704);
        }
        
        
        [self landscapeOrientation];
    }
    else{
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            imagesScrollView.frame = CGRectMake(imagesScrollView.frame.origin.x,imagesScrollView.frame.origin.y, 768, 940);
        }
        else
        {
            imagesScrollView.frame = CGRectMake(imagesScrollView.frame.origin.x,imagesScrollView.frame.origin.y, 768,960);
        }
        
        [self potraitViewOrientation];
        
    }
}


-(void)landscapeOrientation{
    
     _flexiSpace.width=945;
    int i=0;
    for(UIView *view in imagesScrollView.subviews){
        
        view.frame=CGRectMake(imagesScrollView.frame.size.width*i,view.frame.origin.y, imagesScrollView.frame.size.width, imagesScrollView.frame.size.height);
        i=i+1;
        
        for (UIView *AcyView in view.subviews) {
            if ([AcyView isKindOfClass:[AcyView class]]) {
                
                AcyView.frame=CGRectMake(AcyView.frame.origin.x,AcyView.frame.origin.y, view.frame.size.width-20, view.frame.size.height-40);
                for (UIImageView *iMAGEView in AcyView.subviews){
                    if ([iMAGEView isKindOfClass:[UIImageView class]]){
                        iMAGEView.frame=CGRectMake(iMAGEView.frame.origin.x,iMAGEView.frame.origin.y, AcyView.frame.size.width, AcyView.frame.size.height);
                        
                        //iMAGEView.image=[self scale:iMAGEView.image toSize:CGSizeMake(iMAGEView.frame.size.width, iMAGEView.frame.size.height)];
                        
                    }
                }
                
            }
            
            
        }
        
    }
    imagesScrollView.contentSize = CGSizeMake(imagesScrollView.frame.size.width * _projectDetails.galleryImageLocalPathArr.count, imagesScrollView.frame.size.height);
    
    float w = imagesScrollView.frame.size.width;
    float h = imagesScrollView.frame.size.height;
    
   
    CGRect toVisible = CGRectMake(imagesScrollView.frame.size.width*forSetImagePage, 0, w, h);
    
    [imagesScrollView scrollRectToVisible:toVisible animated:NO];
    [self landScabeNavigation];
    
    


    
}

-(void)potraitViewOrientation{
     _flexiSpace.width=695;
    int i=0;
    for(UIView *view in imagesScrollView.subviews){
        
        view.frame=CGRectMake(imagesScrollView.frame.size.width*i,view.frame.origin.y, imagesScrollView.frame.size.width, imagesScrollView.frame.size.height);
        i=i+1;
        
        for (UIView *AcyView in view.subviews) {
            if ([AcyView isKindOfClass:[AcyView class]]) {
                
                AcyView.frame=CGRectMake(AcyView.frame.origin.x,AcyView.frame.origin.y, view.frame.size.width-20, view.frame.size.height-40);
                for (UIImageView *iMAGEView in AcyView.subviews){
                    if ([iMAGEView isKindOfClass:[UIImageView class]]){
                        iMAGEView.frame=CGRectMake(iMAGEView.frame.origin.x,iMAGEView.frame.origin.y, AcyView.frame.size.width, AcyView.frame.size.height);
                        
                        //iMAGEView.image=[self scale:iMAGEView.image toSize:CGSizeMake(iMAGEView.frame.size.width, iMAGEView.frame.size.height)];
                        
                    }
                }
                
            }
            
            
        }
        
    }
    imagesScrollView.contentSize = CGSizeMake(imagesScrollView.frame.size.width * _projectDetails.galleryImageLocalPathArr.count, imagesScrollView.frame.size.height);
    
    float w = imagesScrollView.frame.size.width;
    float h = imagesScrollView.frame.size.height;
    
    
    CGRect toVisible = CGRectMake(imagesScrollView.frame.size.width*forSetImagePage, 0, w, h);
    
    [imagesScrollView scrollRectToVisible:toVisible animated:NO];
    [self potraitNavigation];
    
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


//- (void)viewDidUnload {
//    [super viewDidUnload];
//
//    imagesScrollView = nil;
//    //imageBGView = nil;
//}

#pragma mark -

- (void)centerScrollViewContents {
    //    CGSize boundsSize = imagesScrollView.bounds.size;
    //   // CGRect contentsFrame = imageBGView.frame;
    //
    //    if (contentsFrame.size.width < boundsSize.width) {
    //        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    //    } else {
    //        contentsFrame.origin.x = 0.0f;
    //    }
    //
    //    if (contentsFrame.size.height < boundsSize.height) {
    //        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    //    } else {
    //        contentsFrame.origin.y = 0.0f;
    //    }
    //
    //    imageBGView.frame = contentsFrame;
}

//#pragma mark - UIScrollViewDelegate
//
//- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    NSLog(@"scroll inset ==> %f",imagesScrollView.contentOffset.x);
//
//
//    int viewNumber = imagesScrollView.contentOffset.x/320.0;
//
//    // Return the view that we want to zoom
//
//    for (UIView *view in imagesScrollView.subviews) {
//
//        if ([view isKindOfClass:[UIView class]] ) {
//            if (view.tag == viewNumber) {
//                return view;
//            }
//        }
//    }
//   // return imageBGView;
//}
//
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
//    // The scroll view has zoomed, so we need to re-center the contents
//    [self centerScrollViewContents];
//}

//#pragma mark - Orientation
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

#pragma mark -

-(IBAction)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = imagesScrollView.frame.size.width;
     currntpage = floor((imagesScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
	
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	//pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	//pageControlBeingUsed = NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setToolBar:nil];
    [super viewDidUnload];
}
@end
