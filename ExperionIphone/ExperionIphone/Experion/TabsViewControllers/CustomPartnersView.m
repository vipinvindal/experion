//
//  CustomPartnersView.m
//  Experion
//
//  Created by Sam on 22/11/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import "CustomPartnersView.h"

@implementation CustomPartnersView


//- (id)initWithFrame:(CGRect)frame
//{
//   // self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        _scrollView = [[UIScrollView alloc]init];
//        _scrollView.delegate = self;
//        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 751);
//        _scrollView.backgroundColor = [UIColor clearColor];
//       // _imgView1.image = [UIImage imageNamed:@"arcop"];
//       // _scrollView.bounces = NO;
//    }
//    return self;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"About Us";
        //self.tabBarItem.image = [UIImage imageNamed:@"About Us.png"];
    }
    return self;
}

- (void)viewDidLoad
{
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        //_scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 751);
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, 751)];
//        _scrollView.backgroundColor = [UIColor clearColor];
       // _imgView1.image = [UIImage imageNamed:@"arcop"];
       // _scrollView.bounces = NO;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
