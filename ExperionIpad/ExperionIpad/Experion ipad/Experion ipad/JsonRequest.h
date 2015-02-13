//
//  JsonRequest.h
//  Experion
//
//  Created by ALOK NATH KHANNA on 21/11/2013.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonRequest : NSObject
{
    NSMutableData *returnData;
    NSString *returnString;
    int indexofOperation;
}

-(void)userAuthenticationRequest :(NSString*)name password:(NSString*)password;

-(void)fetchinghUserCustomerData :(NSString*)name;

-(void) getProjectList :(NSString*)imageDescription :(NSString*) lastUpdateDate;

-(void) getProjectDetails :(NSString*)imageDescription projectIDStr:(NSString*) projectID;

-(void) getClientFeeds : (NSString*)screenResolution;

@end
