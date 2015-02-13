//
//  JsonRequest.m
//  Experion
//
//  Created by ALOK NATH KHANNA on 21/11/2013.
//  Copyright (c) 2013 Bets. All rights reserved.
//
// All JSON Request will be handled in this class

#import "JsonRequest.h"
#import "JsonTags.h"
#import "HttpConnection.h"
#import "GenricParser.h"
#import "Constants.h"

@implementation JsonRequest

#pragma mark - PostingRequest


// Experion Customer Ledger Request to Authenticate Customer
-(void)userAuthenticationRequest :(NSString*)name password:(NSString*)password
{
    indexofOperation = 1;
    NSString *urlPath = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Server URL"];
    NSString *UrlString = [NSString stringWithFormat:@"%@%@?Username=%@&Password=%@&UserType=",urlPath,userAuthenticateUrl,name,password];
    NSURL *userAuthenticateUrlString = [[NSURL alloc]initWithString:[UrlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:userAuthenticateUrlString];
    [request setHTTPMethod:@"GET"];
    [request setURL:userAuthenticateUrlString];
    NSURLConnection *connection = [HttpConnection sharedSingleton];
    NSLog(@"url=====%@",userAuthenticateUrlString);
    (void)[connection initWithRequest:request delegate:self];
    [connection start];
}

// After successful Authentication request to fetch Customer Ledger Data
-(void)fetchinghUserCustomerData :(NSString*)name
{
    indexofOperation = 2;
    NSString *urlPath = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Server URL"];
    //    NSString *userTokenId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userTokenId"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"userTokenId"];
    
    NSString *userToken = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)token, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    
    NSString *formattedString = [NSString stringWithFormat:@"%@%@?username=%@&UserToken=%@",urlPath,fetchingTheCustomerOS,name,userToken];
    
    //    NSLog(@"String====>%@",String);
    //  NSString *UrlString = [NSString stringWithFormat:@"%@%@",urlPath,fetchingTheCustomerOS];
    
    NSURL *fetchingTheCustomerOSUrlString = [NSURL URLWithString:formattedString];
    
    
    //    NSDictionary *jsonDictonary =  [[NSDictionary alloc] initWithObjectsAndKeys:@"fQIMjKIoIynpnt3bByXRt6jOjHcPi2y6BLqGequghOiuIdSu4Gl+EeP24aQ3k3BdVsnNz1XZKS9EEOg8jF9KDA==",@"UserToken",name,@"username",nil];
    
    //    NSError *error = nil;
    //    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictonary options:kNilOptions error:&error];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:fetchingTheCustomerOSUrlString];
    [request setHTTPMethod:@"GET"];
    //    [request setHTTPBody: jsonData];
    [request setURL:fetchingTheCustomerOSUrlString];
    
    NSURLConnection *connection = [HttpConnection sharedSingleton];
    (void)[connection initWithRequest:request delegate:self];
    [connection start];
}

//POST Request to get Project List
-(void) getProjectList :(NSString*)imageDescription :(NSString*) lastUpdateDate
{
    indexofOperation = 3;
    
    NSDictionary *projectDetails = [[NSDictionary alloc] initWithObjectsAndKeys:imageDescription,@"resolution",lastUpdateDate,@"updateDate", nil];
    NSError *error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:projectDetails options:kNilOptions error:&error];
    
    NSString *urlPath = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"BetsServer URL"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",urlPath,GET_PROJECT_LIST];
    NSURL *fetchProjectDetailsUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:fetchProjectDetailsUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: jsonData];
    [request setURL:fetchProjectDetailsUrl];
    NSURLConnection *connection = [HttpConnection sharedSingleton];
    (void)[connection initWithRequest:request delegate:self];
    [connection start];
}

//POST Request to get Project Description/Details
-(void) getProjectDetails :(NSString*)imageDescription projectIDStr:(NSString*) projectID
{
    indexofOperation = 4;
    
    NSDictionary *projectDetails = [[NSDictionary alloc] initWithObjectsAndKeys:imageDescription,@"resolution",projectID,@"projectId", nil];
    NSError *error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:projectDetails options:kNilOptions error:&error];
    
    NSString *urlPath = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"BetsServer URL"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",urlPath,GET_PROJECT_DETAILS];
    NSURL *fetchProjectDetailsUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:fetchProjectDetailsUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: jsonData];
    [request setURL:fetchProjectDetailsUrl];
    NSURLConnection *connection = [HttpConnection sharedSingleton];
    (void)[connection initWithRequest:request delegate:self];
    [connection start];
}

