//
//  DatabaseManager.m
//  Experion
//
//  Created by Sam on 03/12/13.
//  Copyright (c) 2013 Bets. All rights reserved.
// Singleton Class to access the same instance if DatabaseManager class object

#import "DatabaseManager.h"
#import "ProjectLists.h"

@implementation DatabaseManager


static DatabaseManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

+(DatabaseManager*)getSharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance createProjectListTable];
    });
    return sharedInstance;
}

//Creating Table if not exists
-(BOOL)createProjectListTable{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"ProjectDB.sqlite"]];
    BOOL isSuccess = YES;
    //  NSFileManager *filemgr = [NSFileManager defaultManager];
    // if ([filemgr fileExistsAtPath: databasePath ] == NO)
    // {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS PROJECT_LIST (projectID INTEGER PRIMARY KEY, projectName TEXT, shortDescription TEXT, logoURL TEXT, logoLocalPath TEXT)";
        if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
            != SQLITE_OK)
        {
            isSuccess = NO;
            NSLog(@"Failed to create PROJECT_LIST table");
        }
        
        const char *sql_stmt1 =
        "CREATE TABLE IF NOT EXISTS PROJECT_DATA (projectID INTEGER, longDescription TEXT, projectFeatures TEXT, walkthrough TEXT, locationImageURL TEXT, locationImageLocalPath TEXT)";
        if (sqlite3_exec(database, sql_stmt1, NULL, NULL, &errMsg)
            != SQLITE_OK)
        {
            isSuccess = NO;
            NSLog(@"Failed to create PROJECT_DATA table");
        }
        
        
        const char *sql_stmt2 =
        "CREATE TABLE IF NOT EXISTS PROJECT_IMAGES (projectID INTEGER, imageURL TEXT, imageLocalPath TEXT)";
        if (sqlite3_exec(database, sql_stmt2, NULL, NULL, &errMsg)
            != SQLITE_OK)
        {
            isSuccess = NO;
            NSLog(@"Failed to create PROJECT_IMAGES table");
        }
        
        
        sqlite3_close(database);
        return  isSuccess;
    }
    else {
        isSuccess = NO;
        NSLog(@"Failed to open/create database - sql-error: %s", sqlite3_errmsg(database));
    }
    //  }
    return isSuccess;
}

/*
 //TODOS Also UPDATE Data from PROJECT_DATA AND PROJECT_IMAGES TABLE
 -(NSArray*)getDeletedProjectIDsFromDB : (NSArray*)deletedProjectsArr
 {
 //create dictionary which will contain added contacts ID Array and updated contacts ID Array
 NSMutableDictionary *addedUpdatedContactDict = [[NSMutableDictionary alloc]init];
 
 NSMutableArray *updatedContactsIdArr = [[NSMutableArray alloc]init];
 NSMutableArray *addedContactsIdArr = [[NSMutableArray alloc]init];
 
 //[addedUpdatedContactsDictOfArray setValue:addedUpdatedContactsArray forKey:@"Added"];
 
 const char *dbpath = [databasePath UTF8String];
 if (sqlite3_open(dbpath, &database) == SQLITE_OK)
 {
 for (int i =0; i<addedUpdatedContactsArray.count; i++) {
 
 NSString *querySQL = [NSString stringWithFormat:@"SELECT projectID FROM PROJECT_ WHERE lcid=\"%@\"",[addedUpdatedContactsArray objectAtIndex:i]];
 const char *query_stmt = [querySQL UTF8String];
 if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
 {
 if (sqlite3_step(statement) == SQLITE_ROW)
 {
 int lcid = sqlite3_column_int(statement, 0);
 [updatedContactsIdArr addObject:[NSNumber numberWithInt:lcid]];
 }
 else{
 // NSLog(@"Record Not found");
 [addedContactsIdArr addObject:[addedUpdatedContactsArray objectAtIndex:i]];
 //return nil;
 }
 sqlite3_reset(statement);
 }
 }
 }
 else
 NSLog(@"sql-error: %s", sqlite3_errmsg(database));
 
 [addedUpdatedContactDict setValue:addedContactsIdArr forKey:@"addedContacts"];
 [addedUpdatedContactDict setValue:updatedContactsIdArr forKey:@"updatedContacts"];
 return addedUpdatedContactDict;
 }
 */

