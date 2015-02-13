//
//  ProjectsListViewController.m
//  Experion ipad
//
//  Created by Ranjeet on 09/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import "ProjectsListViewController.h"
#import "ProjectDetailsViewController.h"
#import "Constants.h"
#import "UserDetailsViewController.h"
#import "MBProgressHUD.h"
#import "JsonRequest.h"
#import "DatabaseManager.h"
#import "AcyImage.h"
#import "DatabaseManager.h"
#import "ProjectLists.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "DisclaimerViewController.h"

@interface ProjectsListViewController ()

@end

@implementation ProjectsListViewController
@synthesize projectListTableView = _projectListTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Projects";
        self.tabBarItem.image = [UIImage imageNamed:@"Projects.png"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
        [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    DatabaseManager *dataManagerObj=[DatabaseManager getSharedInstance];
    projectList=[dataManagerObj getAllProjectList];
    
    //Getting iOS version of Device to check if UIRefreshControl is can be used
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (ver >= 6.0) {
        _refreshControl = [[UIRefreshControl alloc]init];
        
        [_refreshControl addTarget:self action:@selector(prepareToFetchProjectList) forControlEvents:UIControlEventValueChanged];
        _refreshControl.tintColor = [UIColor lightGrayColor];
        
        NSMutableAttributedString *string = [self getAttributedStr:PULL_TO_REFRESH];
        
        _refreshControl.attributedTitle = string;
        [_projectListTableView addSubview:_refreshControl];
    }
    
     disclaimerBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    //[disclaimerBtn setTitle:@"Disclaimer" forState:UIControlStateNormal];
    //disclaimerBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    //  [disclaimerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [disclaimerBtn setTitleColor:[UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [disclaimerBtn setBackgroundImage:[UIImage imageNamed:@"disclaimer"] forState:UIControlStateNormal];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
         disclaimerBtn.frame = CGRectMake(329,914, 100, 45);
    }
    else
    {
        disclaimerBtn.frame = CGRectMake(329,850, 100, 45);
    }
    
    [disclaimerBtn addTarget:self action:@selector(disclaimerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    disclaimerBtn.adjustsImageWhenHighlighted = YES;
    
    
    _projectListTableView.backgroundView=nil;
    _projectListTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_projectListTableView];
    [self.view addSubview:disclaimerBtn];

    
    [self orientationChange];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideHUD];
    [self hoursCompare];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.tabBarController.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addProjectListToDB:) name:@"UpdateProjectListTable" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addProjectDetailsToDB:) name:@"UpdateProjectDataTable" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToProjectDetails) name:@"PushToProjectDetails" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHUD) name:@"hideHUD" object:nil];
    
    [self orientationChange];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateProjectListTable" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateProjectDataTable" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PushToProjectDetails" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideHUD" object:nil];
}

-(void)orientationChange{
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            disclaimerBtn.frame = CGRectMake(329,914, 100, 45);
        }
        else
        {
            disclaimerBtn.frame = CGRectMake(329,850, 100, 45);
        }
        
        [self potraitNavigation];

    }
    else{
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            disclaimerBtn.frame = CGRectMake(462,658, 100, 45);
        }
        else
        {
            disclaimerBtn.frame = CGRectMake(462,594, 100, 45);
        }
        
        [self landScabeNavigation];

    }
    
    
}


#pragma mark -
-(void) disclaimerBtnClicked : (id) sender
{
    DisclaimerViewController *disclaimerVC = [[DisclaimerViewController alloc]init];
    [self presentViewController:disclaimerVC animated:YES completion:nil];
}

#pragma mark- HUD

-(void)hideHUD
{
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (ver >= 6.0) {
        NSMutableAttributedString *string = [self getAttributedStr:PULL_TO_REFRESH];
        [_refreshControl setAttributedTitle:string];
        [_refreshControl endRefreshing];
    }
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    isGetProjectThreadRunning = NO;
}

#pragma mark - Attributed String
-(NSMutableAttributedString*)getAttributedStr : (NSString*)titleStr
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:titleStr];
    NSRange fullRange = NSMakeRange(0, [string length]);
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:fullRange];
    //[string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:15] range:fullRange];
    return string;
}

#pragma mark - TabBarController Delegate
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // NSLog(@"33 Selected INDEX OF TAB-BAR ==> %i", tabBarController.selectedIndex);
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - Addition to DATABASE