//POST Request to get Client Feeds
-(void) getClientFeeds : (NSString*)screenResolution
{
    indexofOperation = 5;
    
    NSDictionary *feedsJsonDic = [[NSDictionary alloc] initWithObjectsAndKeys:screenResolution,@"resolution", nil];
    NSError *error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:feedsJsonDic options:kNilOptions error:&error];
    
    NSString *urlPath = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"BetsServer URL"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",urlPath,GET_CLIENT_FEEDS];
    NSURL *getClientFeedsUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:getClientFeedsUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: jsonData];
    [request setURL:getClientFeedsUrl];
    NSURLConnection *connection = [HttpConnection sharedSingleton];
    (void)[connection initWithRequest:request delegate:self];
    [connection start];
}


#pragma mark - Connection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    returnData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [returnData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    if (returnData != nil && returnString.length > 0) {
        
        if (indexofOperation == 1)
        {returnString = [self stringBetweenString:@"[" andString:@"]"];}
        else if (indexofOperation == 2)
            // Delimite the JSON between useless string
        {returnString = [self stringBetweenString:@"<string xmlns=\"http://tempuri.org/\">" andString:@"</string>"];}
        else if (indexofOperation == 3)
        {
            // Do nothing
        }
        
        if (returnString.length == 0 || !returnString)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hideHUD" object:nil];
            
            if (indexofOperation == 1 || indexofOperation == 2) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to process your request\nPlease try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else
            {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to process your request\nPlease try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
            }
            
        }
        else
        {
            NSData *data = [returnString dataUsingEncoding:NSUTF8StringEncoding];
            returnData = [data mutableCopy];
            NSError *errorInJson = nil;
            
            NSDictionary *returnJsonDict = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:&errorInJson];
            
            if (!errorInJson)
            {
                if (indexofOperation == 1)
                {
                    GenricParser *parser = [[GenricParser alloc] init];
                    [parser parseResponseFromUserAuthenticationRequest:returnJsonDict];
                }
                else if (indexofOperation == 2)
                {
                    GenricParser *parser = [[GenricParser alloc] init];
                    NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:returnData                                                                                                                     options:0 error:&errorInJson];
                    if (!errorInJson) {
                        [parser parseResponseFromFetchinghUserCustomerDataRequest:responseArray];
                    }
                    else
                    {
                        [self showErrorAlert];
                    }
                }
                else if (indexofOperation == 3)
                {
                    GenricParser *parser = [[GenricParser alloc] init];
                    [parser parseResponseForProjectList:returnJsonDict];
                }
                else if (indexofOperation == 4)
                {
                    GenricParser *parser = [[GenricParser alloc] init];
                    [parser parseResponseForProjectDetails:returnJsonDict];
                }
                
                else if (indexofOperation == 5)
                {
                    [self writeToJSONFile:returnData];
                    GenricParser *parser = [[GenricParser alloc] init];
                    [parser parseResponseForClientFeeds:returnJsonDict];
                }
                
            }
            else
            {
                [self showErrorAlert];
            }
        }
    }
    else
    {
        //[[NSNotificationCenter defaultCenter]postNotificationName:@"hideHUD" object:nil];
        [self showErrorAlert];
    }
}

//On Connection Fail
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"connection error====%@",[error localizedDescription]);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hideHUD" object:nil];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please check your Internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    if (indexofOperation == 5) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"showContentFromJSONFile" object:nil];
    }
}

-(void)showErrorAlert
{
     [[NSNotificationCenter defaultCenter]postNotificationName:@"hideHUD" object:nil];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to process your request\nPlease try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

//Delimite String Method
-(NSString*)stringBetweenString:(NSString*)start andString:(NSString*)end {
    
    NSScanner* scanner = [NSScanner scannerWithString:returnString];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];
    if ([scanner scanString:start intoString:NULL]) {
        NSString* result = nil;
        if ([scanner scanUpToString:end intoString:&result]) {
            return result;
        }
    }
    
    return nil;
}

#pragma mark - write To JSON FILE
/*Json will be saved as feeds.json object file App Document Directory, to show in Feeds List if Internet Connection not available at any point of time
*/
-(void) writeToJSONFile : (NSData *)jsonData
{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/feeds.json",
                          documentsDirectory];
    
    [jsonData writeToFile:fileName atomically:YES];
    
}


@end
