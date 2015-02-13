//
//  ProjectsListViewController.h
//  Experion ipad
//
//  Created by Ranjeet on 09/04/14.
//  Copyright (c) 2014 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectCustomCell.h"

@interface ProjectsListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate>
{
    NSMutableArray *projectList;
    int projectId;
    NSString *projectNameStr;
    BOOL isGetProjectThreadRunning;
    UIButton *disclaimerBtn;
    
  }
@property (nonatomic, retain) IBOutlet UITableView *projectListTableView;
@property (nonatomic, retain) NSString *dateStrToSend;
@property (nonatomic, retain) UIRefreshControl *refreshControl;

@end