//saving list of projects in Database
- (void) saveProjectListData:(NSMutableArray*)projectListArrOfDict;
{
    //Establish connection to db
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        for (int i = 0; i<projectListArrOfDict.count; i++) {
            
            NSLog(@"inseart");
            const char *query = "INSERT OR REPLACE INTO PROJECT_LIST (projectID,projectName, shortDescription,logoURL,logoLocalPath) VALUES (?,?,?,?,?)";
            
            sqlite3_exec(database, "BEGIN EXCLUSIVE TRANSACTION", 0, 0, 0);
            if(sqlite3_prepare(database, query, -1, &statement, NULL) == SQLITE_OK)
            {
                sqlite3_bind_int(statement, 1, [[[projectListArrOfDict objectAtIndex:i]objectForKey:@"projectId"]integerValue]);
                
                sqlite3_bind_text(statement, 2, [[[projectListArrOfDict objectAtIndex:i]objectForKey:@"projectName"] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(statement, 3, [[[projectListArrOfDict objectAtIndex:i]objectForKey:@"projectShortDescription"] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(statement, 4, [[[projectListArrOfDict objectAtIndex:i]objectForKey:@"projectLogo"] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(statement, 5,[[self createImagePathoflogo:[[[projectListArrOfDict objectAtIndex:i]objectForKey:@"projectId"]integerValue]] UTF8String], -1, SQLITE_TRANSIENT);
                
                
                if (sqlite3_step(statement) != SQLITE_DONE) NSLog(@"DB not updated. Error: %s",sqlite3_errmsg(database));
                if (sqlite3_reset(statement) != SQLITE_OK) NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
            }
            if (sqlite3_finalize(statement) != SQLITE_OK) NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
            if (sqlite3_exec(database, "COMMIT TRANSACTION", 0, 0, 0) != SQLITE_OK) NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
            
            
        }
        sqlite3_close(database);
    }
    else
        NSLog(@"sql-error: %s", sqlite3_errmsg(database));
    
}

//saving Project Description Data in Database
//Image is saved as a link location in App Document Directory
- (void) saveProjectDetailsDataInDB:(NSDictionary*)projectDetailsDict
{
    //Establish connection to db
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *query = "INSERT OR REPLACE INTO PROJECT_DATA (projectID,longDescription, projectFeatures,walkthrough,locationImageURL,locationImageLocalPath) VALUES (?,?,?,?,?,?)";
        
        sqlite3_exec(database, "BEGIN EXCLUSIVE TRANSACTION", 0, 0, 0);
        if(sqlite3_prepare(database, query, -1, &statement, NULL) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, [[projectDetailsDict objectForKey:@"projectId"]integerValue]);
            
            sqlite3_bind_text(statement, 2, [[projectDetailsDict objectForKey:@"projectLongDescription"] UTF8String], -1, SQLITE_TRANSIENT);
            
            sqlite3_bind_text(statement, 3, [[projectDetailsDict objectForKey:@"feature"] UTF8String], -1, SQLITE_TRANSIENT);
            
            NSMutableArray *walkthroughLinkArr = [projectDetailsDict objectForKey:@"walkThrough"];
            NSString *walkthroughStr = @"";
            
            for (int j = 0; j<walkthroughLinkArr.count; j++) {
                NSString *tempStr = [[walkthroughLinkArr objectAtIndex:j]objectForKey:@"walkThroughLink"];
                walkthroughStr = [walkthroughStr stringByAppendingString:tempStr];
                walkthroughStr = [walkthroughStr stringByAppendingString:@"\n\n"];
            }
            
            sqlite3_bind_text(statement, 4, [walkthroughStr UTF8String], -1, SQLITE_TRANSIENT);
            
            
            NSString *locationMapStr;
            NSArray *locationMapArr = [projectDetailsDict objectForKey:@"locationMap"];
            
            if (locationMapArr.count>0) {
                locationMapStr = [[locationMapArr objectAtIndex:0]objectForKey:@"locationMapLink"];
            }
            else
            {
                locationMapStr = @"";
            }
            
            sqlite3_bind_text(statement, 5, [locationMapStr UTF8String], -1, SQLITE_TRANSIENT);
            
            sqlite3_bind_text(statement, 6,[[self createImagePathOfMapImage:[[projectDetailsDict objectForKey:@"projectId"]integerValue]] UTF8String], -1, SQLITE_TRANSIENT);
            
            
            if (sqlite3_step(statement) != SQLITE_DONE) NSLog(@"DB not updated. Error: %s",sqlite3_errmsg(database));
            if (sqlite3_reset(statement) != SQLITE_OK) NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
        }
        if (sqlite3_finalize(statement) != SQLITE_OK) NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
        if (sqlite3_exec(database, "COMMIT TRANSACTION", 0, 0, 0) != SQLITE_OK) NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
        
        
        //for Addition in PROJECT_IMAGES TABLES
        
        const char *query2 = "INSERT OR REPLACE INTO PROJECT_IMAGES(projectID, imageURL, imageLocalPath) VALUES (?,?,?)";
        
        sqlite3_exec(database, "BEGIN EXCLUSIVE TRANSACTION",0,0,0);
        
        if(sqlite3_prepare(database, query2, -1, &statement, NULL) == SQLITE_OK)
        {
            
            NSMutableArray *imagesArr = [projectDetailsDict objectForKey:@"gallery"];
            
            for (int i = 0; i<imagesArr.count; i++)
            {
                
                sqlite3_bind_int(statement, 1, [[projectDetailsDict objectForKey:@"projectId"]integerValue]);
                
                
                sqlite3_bind_text(statement, 2, [[[imagesArr objectAtIndex:i]objectForKey:@"galleryLink"] UTF8String], -1, SQLITE_TRANSIENT);
                
                NSString *galleryImageLocalPathStr = [NSString stringWithFormat:@"%d_%d",[[projectDetailsDict objectForKey:@"projectId"]integerValue],i+1];
                
                sqlite3_bind_text(statement, 3,[[self createImagePathOfGalleryImages:galleryImageLocalPathStr] UTF8String], -1, SQLITE_TRANSIENT);
                
                
                if (sqlite3_step(statement) != SQLITE_DONE) NSLog(@"DB not updated. Error: %s",sqlite3_errmsg(database));
                if (sqlite3_reset(statement) != SQLITE_OK) NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
            }
        }
        if (sqlite3_finalize(statement) != SQLITE_OK) NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
        if (sqlite3_exec(database, "COMMIT TRANSACTION", 0, 0, 0) != SQLITE_OK) NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
        
        sqlite3_close(database);
    }
    else
        NSLog(@"sql-error: %s", sqlite3_errmsg(database));
}


#pragma mark- Delete a projects
-(void)deleteprojectList:(int)projectId{
   const char *dbpath = [databasePath UTF8String];    
    sqlite3_stmt *updateStmt=nil;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM PROJECT_LIST Where projectID=\"%d\"",projectId];
       
        
        const char *sql_stmt = [sql UTF8String];
        if(sqlite3_prepare_v2(database, sql_stmt, -1, &updateStmt, NULL) != SQLITE_OK)
        {
            
        }
            //NSAssert1(0, @"Error while opening database '%s'", sqlite3_errmsg(database));
        
        if(SQLITE_DONE != sqlite3_step(updateStmt))
        {
            
        }
            //NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
        
        sqlite3_reset(updateStmt);
        sqlite3_finalize(updateStmt);
        sqlite3_close(database);
        
    }
}

#pragma mark- Delete a Project details
-(void)deleteprojectDetails:(int)projectId{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *updateStmt=nil;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM PROJECT_DATA Where projectID=\"%d\"",projectId];
        
        
        const char *sql_stmt = [sql UTF8String];
        if(sqlite3_prepare_v2(database, sql_stmt, -1, &updateStmt, NULL) != SQLITE_OK)
        {
            
        }
           // NSAssert1(0, @"Error while opening database '%s'", sqlite3_errmsg(database));
        
        if(SQLITE_DONE != sqlite3_step(updateStmt))
        {
            
        }
           // NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
        
        sqlite3_reset(updateStmt);
        sqlite3_finalize(updateStmt);
        sqlite3_close(database);
        
    }
}

