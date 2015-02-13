//
//  UserDetailsViewController.m
//  Experion ipad
//
//  Created by Ranjeet on 14/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import "UserDetailsViewController.h"

@interface UserDetailsViewController ()

@end

@implementation UserDetailsViewController

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
    backButton.frame = CGRectMake(0, 0, 35, 25);
    [backButton setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMe) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    //_paymentDetailsArray = [[NSMutableArray alloc]init];
    
    
    if (_paymentDetailsArray.count>0)
    {
        
        _userNameLabel.text = [[_paymentDetailsArray objectAtIndex:0] objectForKey:@"customerName"];
        _projectNameLabel.text = [[_paymentDetailsArray objectAtIndex:0]objectForKey:@"projectName"];
        _subBlockLabel.text = [[_paymentDetailsArray objectAtIndex:0]objectForKey:@"subBlock"];
        
        NSString *unitNoSuperBuiltUp = [NSString stringWithFormat:@"%@ (%@ Sq feet)", [[_paymentDetailsArray objectAtIndex:0]objectForKey:@"unitNumber"], [[_paymentDetailsArray objectAtIndex:0]objectForKey:@"superBuiltUp"]];
        
        _areaLabel.text = unitNoSuperBuiltUp;
    }
    
    _dataPageControl.currentPage = 0;
    _dataPageControl.numberOfPages = _paymentDetailsArray.count;
    
    //Adding Page Controller
    _dataPageControl = [[UIPageControl alloc] init];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        _dataPageControl.frame = CGRectMake(0,844,768,36);
    }
    else
    {
        _dataPageControl.frame = CGRectMake(0,780,768,36);
    }
    _dataPageControl.userInteractionEnabled=NO;
    _dataPageControl.numberOfPages = _paymentDetailsArray.count;
    //pageControl.currentPage = 0;
    
    [_dataPageControl addTarget:self action:@selector(scrollToNext:) forControlEvents:UIControlEventValueChanged];
    _dataPageControl.backgroundColor = [UIColor clearColor];
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (ver >= 6.0) {
        _dataPageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
        _dataPageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    }

    

    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        [self addScrollView];
        [self addpaymentDetailView];
        [self potraitNavigation];
   
        
    }
    else
    {
        [self addScrollViewLansScabe];
        [self addpaymentDetailViewLansScabe];
        [self landScabeNavigation];

        
    }

    
        //Setting number of View to be set in UIScrollView depending on how many property Data a User have
    
    
}

-(void)testMethod : (NSData*)imgData
{
    UIImage *logoImage = [[UIImage alloc]initWithData:imgData];
    
    
    //    //check if image has data
    //    CGImageRef cgref = [logoImage CGImage];
    //    CIImage *cim = [logoImage CIImage];
    //
    //    if (cim == nil && cgref == NULL)
    //    {
    //        NSLog(@"no underlying data");
    //    }
    //
    //  BOOL success=[imgData writeToFile:[self createImagePathOfMapImage] atomically:NO];
    
    
    
    _tempImgView.image = logoImage;
    _tempImgView.backgroundColor = [UIColor redColor];
    // [self.view addSubview:_tempImgView];
    
}

-(NSString *)createImagePathOfMapImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathToDocuments=[paths objectAtIndex:0];
    NSString *filePath = [pathToDocuments stringByAppendingPathComponent:@"demo.png"];
    
    NSMutableString *imagePath=[[NSMutableString alloc]initWithString:filePath];
    
    return imagePath;
}


-(void)addScrollView
{
    _dataScrollView = [[UIScrollView alloc]init];
    _dataScrollView.delegate = self;
    _dataScrollView.backgroundColor = [UIColor clearColor];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        _dataScrollView.frame = CGRectMake(20, 286+64,728, 540);
    }
    else{
        _dataScrollView.frame = CGRectMake(20,286, 728, 540);
    }
    
    _dataScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_dataScrollView];
}

