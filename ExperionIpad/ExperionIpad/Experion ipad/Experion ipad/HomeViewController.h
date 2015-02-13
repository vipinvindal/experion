//
//  HomeViewController.h
//  Experion ipad
//
//  Created by Ranjeet on 09/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITabBarControllerDelegate,UITextViewDelegate>
{
    BOOL isExpanded;
    BOOL isContactBtnOn;
    BOOL isOurOffBtnOn;
    int btnIndex;
    CGFloat buttonWidth;
    CGFloat ButtonHieht;
    CGFloat yButton;
}
@property (nonatomic, retain) UIButton *contactBtn;
@property (nonatomic, retain) UIButton *ourOfficesBtn;
@property (nonatomic, retain) UITextView *contactBtnTextView;
@property (nonatomic, retain) UITextView *ourOfficesTextView;
@property (nonatomic, retain) IBOutlet UIImageView *bgImgView;

@end