#pragma mark- Delete a Projects images Details
-(void)deleteprojectImageDetails:(int)projectId{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *updateStmt=nil;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM PROJECT_IMAGES Where projectID=\"%d\"",projectId];
        
        
        const char *sql_stmt = [sql UTF8String];
        if(sqlite3_prepare_v2(database, sql_stmt, -1, &updateStmt, NULL) != SQLITE_OK){
            
        }
            //NSAssert1(0, @"Error while opening database '%s'", sqlite3_errmsg(database));
        
        if(SQLITE_DONE != sqlite3_step(updateStmt))
        {
            
        }
           // NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
        
        sqlite3_reset(updateStmt);
        sqlite3_finalize(updateStmt);
        sqlite3_close(database);
        
    }    
}



#pragma mark- Check record exits in Project List or not
-(BOOL)recordExistOrNot:(int)projectId{
    
    NSString *query  = [NSString stringWithFormat:@"select * from PROJECT_LIST where projectID=\"%d\"",projectId];
    BOOL recordExist=NO;
    
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) == SQLITE_OK)
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
        {
            if (sqlite3_step(statement)==SQLITE_ROW)
            {
                recordExist=YES;
            }
            else
            {
                //////NSLog(@"%s,",sqlite3_errmsg(database));
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
    }
    return recordExist;
}