-(void)addProjectListToDB : (NSNotification *)notification
{
    NSMutableArray *deletedProjectArrOfDict = [[notification userInfo]valueForKey:@"deletedProjectArrOfDict"];
    
    NSMutableArray *addedUpdatedProjectArrOfDict = [[notification userInfo]valueForKey:@"addedUpdatedProjectArrOfDict"];
    
    DatabaseManager *dbManager = [DatabaseManager getSharedInstance];
    
    for (int i = 0; i<deletedProjectArrOfDict.count; i++)
    {
        [dbManager deleteprojectList:[[[deletedProjectArrOfDict objectAtIndex:i]objectForKey:@"deletedProject"]integerValue]];
        [dbManager deleteprojectDetails:[[[deletedProjectArrOfDict objectAtIndex:i]objectForKey:@"deletedProject"]integerValue]];
        [dbManager deleteprojectImageDetails:[[[deletedProjectArrOfDict objectAtIndex:i]objectForKey:@"deletedProject"]integerValue]];
        
    }
    
    if (addedUpdatedProjectArrOfDict.count>0) {
        
        [dbManager saveProjectListData:addedUpdatedProjectArrOfDict];
    }
    
    for (int i = 0; i<addedUpdatedProjectArrOfDict.count; i++)
    {
        
        [dbManager deleteprojectDetails:[[[addedUpdatedProjectArrOfDict objectAtIndex:i]objectForKey:@"projectId"]integerValue]];
        [dbManager deleteprojectImageDetails:[[[addedUpdatedProjectArrOfDict objectAtIndex:i]objectForKey:@"projectId"]integerValue]];
        
    }
    
    
    
    [self updateTableUI];
}

-(void)addProjectDetailsToDB : (NSNotification *)notification
{
    DatabaseManager *dbManager = [DatabaseManager getSharedInstance];
    
    NSMutableDictionary *currentProjectDetailsDict = [[notification userInfo]valueForKey:@"project"];
    
    [dbManager saveProjectDetailsDataInDB:currentProjectDetailsDict];
    
    [self pushToProjectDetails];
    
}


#pragma mark - TableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [indexPath row] * 100;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [projectList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    ProjectCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    ProjectLists *projectData=[projectList objectAtIndex:indexPath.row];
    if (cell == nil) {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"ProjectCustomCell" owner:nil options:nil];
        
        for (UIView *view in views) {
            
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell = (ProjectCustomCell*)view;
                
                //TODO NULL CHECK
                cell.backgroundColor=[UIColor clearColor];
                cell.titleLabel.text = projectData.projectName;
                cell.descriptionLabel.text =projectData.shortDescription;
                
                // cell.titleLabel.text = [[_arrayToDisplayAds objectAtIndex:indexPath.row]objectForKey:@"ad_title"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //                UIView *selectedView = [[UIView alloc]init];
                //                selectedView.backgroundColor = [UIColor whiteColor];
                //                cell.selectedBackgroundView =  selectedView;
                
            }
            
        }
    }
    else {
        //Asynchronous image View to set the image downloaded from Server asynchronously
        AcyImage *acyimgeview=(AcyImage *)[cell.contentView viewWithTag:999999];
        [acyimgeview cancelImageLoad];
        [acyimgeview removeFromSuperview];
        
    }
    AcyImage *acyimgeview=[[AcyImage alloc]initWithFrame:CGRectMake(18,30,95,90) :@"placeholder"];
    [acyimgeview setBackgroundColor:[UIColor clearColor]];
    acyimgeview.tag=999999;
    
    acyimgeview.layer.shadowColor=[[UIColor grayColor] CGColor];
    //acyimgeview.layer.cornerRadius = 4;
    acyimgeview.layer.shadowOffset=CGSizeMake(3, 3);
    acyimgeview.layer.shadowOpacity=1.0;
    acyimgeview.layer.shadowRadius=1.0;
    
    [acyimgeview loadimage:projectData.localImagePath :projectData.serverImagePath];
    
    [cell.contentView addSubview:acyimgeview];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Please wait...";
    
    ProjectLists *projectData=[projectList objectAtIndex:indexPath.row];
    projectId = projectData.projectId;
    projectNameStr = projectData.projectName;
    
    DatabaseManager *dbManager = [DatabaseManager getSharedInstance];
    if ([dbManager checkProjectExistence:projectId])
    {
        [self pushToProjectDetails];
    }
    else
    {
        JsonRequest *request = [[JsonRequest alloc]init];
        NSString *projectIdStr = [NSString stringWithFormat:@"%d", projectId];
        [request getProjectDetails:[[NSUserDefaults standardUserDefaults]objectForKey:@"screenResolution"] projectIDStr:projectIdStr];
    }
    
    // [self performSelector:@selector(pushToProjectDetails:) withObject:indexPath afterDelay:0.3];
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - ImagePath

-(NSString *)createImagePathoflogo:(int)projectIdForImagePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathToDocuments=[paths objectAtIndex:0];
    NSString *filePath = [pathToDocuments stringByAppendingPathComponent:@"projectLogoImgDEMP"];
    
    NSMutableString *imagePath=[[NSMutableString alloc]initWithString:filePath];
    
    [imagePath appendFormat:@"%d.png",projectIdForImagePath];
    return imagePath;
}

#pragma mark -
-(void)pushToProjectDetails
{
    ProjectDetailsViewController *projectDetailsVC = [[ProjectDetailsViewController alloc]init];
    projectDetailsVC.projectID = projectId;
    projectDetailsVC.projectNameStr = [NSString stringWithFormat:@"%@", projectNameStr];
    [self.navigationController pushViewController:projectDetailsVC animated:YES];
}


