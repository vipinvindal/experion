//
//  CustomScrollViewController.m
//  Experion ipad
//
//  Created by Ranjeet on 14/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//


#import "CustomScrollViewController.h"

@interface CustomScrollViewController ()
//@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) AcyImage *imageView;

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;
@end

@implementation CustomScrollViewController

@synthesize scrollView = _scrollView;

//@synthesize imageView = _imageView;

- (void)centerScrollViewContents {
    
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
   
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // Get the location within the image view where we tapped
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale * 2.0f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // Figure out the rect we want to zoom to, then zoom to it
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
   

}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        
        _toolbar.barTintColor = [UIColor colorWithRed:33.0/255.0 green:98.0/255.0 blue:171.0/255.0 alpha:1];
        
    }else{
        _toolbar.tintColor = [UIColor colorWithRed:33.0/255.0 green:98.0/255.0 blue:171.0/255.0 alpha:1];
        
    }
    

    
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
        [self potraitMode];
    }
    else{
        
       
        
        [self landScpeMode];
    }
    
}

-(void)setMapImage
{
    [self.imageView loadimage:_projectDetails.locationImageLocalPath :_projectDetails.locationImageURL];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
      /* [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];*/
    
    
    // Set up the minimum & maximum zoom scales
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didRotate:(NSNotification *)notification {
    UIDeviceOrientation orientation = [[notification object] orientation];
    
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        
        // [self.view setTransform:CGAffineTransformMakeRotation(M_PI / 2.0)];
        [self rotateImage:(M_PI / 2.0)];
        
        _toolbar.hidden = YES;
        _titleLbl.hidden = YES;
        //self.titleLabel.hidden = YES;
    }
    else if (orientation == UIDeviceOrientationLandscapeRight) {
        
        //[self.view setTransform:CGAffineTransformMakeRotation(M_PI / -2.0)];
        // self.scrollView.frame = CGRectMake(5, 40, 310, 491);
        [self rotateImage:(M_PI / -2.0)];
        
        // self.imageView.frame = CGRectMake(0, 0, 500, 300);
        // self.toolBar.hidden = YES;
        //self.titleLabel.hidden = YES;
        //    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        //        [[UIApplication sharedApplication] setStatusBarHidden:YES ];
        //        [self.view setTransform:CGAffineTransformMakeRotation(M_PI)];
        _toolbar.hidden = YES;
        _titleLbl.hidden = YES;
        //         self.titleLabel.hidden = YES;
    } else if (orientation == UIDeviceOrientationPortrait) {
        
        //[self.view setTransform:CGAffineTransformMakeRotation(0.0)];
        //  self.scrollView.frame = CGRectMake(5, 57, 310, 491);
        [self rotateImage:(0.0)];
        _toolbar.hidden = NO;
        _titleLbl.hidden = NO;
        // self.titleLabel.hidden = NO;
    }
}

-(void)rotateImage: (float)piValue
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    self.view.transform = CGAffineTransformMakeRotation(piValue);
    
    //    self.scrollView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    //
    //    NSLog(@"view => %@", self.view);
    //    NSLog(@"Scrollview => %@", self.scrollView);
    //  self.view.frame = CGRectMake(-114, 0, 548, 500);
    [UIView commitAnimations];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration{
    
    
    if (self.scrollView!=nil) {
        [self.scrollView removeFromSuperview];
        self.scrollView=nil;
    }
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        
        [self landScpeMode];
      
        
        //[self.scrollView zoomToRect:[self.scrollView frame] animated:YES];
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        
        
        [self landScpeMode];
        //[self.scrollView zoomToRect:[self.scrollView frame] animated:YES];

    }
    else {
        
        
        [self potraitMode];

        //[self.scrollView zoomToRect:[self.scrollView frame] animated:YES];
        
    }

    
    [self centerScrollViewContents];
    
    /* [self.scrollView zoomToRect:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
//    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0.0);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);*/

    
    

}

-(void)landScpeMode{
       _flexiSpace.width=945;
    
    
    self.scrollView=[[UIScrollView alloc]init];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        [self.scrollView setFrame:CGRectMake(5, 77, 1014,691)];
    }
    else{
        [self.scrollView setFrame:CGRectMake(5, 57, 1014,711)];
    }
    
    [self.view addSubview:self.scrollView];
    
    self.imageView = [[AcyImage alloc]initWithFrame:CGRectMake(35, 0,  self.scrollView.frame.size.width-70,  self.scrollView.frame.size.height-30):@"MapImage"];
    
    [self.imageView setBackgroundColor:[UIColor clearColor]];
    self.imageView.tag=555;
    
    [self.scrollView addSubview:self.imageView];
    
    // Tell the scroll view the size of the contents
    
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    
    [self performSelector:@selector(setMapImage) withObject:nil afterDelay:0.1];
    //[setMapImage ]
    
    self.scrollView.delegate=self;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 4.0f;
    self.scrollView.zoomScale = minScale;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self centerScrollViewContents];
      [self landScabeNavigation];
    


    
}

-(void)potraitMode{
    
    self.scrollView=[[UIScrollView alloc]init];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        [self.scrollView setFrame:CGRectMake(5, 97, 758, 907)];
    }
    else{
        [self.scrollView setFrame:CGRectMake(5, 77, 758, 927)];
    }
    
    [self.view addSubview:self.scrollView];
    
    self.imageView = [[AcyImage alloc]initWithFrame:CGRectMake(0,0,  self.scrollView.frame.size.width,  self.scrollView.frame.size.height-120):@"MapImage"];
    
    [self.imageView setBackgroundColor:[UIColor clearColor]];
    self.imageView.tag=555;
    
    [self.scrollView addSubview:self.imageView];
    
    // Tell the scroll view the size of the contents
    
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    
    [self performSelector:@selector(setMapImage) withObject:nil afterDelay:0.1];
    
    self.scrollView.delegate=self;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 4.0f;
    self.scrollView.zoomScale = minScale;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self centerScrollViewContents];
    _flexiSpace.width=695;
    
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


#pragma mark -

-(IBAction)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
@end