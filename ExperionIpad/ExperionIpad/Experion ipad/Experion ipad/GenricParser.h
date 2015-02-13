//
//  GenricParser.h
//  Experion
//
//  Created by ALOK NATH KHANNA on 21/11/2013.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenricParser : NSObject

@property (nonatomic, retain) NSMutableArray *customerLedgerArr;

-(void)parseResponseFromUserAuthenticationRequest :(NSDictionary*)jsonArray;

-(void)parseResponseFromFetchinghUserCustomerDataRequest :(NSArray*)jsonArray;

-(void) parseResponseForProjectList:(NSDictionary *)jsonDict;

-(void) parseResponseForProjectDetails:(NSDictionary *)jsonDict;

-(void) parseResponseForClientFeeds:(NSDictionary *)jsonDict;

@end