//-(void)pushToProjectDetails : (NSIndexPath*)indexPath
//{
////    ProjectLists *projectData=[projectList objectAtIndex:indexPath.row];
////    int projectId=projectData.projectId;
//
//    ProjectDetailsViewController *projectDetailsVC = [[ProjectDetailsViewController alloc]init];
//    projectDetailsVC.projectNameStr = [NSString stringWithFormat:@"%@",[_titleArray objectAtIndex:indexPath.row]];
//    projectDetailsVC.aboutProjectStr = [NSString stringWithFormat:@"%@",[_aboutProjectArr objectAtIndex:indexPath.row]];
//    projectDetailsVC.projectFeaturesStr = [NSString stringWithFormat:@"%@",[_projectFeaturesArr objectAtIndex:indexPath.row]];
//    projectDetailsVC.tempLocationStr = [NSString stringWithFormat:@"%@",[_locationArr objectAtIndex:indexPath.row]];
//    projectDetailsVC.walkthroughStr = [NSString stringWithFormat:@"%@",[_walkthroughArr objectAtIndex:indexPath.row]];
//    [self.navigationController pushViewController:projectDetailsVC animated:YES];
//}


#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Hours
//Update will take place only if 24 hours has been passed since last update, UIRefreshControl will still work in iOS versions >= 7
-(void)hoursCompare{
    
    NSDate* date =[[NSUserDefaults standardUserDefaults] objectForKey:@"mostRecentMentionDate"];
    
    if (date==nil)
    {
        _dateStrToSend = [NSString stringWithFormat:@"1970-01-01"];
        
        if (!isGetProjectThreadRunning) {
            [self getPrjectListFromServer];
        }
    }
    else
    {
        NSDate* currentDate = [NSDate date];
        NSTimeInterval distanceBetweenDates = [currentDate timeIntervalSinceDate:date];
        double secondsInAnHour = 3600;
        NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
        
        if (hoursBetweenDates>=24)
        {
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd"];
            NSString *formattedDate = [df stringFromDate:date];
            _dateStrToSend = formattedDate;
            if (!isGetProjectThreadRunning)
            {
                [self getPrjectListFromServer];
            }
        }
    }
}

#pragma mark- Get project List from server
-(void)getPrjectListFromServer
{
    isGetProjectThreadRunning = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Please wait...";
    
    JsonRequest *request = [[JsonRequest alloc]init];
    
    [request getProjectList:[[NSUserDefaults standardUserDefaults]objectForKey:@"screenResolution"] :_dateStrToSend];
    
}

#pragma mark -
//Get Project List only if Internet Connection is available
-(void) prepareToFetchProjectList
{
    if ([self connected]) {
        
        NSMutableAttributedString *string = [self getAttributedStr:REFRESHING];
        [_refreshControl setAttributedTitle:string];
        
        NSDate* date =[[NSUserDefaults standardUserDefaults] objectForKey:@"mostRecentMentionDate"];
        
        if (date==nil)
        {
            _dateStrToSend = [NSString stringWithFormat:@"1970-01-01"];
        }
        else
        {
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd"];
            NSString *formattedDate = [df stringFromDate:date];
            _dateStrToSend = formattedDate;
        }
        
        if (!isGetProjectThreadRunning)
        {
            [self getPrjectListFromServer];
        }
    }
    else
    {
        NSMutableAttributedString *string = [self getAttributedStr:PULL_TO_REFRESH];
        [_refreshControl setAttributedTitle:string];
        [_refreshControl endRefreshing];
    }
    
}

#pragma mark- Update ui
-(void)updateTableUI
{
    
    DatabaseManager *dataManagerObj=[DatabaseManager getSharedInstance];
    projectList=[dataManagerObj getAllProjectList];
    
    [_projectListTableView reloadData];
    
    [self hideHUD];
}

#pragma mark - Network Reachability Check
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

#pragma mark - Orientation change

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            disclaimerBtn.frame = CGRectMake(462,658, 100, 45);
        }
        else
        {
            disclaimerBtn.frame = CGRectMake(462,594, 100, 45);
        }

        
        [self landScabeNavigation];
        
        
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            disclaimerBtn.frame = CGRectMake(462,658, 100, 45);
        }
        else
        {
            disclaimerBtn.frame = CGRectMake(462,594, 100, 45);
        }
        
        

        [self landScabeNavigation];
        
        
        
    }
    else {
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            disclaimerBtn.frame = CGRectMake(329,914, 100, 45);
        }
        else
        {
            disclaimerBtn.frame = CGRectMake(329,850, 100, 45);
        }

        [self potraitNavigation];
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


-(UIStatusBarStyle)preferredStatusBarStyle{
    
   
    return UIStatusBarStyleLightContent;

}


@end
