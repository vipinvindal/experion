//
//  DatabaseManager.h
//  Experion
//
//  Created by Sam on 03/12/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ProjectDetails.h"

@interface DatabaseManager : NSObject
{
    NSString *databasePath;
}

+(DatabaseManager*)getSharedInstance;

-(BOOL)createProjectListTable;

//-(NSArray*)getDeletedProjectIDsFromDB : (NSArray*)deletedProjectsArr;

- (void) saveProjectListData:(NSMutableArray*)projectListArrOfDict;

-(NSString *)createImagePathoflogo:(int)projectId;

- (void) saveProjectDetailsDataInDB:(NSDictionary*)projectDetailsDict;
-(NSMutableArray*)getAllProjectList;

-(BOOL)checkProjectExistence:(int)projectId;

-(ProjectDetails*)getProjectDetails : (int)projectIDForDetails;
-(void)deleteprojectList:(int)projectId;
-(void)deleteprojectDetails:(int)projectId;
-(void)deleteprojectImageDetails:(int)projectId;
@end