-(void)addpaymentDetailView{
    for (int i = 0; i<_paymentDetailsArray.count; i++)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(728*i,0, _dataScrollView.frame.size.width, _dataScrollView.frame.size.height)];
        
        //view.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:0.95f];
        view.backgroundColor = [UIColor clearColor];
        view.tag = i+1;
        
        UIImageView *bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user-bottombg"]] ;
        
        bgImgView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        [view addSubview:bgImgView];
        
        
        NSString *totalCostStr = [[_paymentDetailsArray objectAtIndex:i]objectForKey:@"totalCost"];
        if ([totalCostStr isKindOfClass:[NSNull class]] || [totalCostStr isEqualToString:@"0"]|| !totalCostStr) {
            totalCostStr = @"0";
        }
        
        NSString *interestRaisedStr = [[_paymentDetailsArray objectAtIndex:i]objectForKey:@"interestRaised"];
        if ([interestRaisedStr isKindOfClass:[NSNull class]] || [interestRaisedStr isEqualToString:@"0"]|| !interestRaisedStr) {
            interestRaisedStr = @"0";
        }
        
        NSString *interestPaidStr = [[_paymentDetailsArray objectAtIndex:i]objectForKey:@"interestPaid"];
        if ([interestPaidStr isKindOfClass:[NSNull class]] || [interestPaidStr isEqualToString:@"0"]|| !interestPaidStr) {
            interestPaidStr = @"0";
        }
        
        NSString *totalOutstandingStr = [[_paymentDetailsArray objectAtIndex:i]objectForKey:@"totalOutstanding"];
        if ([totalOutstandingStr isKindOfClass:[NSNull class]] || [totalOutstandingStr isEqualToString:@"0"]|| !totalOutstandingStr) {
            totalOutstandingStr = @"0";
        }
        
        NSString *interestPendingStr = [[_paymentDetailsArray objectAtIndex:i]objectForKey:@"interestPending"];
        if ([interestPendingStr isKindOfClass:[NSNull class]] || [totalOutstandingStr isEqualToString:@"0"]|| !interestPendingStr) {
            interestPendingStr = @"0";
        }
        
        NSMutableArray *labelAmountArr = [[NSMutableArray alloc]initWithObjects:totalCostStr ,interestRaisedStr,interestPaidStr,totalOutstandingStr,interestPendingStr, nil];
        
        
        NSMutableArray *labelTitleArr = [[NSMutableArray alloc]initWithObjects:@"Cost of the unit", @"Demands raised till date", @"Amount paid till date", @"Total outstanding as on date" ,@"Interest pending payable", nil];
        
        UILabel *paymentDetailsLbl = [[UILabel alloc]initWithFrame:CGRectMake(18, 6, 380, 35)];
        paymentDetailsLbl.backgroundColor = [UIColor clearColor];
        paymentDetailsLbl.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
        paymentDetailsLbl.font = [UIFont boldSystemFontOfSize:17.0];
        paymentDetailsLbl.numberOfLines = 1;
        paymentDetailsLbl.textAlignment = NSTextAlignmentLeft;
        
        //current date
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy"];
        NSString *formattedDate = [df stringFromDate:[NSDate date]];
        
        paymentDetailsLbl.text = [NSString stringWithFormat:@"Payment Summary as on %@",formattedDate];
        
        [view addSubview:paymentDetailsLbl];
        
        //        UILabel *currentDateLbl = [[UILabel alloc]initWithFrame:CGRectMake(paymentDetailsLbl.frame.origin.x+205, -6, 150, 30)];
        //        currentDateLbl.backgroundColor = [UIColor clearColor];
        //        currentDateLbl.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
        //        currentDateLbl.font = [UIFont boldSystemFontOfSize:12.0];
        //        currentDateLbl.numberOfLines = 1;
        //        currentDateLbl.textAlignment = NSTextAlignmentLeft;
        //
        //        //current date
        //
        //        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        //        [df setDateFormat:@"dd/MM/yyyy"];
        //        NSString *formattedDate = [df stringFromDate:[NSDate date]];
        //
        //        currentDateLbl.text = formattedDate;
        //
        //        [view addSubview:currentDateLbl];
        
        UILabel *detailsAmountLbl = [[UILabel alloc]initWithFrame:CGRectMake(26, paymentDetailsLbl.frame.origin.y+49, 700, 30)];
        detailsAmountLbl.backgroundColor = [UIColor clearColor];
        detailsAmountLbl.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
        detailsAmountLbl.font = [UIFont boldSystemFontOfSize:16.0];
        detailsAmountLbl.numberOfLines = 1;
        detailsAmountLbl.textAlignment = NSTextAlignmentLeft;
        detailsAmountLbl.text = @"Details                                                                                                       Amount";
        
        [view addSubview:detailsAmountLbl];
        
        
        //int labelX = 20;
        int labelY = 105;
        for (int j = 0; j<labelTitleArr.count; j++) {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, labelY, 480, 60)];
            //  labelX = labelX+10;
            labelY = labelY+75;
            
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont systemFontOfSize:17.0];
            label.numberOfLines = 1;
            label.textAlignment = NSTextAlignmentLeft;
            label.text = [labelTitleArr objectAtIndex:j];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x+450, label.frame.origin.y+15, 215, 30)];
            label1.backgroundColor = [UIColor clearColor];
            label1.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
            label1.font = [UIFont boldSystemFontOfSize:18.0];
            label1.numberOfLines = 1;
            label1.textAlignment = NSTextAlignmentRight;
            label1.text = [NSString stringWithFormat:@"%@", [labelAmountArr objectAtIndex:j]];
            
            [view addSubview:label];
            [view addSubview:label1];
        }
        
        
        // label.text = [NSString stringWithFormat:@"Total Cost of Project\nInstalments raised till date\nInstalments paid till date\nTotal Outstanding as on date\nInterest pending payable"];
        
        //label.text = [NSString stringWithFormat:@"Total Cost       %@\nInstallment Raised      %@\nInstallment Paid      %@\nTotal Outstanding      %@\nInterest Pending      %@",[[_paymentDetailsArray objectAtIndex:i]objectForKey:@"totalCost"],[[_paymentDetailsArray objectAtIndex:i]objectForKey:@"interestRaised"],[[_paymentDetailsArray objectAtIndex:i]objectForKey:@"interestPaid"],[[_paymentDetailsArray objectAtIndex:i]objectForKey:@"totalOutstanding"],totalOutstandingStr];
        
        
        
        [_dataScrollView addSubview:view];
        
    }
    
    _dataScrollView.contentSize = CGSizeMake(_dataScrollView.frame.size.width * _paymentDetailsArray.count, _dataScrollView.frame.size.height);
    _dataScrollView.pagingEnabled = YES;
    
    
    [self.view addSubview:_dataPageControl];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        _dataPageControl.frame = CGRectMake(_dataPageControl.frame.origin.x,844,_dataPageControl.frame.size.width,36);
    }
    else
    {
        _dataPageControl.frame = CGRectMake(_dataPageControl.frame.origin.x,780,_dataPageControl.frame.size.width,36);
    }

}