#pragma mark- Check if Project Details Exist
-(BOOL)checkProjectExistence:(int)projectId
{
    
    NSString *query  = [NSString stringWithFormat:@"select * from PROJECT_DATA where projectID=\"%d\"",projectId];
    BOOL recordExist=NO;
    
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) == SQLITE_OK)
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
        {
            if (sqlite3_step(statement)==SQLITE_ROW)
            {
                recordExist=YES;
            }
            else
            {
                NSLog(@"*****PROJECT NOT EXISTS IN DB*****");
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
    }
    return recordExist;
}

#pragma mark- Get All Project List

-(NSMutableArray*)getAllProjectList
{
    NSMutableArray *projectListArr = [[NSMutableArray alloc]init];
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM PROJECT_LIST"];
        
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                ProjectLists *projectList = [[ProjectLists alloc]init];
                
                [projectList setProjectId:sqlite3_column_int(statement, 0)];
                
                char *projectName = (char *) sqlite3_column_text(statement, 1);
                [projectList setProjectName:[[NSString alloc] initWithUTF8String:projectName]];
                
                char *shortDescription = (char *) sqlite3_column_text(statement, 2);
                [projectList setShortDescription:[[NSString alloc] initWithUTF8String:shortDescription]];
                
                char *logoURL = (char *) sqlite3_column_text(statement, 3);
                [projectList setServerImagePath:[[NSString alloc] initWithUTF8String:logoURL]];
                
                char *logoLocalPath = (char *) sqlite3_column_text(statement, 4);
                [projectList setLocalImagePath:[[NSString alloc] initWithUTF8String:logoLocalPath]];
                
                [projectListArr addObject:projectList];
            }
            sqlite3_finalize(statement);
        }
        
    }
    else
        NSLog(@"sql-error: %s", sqlite3_errmsg(database));
    
    return projectListArr;
    
}

#pragma mark- Get Project Detail according to ID

