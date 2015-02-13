//
//  ProjectsListViewController.h
//  Experion
//
//  Created by Sam on 14/11/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectCustomCell.h"

@interface ProjectsListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate>
{
    NSMutableArray *projectList;
    int projectId;
    NSString *projectNameStr;
    BOOL isGetProjectThreadRunning;
}
@property (nonatomic, retain) IBOutlet UITableView *projectListTableView;
@property (nonatomic, retain) NSString *dateStrToSend;
@property (nonatomic, retain) UIRefreshControl *refreshControl;

@end