-(void)addScrollViewLansScabe{
    _dataScrollView = [[UIScrollView alloc]init];
    _dataScrollView.delegate = self;
    _dataScrollView.backgroundColor = [UIColor clearColor];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        _dataScrollView.frame = CGRectMake(20, 266+64,984, 340);
    }
    else{
        _dataScrollView.frame = CGRectMake(20,266, 984, 340);
    }
    
    _dataScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_dataScrollView];

}

-(void)addpaymentDetailViewLansScabe{
    for (int i = 0; i<_paymentDetailsArray.count; i++)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(984*i,0, _dataScrollView.frame.size.width, _dataScrollView.frame.size.height)];
        
        //view.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:0.95f];
        view.backgroundColor = [UIColor clearColor];
        view.tag = i+1;
        
        UIImageView *bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user-bottombg"]] ;
        
        bgImgView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        [view addSubview:bgImgView];
        
        
        NSString *totalCostStr = [[_paymentDetailsArray objectAtIndex:i]objectForKey:@"totalCost"];
        if ([totalCostStr isKindOfClass:[NSNull class]] || [totalCostStr isEqualToString:@"0"]|| !totalCostStr) {
            totalCostStr = @"0";
        }
        
        NSString *interestRaisedStr = [[_paymentDetailsArray objectAtIndex:i]objectForKey:@"interestRaised"];
        if ([interestRaisedStr isKindOfClass:[NSNull class]] || [interestRaisedStr isEqualToString:@"0"]|| !interestRaisedStr) {
            interestRaisedStr = @"0";
        }
        
        NSString *interestPaidStr = [[_paymentDetailsArray objectAtIndex:i]objectForKey:@"interestPaid"];
        if ([interestPaidStr isKindOfClass:[NSNull class]] || [interestPaidStr isEqualToString:@"0"]|| !interestPaidStr) {
            interestPaidStr = @"0";
        }
        
        NSString *totalOutstandingStr = [[_paymentDetailsArray objectAtIndex:i]objectForKey:@"totalOutstanding"];
        if ([totalOutstandingStr isKindOfClass:[NSNull class]] || [totalOutstandingStr isEqualToString:@"0"]|| !totalOutstandingStr) {
            totalOutstandingStr = @"0";
        }
        
        NSString *interestPendingStr = [[_paymentDetailsArray objectAtIndex:i]objectForKey:@"interestPending"];
        if ([interestPendingStr isKindOfClass:[NSNull class]] || [totalOutstandingStr isEqualToString:@"0"]|| !interestPendingStr) {
            interestPendingStr = @"0";
        }
        
        NSMutableArray *labelAmountArr = [[NSMutableArray alloc]initWithObjects:totalCostStr ,interestRaisedStr,interestPaidStr,totalOutstandingStr,interestPendingStr, nil];
        
        
        NSMutableArray *labelTitleArr = [[NSMutableArray alloc]initWithObjects:@"Cost of the unit", @"Demands raised till date", @"Amount paid till date", @"Total outstanding as on date" ,@"Interest pending payable", nil];
        
        UILabel *paymentDetailsLbl = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 380, 35)];
        paymentDetailsLbl.backgroundColor = [UIColor clearColor];
        paymentDetailsLbl.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
        paymentDetailsLbl.font = [UIFont boldSystemFontOfSize:16.0];
        paymentDetailsLbl.numberOfLines = 1;
        paymentDetailsLbl.textAlignment = NSTextAlignmentLeft;
        
        //current date
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy"];
        NSString *formattedDate = [df stringFromDate:[NSDate date]];
        
        paymentDetailsLbl.text = [NSString stringWithFormat:@"Payment Summary as on %@",formattedDate];
        
        [view addSubview:paymentDetailsLbl];
        
        //        UILabel *currentDateLbl = [[UILabel alloc]initWithFrame:CGRectMake(paymentDetailsLbl.frame.origin.x+205, -6, 150, 30)];
        //        currentDateLbl.backgroundColor = [UIColor clearColor];
        //        currentDateLbl.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
        //        currentDateLbl.font = [UIFont boldSystemFontOfSize:12.0];
        //        currentDateLbl.numberOfLines = 1;
        //        currentDateLbl.textAlignment = NSTextAlignmentLeft;
        //
        //        //current date
        //
        //        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        //        [df setDateFormat:@"dd/MM/yyyy"];
        //        NSString *formattedDate = [df stringFromDate:[NSDate date]];
        //
        //        currentDateLbl.text = formattedDate;
        //
        //        [view addSubview:currentDateLbl];
        
        UILabel *detailsAmountLbl = [[UILabel alloc]initWithFrame:CGRectMake(26, paymentDetailsLbl.frame.origin.y+29, 800, 30)];
        detailsAmountLbl.backgroundColor = [UIColor clearColor];
        detailsAmountLbl.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
        detailsAmountLbl.font = [UIFont boldSystemFontOfSize:16.0];
        detailsAmountLbl.numberOfLines = 1;
        detailsAmountLbl.textAlignment = NSTextAlignmentLeft;
        detailsAmountLbl.text = @"Details                                                                                                                                      Amount";
        
        [view addSubview:detailsAmountLbl];
        
        
        //int labelX = 20;
        int labelY = 55;
        for (int j = 0; j<labelTitleArr.count; j++) {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, labelY, 480, 60)];
            //  labelX = labelX+10;
            labelY = labelY+45;
            
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont systemFontOfSize:17.0];
            label.numberOfLines = 1;
            label.textAlignment = NSTextAlignmentLeft;
            label.text = [labelTitleArr objectAtIndex:j];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x+630, label.frame.origin.y+15, 290, 30)];
            label1.backgroundColor = [UIColor clearColor];
            label1.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
            label1.font = [UIFont boldSystemFontOfSize:18.0];
            label1.numberOfLines = 1;
            label1.textAlignment = NSTextAlignmentRight;
            label1.text = [NSString stringWithFormat:@"%@", [labelAmountArr objectAtIndex:j]];
            
            [view addSubview:label];
            [view addSubview:label1];
        }
        
        
        // label.text = [NSString stringWithFormat:@"Total Cost of Project\nInstalments raised till date\nInstalments paid till date\nTotal Outstanding as on date\nInterest pending payable"];
        
        //label.text = [NSString stringWithFormat:@"Total Cost       %@\nInstallment Raised      %@\nInstallment Paid      %@\nTotal Outstanding      %@\nInterest Pending      %@",[[_paymentDetailsArray objectAtIndex:i]objectForKey:@"totalCost"],[[_paymentDetailsArray objectAtIndex:i]objectForKey:@"interestRaised"],[[_paymentDetailsArray objectAtIndex:i]objectForKey:@"interestPaid"],[[_paymentDetailsArray objectAtIndex:i]objectForKey:@"totalOutstanding"],totalOutstandingStr];
        
        
        
        [_dataScrollView addSubview:view];
        
    }
    
    _dataScrollView.contentSize = CGSizeMake(_dataScrollView.frame.size.width * _paymentDetailsArray.count, _dataScrollView.frame.size.height);
    _dataScrollView.pagingEnabled = YES;
    
    
    [self.view addSubview:_dataPageControl];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        _dataPageControl.frame = CGRectMake(_dataPageControl.frame.origin.x,636,_dataPageControl.frame.size.width,36);
    }
    else
    {
       _dataPageControl.frame = CGRectMake(_dataPageControl.frame.origin.x,573,_dataPageControl.frame.size.width,36);
    }

    
}

