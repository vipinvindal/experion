//
//  FeedsViewController.m
//  Experion
//
//  Created by Sam on 14/11/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import "FeedsViewController.h"
#import "AcyImage.h"
#import "JsonRequest.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "FeedsPreviewViewController.h"
#import "Constants.h"

@interface FeedsViewController ()

@end

@implementation FeedsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Updates";
        self.tabBarItem.image = [UIImage imageNamed:@"Feeds.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (ver >= 6.0) {
        _refreshControl = [[UIRefreshControl alloc]init];
        
        [_refreshControl addTarget:self action:@selector(getFeedsFromServer) forControlEvents:UIControlEventValueChanged];
        _refreshControl.tintColor = [UIColor lightGrayColor];
        
        NSMutableAttributedString *string = [self getAttributedStr:PULL_TO_REFRESH];
        
        _refreshControl.attributedTitle = string;
        [_feedsTableViewController addSubview:_refreshControl];
    }
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    _feedsListArr = [[NSMutableArray alloc]init];
    [self getFeedsFromServer];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.tabBarController.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHUD) name:@"hideHUD" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDataInTable:) name:@"showDataInTable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllFeeds) name:@"removeAllFeeds" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showContentFromJSONFile) name:@"showContentFromJSONFile" object:nil];
    
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideHUD];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideHUD" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showDataInTable" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"removeAllFeeds" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showContentFromJSONFile" object:nil];
}

-(void)getFeedsFromServer
{
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (ver >= 6.0) {
        
        NSMutableAttributedString *string = [self getAttributedStr:REFRESHING];
        [_refreshControl setAttributedTitle:string];
    }
    
    if (!_feedsListArr)
    {
        _feedsListArr = [[NSMutableArray alloc]init];
    }
    
    if ([self connected]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Please wait...";
        
        JsonRequest *request = [[JsonRequest alloc]init];
        
        [request getClientFeeds:[[NSUserDefaults standardUserDefaults]objectForKey:@"screenResolution"]];
    }
    else
    {
        [self showContentFromJSONFile];
    }
    
}

-(void)showContentFromJSONFile
{
    NSData *savedJsonData = [self getContentFromJSONFile];
    
    if (savedJsonData.length >0)
    {
        NSError *errorInJson = nil;
        
        NSDictionary *returnJsonDict = [NSJSONSerialization JSONObjectWithData:savedJsonData options:NSJSONReadingAllowFragments error:&errorInJson];
        
        if (!errorInJson) {
            _feedsListArr = [returnJsonDict objectForKey:@"feed"];
            [self updateUI];
            
        }
        
    }

}

#pragma mark - Tab Bar Delegate
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 3) {
        float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (ver >= 6.0)
        {
        }
        else
        {
        [self getFeedsFromServer];
        }
    }
    NSLog(@"Selected INDEX OF TAB-BAR ==> %i", tabBarController.selectedIndex);
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
}
//- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
//{
//
//}
//
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    return YES;
//}


#pragma mark -

-(void)showDataInTable : (NSNotification *)notification
{
    _feedsListArr = [[notification userInfo]valueForKey:@"feedsData"];
    
    [self updateUI];
}

-(void)removeAllFeeds
{
    _feedsListArr = [_feedsListArr mutableCopy];
    [_feedsListArr removeAllObjects];
    [self updateUI];
}

#pragma mark- Retrieve from JSON file

-(NSData *) getContentFromJSONFile{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *filePath = [NSString stringWithFormat:@"%@/feeds.json",
                          documentsDirectory];
    
    
    // Load the file into an NSData object called JSONData
    
    NSError *error = nil;
    
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    
    return JSONData;
}

-(void)updateUI
{
    [self hideHUD];
    [_feedsTableViewController reloadData];
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (ver >= 6.0) {
        
        NSMutableAttributedString *string = [self getAttributedStr:PULL_TO_REFRESH];
        [_refreshControl setAttributedTitle:string];
        _refreshControl.attributedTitle = string;
        [_refreshControl endRefreshing];
    }
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
    return [_feedsListArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    ProjectCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //  ProjectLists *projectData=[projectList objectAtIndex:indexPath.row];
    if (cell == nil) {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"ProjectCustomCell" owner:nil options:nil];
        
        for (UIView *view in views) {
            
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell = (ProjectCustomCell*)view;
                
                //TODO NULL CHECK
                cell.titleLabel.text = [[_feedsListArr objectAtIndex:indexPath.row] objectForKey:@"feedTitle"];
                cell.descriptionLabel.text = [[_feedsListArr objectAtIndex:indexPath.row] objectForKey:@"feedDescription"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //                UIView *selectedView = [[UIView alloc]init];
                //                selectedView.backgroundColor = [UIColor whiteColor];
                //                cell.selectedBackgroundView =  selectedView;
                
            }
            
        }
    }
    else {
        AcyImage *acyimgeview=(AcyImage *)[cell.contentView viewWithTag:121212];
        [acyimgeview cancelImageLoad];
        [acyimgeview removeFromSuperview];
        
    }
    AcyImage *acyimgeview=[[AcyImage alloc]initWithFrame:CGRectMake(18,15,55,50) :@"placeholder"];
    
    acyimgeview.layer.shadowColor=[[UIColor grayColor] CGColor];
    acyimgeview.layer.cornerRadius = 4;
    acyimgeview.layer.shadowOffset=CGSizeMake(3, 3);
    acyimgeview.layer.shadowOpacity=1.0;
    acyimgeview.layer.shadowRadius=1.0;
    //acyimgeview.clipsToBounds = YES;
    
    [acyimgeview setBackgroundColor:[UIColor clearColor]];
    acyimgeview.tag=121212;
    
    [acyimgeview loadimage:@"" :[[_feedsListArr objectAtIndex:indexPath.row] objectForKey:@"feedLogo"]];
    
    [cell.contentView addSubview:acyimgeview];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.labelText = @"Please wait...";
    
    FeedsPreviewViewController *feedsPreviewVC = [[FeedsPreviewViewController alloc]init];
    
    feedsPreviewVC.feedsDescriptionText = [[_feedsListArr objectAtIndex:indexPath.row] objectForKey:@"feedDescription"];
    
    feedsPreviewVC.imageURLStr = [[_feedsListArr objectAtIndex:indexPath.row] objectForKey:@"feedLogo"];
    
    [self.navigationController pushViewController:feedsPreviewVC animated:YES];
    
    // [self performSelector:@selector(pushToProjectDetails:) withObject:indexPath afterDelay:0.3];
    
    
}

#pragma mark - Hide HUD
-(void)hideHUD
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network Reachability Check
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

@end
