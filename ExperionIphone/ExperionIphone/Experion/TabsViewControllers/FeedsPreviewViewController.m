//
//  FeedsPreviewViewController.m
//  Experion
//
//  Created by Sam on 11/12/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import "FeedsPreviewViewController.h"
#import "AcyImage.h"

@interface FeedsPreviewViewController ()

@end

@implementation FeedsPreviewViewController

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
    backButton.frame = CGRectMake(0, 0, 25, 25);
    [backButton setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMe) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    AcyImage *acyimgeview=[[AcyImage alloc]initWithFrame:CGRectMake(15,18,70,60) :@"placeholder"];
    
    acyimgeview.layer.shadowColor=[[UIColor grayColor] CGColor];
    acyimgeview.layer.cornerRadius = 4;
    acyimgeview.layer.shadowOffset=CGSizeMake(3, 3);
    acyimgeview.layer.shadowOpacity=1.0;
    acyimgeview.layer.shadowRadius=1.0;
    //acyimgeview.clipsToBounds = YES;
    
    [acyimgeview setBackgroundColor:[UIColor clearColor]];
    acyimgeview.tag=888;
    
    [acyimgeview loadimage:@"" :_imageURLStr];
    
    [self.view addSubview:acyimgeview];
    
    UITextView *feedsDetailsTextView = [[UITextView alloc]init];
    //_contactBtnTextView.frame = CGRectMake(15, 340, 290, 200);
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        feedsDetailsTextView.frame = CGRectMake(10, 110, 300, 300);
    }
    else
    {
        feedsDetailsTextView.frame = CGRectMake(10, 90, 300, 250);
    }
    
    feedsDetailsTextView.userInteractionEnabled = YES;
    feedsDetailsTextView.scrollEnabled = YES;
    feedsDetailsTextView.editable = NO;
    //_contactBtnTextView.backgroundColor = [UIColor brownColor];
    
    [feedsDetailsTextView setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:0.8]];
    feedsDetailsTextView.textColor = [UIColor colorWithRed:31.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.0];
    feedsDetailsTextView.text = _feedsDescriptionText;
    
    [self.view addSubview:feedsDetailsTextView];
}

-(void)backMe
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
