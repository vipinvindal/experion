//
//  AppDelegate.m
//  Experion ipad
//
//  Created by Ranjeet on 09/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "AboutUsViewController.h"
#import "MyProfileViewController.h"
#import "ProjectsListViewController.h"
#import "FeedsViewController.h"
#import "DatabaseManager.h"
#import "Constants.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    /*[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
     [[NSNotificationCenter defaultCenter] addObserver:self    selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];*/
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    UIViewController *aboutUsViewController = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    UIViewController *myProfileViewController = [[MyProfileViewController alloc] initWithNibName:@"MyProfileViewController" bundle:nil];
    UIViewController *projectsListViewController = [[ProjectsListViewController alloc] initWithNibName:@"ProjectsListViewController" bundle:nil];
    UIViewController *feedsViewController = [[FeedsViewController alloc] initWithNibName:@"FeedsViewController" bundle:nil];
    self.tabBarController = [[UITabBarController alloc] init];
    
    // UINavigationController *homeNavController = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    UINavigationController *aboutUsNavController = [[UINavigationController alloc]initWithRootViewController:aboutUsViewController];
    UINavigationController *myProfileNavController = [[UINavigationController alloc]initWithRootViewController:myProfileViewController];
    UINavigationController *projectsListNavController = [[UINavigationController alloc]initWithRootViewController:projectsListViewController];
    UINavigationController *feedsNavController = [[UINavigationController alloc]initWithRootViewController:feedsViewController];
    
    
    UIImage *navBarImg = [[UIImage imageNamed:@"navBar.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //UIImage *landscapeImage = [UIImage imageNamed:@"navBarLandScape.png"];
    UIImage *NavigationLandscapeBackground = [[UIImage imageNamed:@"navBarLandScape.png"]
                                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:NavigationLandscapeBackground forBarMetrics:UIBarMetricsLandscapePhone];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor], UITextAttributeTextColor, [UIColor clearColor], UITextAttributeTextShadowColor,  nil]];
    
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"6.0" options: NSNumericSearch];
    
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
        // OS version >= 6.0
        [[UINavigationBar appearance]setShadowImage:[[UIImage alloc] init]];
        
        
    }
    else
    {
        // OS version < 6.0
    }
    
    
    
    self.tabBarController.viewControllers = @[aboutUsNavController,myProfileNavController, projectsListNavController, feedsNavController,homeViewController];
    
    
    
    UIImage *tabBackground = [[UIImage imageNamed:@"Tab bg.png"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UITabBar appearance] setBackgroundImage:tabBackground];
   // [[UITabBar appearance] setBackgroundColor:[UIColor blueColor]];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        [UITabBar appearance].TintColor = [UIColor colorWithRed:139.0/255.0 green:178.0/255.0 blue:52.0/255.0 alpha:1.0];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    }
    else{
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:139.0/255.0 green:178.0/255.0 blue:52.0/255.0 alpha:1.0]];
    }
    
    //[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"Tab bg.png"]];
    
    
    
    
    
    
    //GET SCREEN RESOLUTION IN dpi
    NSUserDefaults *userDef =[NSUserDefaults standardUserDefaults];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [userDef setObject:SCREEN_RESOLUTION_5S forKey:@"screenResolution"];
    }
    else
    {
        float scale = 1;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            scale = [[UIScreen mainScreen] scale];
        }
        float dpi;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            dpi = 132 * scale;
        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            dpi = 163 * scale;
        } else {
            dpi = 160 * scale;
        }
        
        if (dpi == 326) {
            [userDef setObject:SCREEN_RESOLUTION_IPAD forKey:@"screenResolution"];
        }
        else
        {
            [userDef setObject:SCREEN_RESOLUTION_IPAD forKey:@"screenResolution"];
        }
        
    }
    
    [userDef synchronize];
    
    
    
    
    self.window.rootViewController = self.tabBarController;
    
    [self createTables];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)createTables
{
    DatabaseManager *dbManager = [DatabaseManager getSharedInstance];
    [dbManager createProjectListTable];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void) orientationChanged:(id)object {
    UIDeviceOrientation interfaceOrientation = [[object object] orientation];
    
    if(interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        NSLog(@"orientation is UIInterfaceOrientationPortrait");
        
        UIImage *navBarImg = [[UIImage imageNamed:@"navBar"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [[UINavigationBar appearance] setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    }
    else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        NSLog(@"orientation is UIInterfaceOrientationLandscapeLeft");
        
        UIImage *landscapeImage = [[UIImage imageNamed:@"navBarLandScape.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [[UINavigationBar appearance] setBackgroundImage:landscapeImage forBarMetrics:UIBarMetricsDefault];
    }
    else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        UIImage *landscapeImage = [[UIImage imageNamed:@"navBarLandScape.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [[UINavigationBar appearance] setBackgroundImage:landscapeImage forBarMetrics:UIBarMetricsDefault];
        
    }
    else
    {
        NSLog(@"orientation is UIInterfaceOrientationPortrait 2");
        
        UIImage *navBarImg = [[UIImage imageNamed:@"navBar"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [[UINavigationBar appearance] setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskAll;
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
	//[super willAnimateRotationToInterfaceOrientation:orientation duration:duration];
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        
    }
    else{
        
        
    }
    
    
	
}

@end
