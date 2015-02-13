//
//  UserDetailsViewController.h
//  Experion ipad
//
//  Created by Ranjeet on 14/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsViewController : UIViewController<UIScrollViewDelegate,UITabBarControllerDelegate>
{
    
    int currentPage;
}

@property (nonatomic, retain) IBOutlet UILabel *userNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *projectNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *subBlockLabel;
@property (nonatomic, retain) IBOutlet UILabel *areaLabel;
@property (nonatomic, retain) IBOutlet UIView *paymentScheduleView;

@property (nonatomic, retain) NSMutableArray *paymentDetailsArray;

@property (nonatomic, retain) IBOutlet UIPageControl *dataPageControl;
@property (nonatomic, retain) IBOutlet UIScrollView *dataScrollView;

@property (nonatomic, retain) IBOutlet UIImageView *tempImgView;

-(void)testMethod : (NSData*)imgData;

@end