-(ProjectDetails*)getProjectDetails : (int)projectIDForDetails
{
    ProjectDetails *projectDetails = [[ProjectDetails alloc]init];
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM PROJECT_DATA WHERE projectID = %d",projectIDForDetails];
        
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                [projectDetails setProjectId:sqlite3_column_int(statement, 0)];
                
                char *longDescription = (char *) sqlite3_column_text(statement, 1);
                [projectDetails setLongDescription:[[NSString alloc] initWithUTF8String:longDescription]];
                
                char *projectFeatures = (char *) sqlite3_column_text(statement, 2);
                [projectDetails setProjectFeatures:[[NSString alloc] initWithUTF8String:projectFeatures]];
                
                char *walkthrough = (char *) sqlite3_column_text(statement, 3);
                [projectDetails setWalkthrough:[[NSString alloc] initWithUTF8String:walkthrough]];
                
                char *locationImageURL = (char *) sqlite3_column_text(statement, 4);
                [projectDetails setLocationImageURL:[[NSString alloc] initWithUTF8String:locationImageURL]];
                
                char *locationImageLocalPath = (char *) sqlite3_column_text(statement, 5);
                [projectDetails setLocationImageLocalPath:[[NSString alloc] initWithUTF8String:locationImageLocalPath]];
            }
            sqlite3_finalize(statement);
        }
        
        NSString *query2 = [NSString stringWithFormat:@"SELECT * FROM PROJECT_IMAGES WHERE projectID = %d",projectIDForDetails];
        
        if (sqlite3_prepare_v2(database, [query2 UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                //[projectDetails setProjectId:sqlite3_column_int(statement, 0)];
                
                char *galleryImageURL = (char *) sqlite3_column_text(statement, 1);
                [projectDetails.galleryImageURLArr addObject:[[NSString alloc] initWithUTF8String:galleryImageURL]];
                
                char *galleryImageLocalPath = (char *) sqlite3_column_text(statement, 2);
                [projectDetails.galleryImageLocalPathArr addObject:[[NSString alloc] initWithUTF8String:galleryImageLocalPath]];
                
            }
            sqlite3_finalize(statement);
        }
        
        
    }
    else
        NSLog(@"sql-error: %s", sqlite3_errmsg(database));
    
    return projectDetails;
    
}


#pragma mark- Get Image Path
-(NSString *)dataFilePath{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"ProjectDB.sqlite"]];
    return databasePath;
}

#pragma mark- Create local imagepath
-(NSString *)createImagePathoflogo:(int)projectId{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathToDocuments=[paths objectAtIndex:0];
    NSString *filePath = [pathToDocuments stringByAppendingPathComponent:@"projectLogoImg"];
    
    NSMutableString *imagePath=[[NSMutableString alloc]initWithString:filePath];
    
    [imagePath appendFormat:@"%d.png",projectId];    //NSString *imageMutableurl=[imagePath mutableCopy];
    [self deletImagePath:imagePath];
    return imagePath;
}

#pragma mark- Create local mapImagePath
-(NSString *)createImagePathOfMapImage:(int)projectId{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathToDocuments=[paths objectAtIndex:0];
    NSString *filePath = [pathToDocuments stringByAppendingPathComponent:@"projectMapImg"];
    
    NSMutableString *imagePath=[[NSMutableString alloc]initWithString:filePath];
    
    [imagePath appendFormat:@"%d.png",projectId];
    [self deletImagePath:imagePath];
    return imagePath;
}


#pragma mark- Create local GalleryImagePath
-(NSString *)createImagePathOfGalleryImages:(NSString*)projectAppendedId{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathToDocuments=[paths objectAtIndex:0];
    NSString *filePath = [pathToDocuments stringByAppendingPathComponent:@"projectGalleryImg"];
    
    NSMutableString *imagePath=[[NSMutableString alloc]initWithString:filePath];
    
    [imagePath appendFormat:@"%@.png",projectAppendedId];
    [self deletImagePath:imagePath];
    return imagePath;
}

//Deleting Image Path if exists with same Path name
-(void)deletImagePath:(NSString *)imagePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success =[fileManager removeItemAtPath:imagePath error:&error];
    if (success) {
      
        NSLog(@"Successfully removed");
        
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

@end