#pragma mark - Page Control Methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _dataScrollView.frame.size.width;
    int page = floor((_dataScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _dataPageControl.currentPage = page;
    
    _userNameLabel.text = [[_paymentDetailsArray objectAtIndex:_dataPageControl.currentPage] objectForKey:@"customerName"];
    _projectNameLabel.text = [[_paymentDetailsArray objectAtIndex:_dataPageControl.currentPage]objectForKey:@"projectName"];
    _subBlockLabel.text = [[_paymentDetailsArray objectAtIndex:_dataPageControl.currentPage]objectForKey:@"subBlock"];
    
    NSString *unitNoSuperBuiltUp = [NSString stringWithFormat:@"%@ (%@ Sq feet)", [[_paymentDetailsArray objectAtIndex:_dataPageControl.currentPage]objectForKey:@"unitNumber"], [[_paymentDetailsArray objectAtIndex:_dataPageControl.currentPage]objectForKey:@"superBuiltUp"]];
    
    
    _areaLabel.text = unitNoSuperBuiltUp;
	
}

-(IBAction) scrollToNext : (id) sender
{
    [_dataScrollView scrollRectToVisible:CGRectMake(_dataScrollView.frame.size.width * _dataPageControl.currentPage, _dataScrollView.frame.origin.x, _dataScrollView.frame.size.width, _dataScrollView.frame.size.height) animated:YES];
}

-(void)backMe
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    if (_dataScrollView!=nil) {
        [_dataScrollView removeFromSuperview];
        _dataScrollView=nil;
    }
    
    currentPage=_dataPageControl.currentPage;
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        
        
        [self addScrollViewLansScabe];
        [self addpaymentDetailViewLansScabe];
        [self landScabeNavigation];

        
        
        
        
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        
        
        
        [self addScrollViewLansScabe];
        [self addpaymentDetailViewLansScabe];
        
        [self landScabeNavigation];
        
        
        
    }
    else {
        
        [self addScrollView];
        [self addpaymentDetailView];
        [self potraitNavigation];
        
    }
    
    float w = _dataScrollView.frame.size.width;
    float h = _dataScrollView.frame.size.height;
    
    //NSLog(@"current page====%d",currentPage);
    CGRect toVisible = CGRectMake(_dataScrollView.frame.size.width*currentPage, 0, w, h);
    NSLog(@"origin====%f,%f,%f,%f",toVisible.origin.x,toVisible.origin.y,toVisible.size.width,toVisible.size.height);
    
    [_dataScrollView scrollRectToVisible:toVisible animated:NO];
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


-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
