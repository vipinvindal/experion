//
//  HomeViewController.h
//  Experion
//
//  Created by Sam on 14/11/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITabBarControllerDelegate>
{
    BOOL isExpanded;
    BOOL isContactBtnOn;
    BOOL isOurOffBtnOn;
    int btnIndex;
}
@property (nonatomic, retain) UIButton *contactBtn;
@property (nonatomic, retain) UIButton *ourOfficesBtn;
@property (nonatomic, retain) UITextView *contactBtnTextView;
@property (nonatomic, retain) UITextView *ourOfficesTextView;
@property (nonatomic, retain) IBOutlet UIImageView *bgImgView;

@end
