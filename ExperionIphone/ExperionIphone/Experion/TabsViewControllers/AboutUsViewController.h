//
//  AboutUsViewController.h
//  Experion
//
//  Created by Sam on 14/11/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPartnersView.h"

@interface AboutUsViewController : UIViewController< UIScrollViewDelegate, UITabBarControllerDelegate>
{
    
    CGFloat BTN_HEIGHT;
    CGFloat PADDING;
    
    UIImageView *topImgView;
    
    BOOL isExpanded;
    BOOL isAboutUsOn;
    BOOL isManagementTeamBtnOn;
    BOOL isCEOBtnOn;
    BOOL isPartnersBtnOn;
    int btnIndex;
}
@property (nonatomic, retain) UIButton *aboutUsBtn;
@property (nonatomic, retain) UIButton *managementTeamBtn;
@property (nonatomic, retain) UIButton *ceoDeskBtn;
//@property (nonatomic, retain) UIButton *partnersBtn;
@property (nonatomic, retain) UITextView *commonTextView;
//@property (nonatomic, retain) UITextView *ourOfficesTextView;
//@property (nonatomic, retain) CustomPartnersView *partnersView;

@end
