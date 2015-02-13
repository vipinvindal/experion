//
//  GenricParser.m
//  Experion
//
//  Created by ALOK NATH KHANNA on 21/11/2013.
//  Copyright (c) 2013 Bets. All rights reserved.
// Generic Parser Class for all type object

#import "GenricParser.h"
#import "userDetails.h"
#import "MyProfileViewController.h"
#import "Base64.h"
#import "UserDetailsViewController.h"

@implementation GenricParser

-(void)parseResponseFromUserAuthenticationRequest :(NSDictionary*)jsonDictonary
{
    
    // NSDictionary *jsonDictonary = [jsonArray objectAtIndex:i];
    
    NSNumber *isAuthenticated = [jsonDictonary objectForKey:@"IsAuthenticated"];
    NSString *isAuthentication =  [isAuthenticated stringValue];
    
    if ([isAuthentication isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"authentication"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"authentication"];
    }
    
    NSString *name = [jsonDictonary objectForKey:@"FullName"];
    
    if ([name isKindOfClass:[NSNull class]]) {
        name = @"Client Name";
    }
    
    NSString *message = [jsonDictonary objectForKey:@"Message"];
    NSString *userSpecificData = [jsonDictonary objectForKey:@"UserSpecificData"];
    NSString *userToken = [jsonDictonary objectForKey:@"UserToken"];
    
    NSLog(@"Username ====>%@ \nIsAuthenticated =====>%@ \nUserSpecificData =====>%@ \nUserToken ======>%@ \nMessage =====>%@",name,isAuthenticated,userSpecificData,userToken,message);
    
    if (![userToken isKindOfClass:[NSNull class]] && userToken) {
        [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:@"userTokenId"];
        
        //Action on Success
        [[NSNotificationCenter defaultCenter]postNotificationName:@"successAuthentication" object:nil];
    }
    else
    {
        //to Hide Head Up Display
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hideHUD" object:nil];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"An error occurred\nPlease try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    ///////////////////////
    /*
     NSString *jsonString = [jsonDictonary objectForKey:@"CompanyLogo"];
     
     [Base64 initialize];
     NSData* data = [Base64 decode:jsonString];
     //image.image = [UIImage imageWithData:data];
     
     UserDetailsViewController *myPrVC = [[UserDetailsViewController alloc]init];
     [myPrVC testMethod:data];
     
     ////////////////////////
     
     NSString *jsonString = [jsonDictonary objectForKey:@"CompanyLogo"];
     
     NSString *encodedStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)jsonString, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
     
     NSData* imgData = [encodedStr dataUsingEncoding:NSUTF8StringEncoding];
     
     
     MyProfileViewController *myPrVC = [[MyProfileViewController alloc]init];
     [myPrVC testMethod:imgData];
     */
    
    //    NSArray *strings = [NSJSONSerialization JSONObjectWithData:jsonString options:kNilOptions error:NULL];
    //
    //    unsigned c = strings.count;
    //    uint8_t *bytes = malloc(sizeof(*bytes) * c);
    //
    //    unsigned i;
    //    for (i = 0; i < c; i++)
    //    {
    //        NSString *str = [strings objectAtIndex:i];
    //        int byte = [str intValue];
    //        bytes[i] = byte;
    //    }
    
    
    //    NSData *imageData = [NSData dataWithBytesNoCopy:bytes length:c freeWhenDone:YES];
    //    UIImage *image = [UIImage imageWithData:imageData];
}

-(void)parseResponseFromFetchinghUserCustomerDataRequest :(NSArray*)jsonArray
{
    //_customerLedgerArr will contain Array of customerLegderDict for the purpose if Customer has more than one properties associated with the same Account
    _customerLedgerArr = [[NSMutableArray alloc]init];
    
    int count = [jsonArray count];
    
    for (int i = 0; i<count; i++)
    {
        //customerLegderDict will contain all needed KEY-VALUE pairs associated with Customer Ledger
        NSMutableDictionary *customerLegderDict = [[NSMutableDictionary alloc]init];
        
        NSDictionary *jsonDictonary = [jsonArray objectAtIndex:i];
        // userDetails *detailsOfUser = [[userDetails alloc]init];
        
        
        ////////////////////CUSTOMER DETAILS///////////////////////
        
        NSString *applicantNameStr = [jsonDictonary objectForKey:@"APPLICANT"];
        // NSLog(@"Applicant Name===>%@",applicantNameStr);
        
        if (![applicantNameStr isKindOfClass:[NSNull class]])
        {
            [customerLegderDict setObject:applicantNameStr forKey:@"customerName"];
        }
        else
        {
            applicantNameStr = @"Client Name";
        }
        
        
        NSString *projectNameStr = [jsonDictonary objectForKey:@"PRJNAME"];
        // NSLog(@"Project Name ===> %@",projectNameStr);
        
        if (![projectNameStr isKindOfClass:[NSNull class]])
        {
            [customerLegderDict setObject:projectNameStr forKey:@"projectName"];
        }
        else
        {
            projectNameStr = @"";
        }
        
        
        NSString *subBlockStr = [jsonDictonary objectForKey:@"SUBBLOCK"];
        // NSLog(@"Subblock ===> %@",subBlockStr);
        
        if (![subBlockStr isKindOfClass:[NSNull class]])
        {
            [customerLegderDict setObject:subBlockStr forKey:@"subBlock"];
        }
        else
        {
            subBlockStr = @"";
        }
        
        
        NSString *unitNumberStr = [jsonDictonary objectForKey:@"UNITNO"];
        //  NSLog(@"Unit Number===>%@",unitNumberStr);
        
        if (![unitNumberStr isKindOfClass:[NSNull class]])
        {
            [customerLegderDict setObject:unitNumberStr forKey:@"unitNumber"];
        }
        else
        {
            unitNumberStr = @"";
        }
        
        
        NSNumber *superBuiltUp = [jsonDictonary objectForKey:@"SUPERBUILTUP"];
        NSString *superBuiltUpStr = [NSString stringWithFormat:@"%@",superBuiltUp];
        //  NSLog(@"Super BuiltUp===>%@",superBuiltUpStr);
        
        if (![superBuiltUpStr isKindOfClass:[NSNull class]])
        {
            [customerLegderDict setObject:superBuiltUpStr forKey:@"superBuiltUp"];
        }
        else
        {
            superBuiltUpStr = @"";
        }
        
        
        
        ////////////////////CUSTOMER LEDGER///////////////////////
        
        NSNumber *totalCost = [jsonDictonary objectForKey:@"TotalCost"];
        NSString *totalCostStr = [self convertNumberToCurrencyAmtStr:totalCost];
        //[NSString stringWithFormat:@"%@",totalCost];
        //  NSLog(@"Total Cost===>%@",totalCostStr);
        
        if (![totalCostStr isKindOfClass:[NSNull class]])
        {
            [customerLegderDict setObject:totalCostStr forKey:@"totalCost"];
        }
        else
        {
            totalCostStr = @"0";
        }
        
        NSNumber *dueTillDate = [jsonDictonary objectForKey:@"DUETILLDT"];
        NSString *dueTillDateStr = [self convertNumberToCurrencyAmtStr:dueTillDate];
        //[NSString stringWithFormat:@"%@",dueTillDate];
        //  NSLog(@"Due Till Date===>%@",dueTillDateStr);
        
        if (![dueTillDateStr isKindOfClass:[NSNull class]])
        {
            [customerLegderDict setObject:dueTillDateStr forKey:@"interestRaised"];
        }
        else
        {
            dueTillDateStr = @"0";
        }
        
        NSNumber *receivedTillDate = [jsonDictonary objectForKey:@"RECDTILLDT"];
        NSString *receivedTillDateStr = [self convertNumberToCurrencyAmtStr:receivedTillDate];
        //[NSString stringWithFormat:@"%@",receivedTillDate];
        
        //  NSLog(@"Received Till Date===>%@",receivedTillDateStr);
        
        if (![receivedTillDateStr isKindOfClass:[NSNull class]])
        {
            [customerLegderDict setObject:receivedTillDateStr forKey:@"interestPaid"];
        }
        else
        {
            receivedTillDateStr = @"0";
        }
        
        NSNumber *outstandingNet = [jsonDictonary objectForKey:@"NETOUTSTANDING"];
        NSString *netOutStanding = [self convertNumberToCurrencyAmtStr:outstandingNet];
        //[NSString stringWithFormat:@"%@",outstandingNet];
        // NSLog(@"Total Outstanding===>%@",netOutStanding);
        
        
        if (![netOutStanding isKindOfClass:[NSNull class]])
        {
            [customerLegderDict setObject:netOutStanding forKey:@"totalOutstanding"];
        }
        else
        {
            netOutStanding = @"0";
        }
        
        NSNumber *intBalance = [jsonDictonary objectForKey:@"INTBALANCE"];
        NSString *intBalanceStr = [self convertNumberToCurrencyAmtStr:intBalance];
        //[NSString stringWithFormat:@"%@",intBalance];
        //  NSLog(@"Interest Balance===>%@",intBalanceStr);
        
        if (![intBalanceStr isKindOfClass:[NSNull class]])
        {
            [customerLegderDict setObject:intBalanceStr forKey:@"interestPending"];
        }
        else
        {
            intBalanceStr = @"0";
        }
        
        
        [_customerLedgerArr addObject:customerLegderDict];
        
    }
    
    NSMutableDictionary *dictionaryToSend = [[NSMutableDictionary alloc]init];
    
    [dictionaryToSend setObject:_customerLedgerArr forKey:@"customerLegderArr"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"successDataFetch" object:nil userInfo:dictionaryToSend];
    
}

//Method to Parse where Updated/Deleted/Added project is received in response
-(void) parseResponseForProjectList:(NSDictionary *)jsonDict
{
    
    NSString *responseCode =[NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"responseCode"]];
    
    //400 - project found
    
    NSMutableDictionary *projectsFromServerDict = [[NSMutableDictionary alloc]init];
    
    if ([responseCode isEqualToString:@"400"]) {
        
        NSMutableArray *deletedProjectArrOfDict = [jsonDict objectForKey:@"deletedProject"];
        NSMutableArray *addedUpdatedProjectArrOfDict = [jsonDict objectForKey:@"project"];
        
        /*
         NSMutableArray *deletedProjectArr = [[NSMutableArray alloc]init];
         
         for (int i = 0; i<deletedProjectArrDict.count; i++)
         {
         [deletedProjectArr addObject:[[deletedProjectArrDict objectAtIndex:i]objectForKey:@"deletedProject"]];
         }
         
         
         
         NSMutableArray *addedUpdatedProjectArr = [[NSMutableArray alloc]init];
         
         for (int i=0; i<addedUpdatedProjectArrDict.count; i++)
         {
         [addedUpdatedProjectArr addObject:[[addedUpdatedProjectArrDict objectAtIndex:i]objectForKey:@"projectId"]];
         }
         */
        
        // if (deletedProjectArrDict.count>0) {
        [projectsFromServerDict setObject:deletedProjectArrOfDict forKey:@"deletedProjectArrOfDict"];
        // }
        
        // if (addedUpdatedProjectArrDict.count>0) {
        [projectsFromServerDict setObject:addedUpdatedProjectArrOfDict forKey:@"addedUpdatedProjectArrOfDict"];
        //  }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateProjectListTable" object:nil userInfo:projectsFromServerDict];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hideHUD" object:nil];
        
        // save last updated date in Persistence if there are any changes in Projects
        NSDate* date =[NSDate date];
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"mostRecentMentionDate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else if ([responseCode isEqualToString:@"104"])
    {
        //save last updated date in Persistence if there aren't any changes in Project
        NSDate* date =[NSDate date];
        
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"mostRecentMentionDate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hideHUD" object:nil];
    }
    else
    {
        //No Updates in Project - Hide Head Up Display
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hideHUD" object:nil];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to process your request\n Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    
}

-(void) parseResponseForProjectDetails:(NSDictionary *)jsonDict
{
    
    NSString *responseCode =[NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"responseCode"]];
    
    //400 - project found
    
    if ([responseCode isEqualToString:@"400"]) {
        
        // NSMutableDictionary *currentProjectDetailsDict = [jsonDict objectForKey:@"project"];
        
        /*
         NSMutableArray *deletedProjectArr = [[NSMutableArray alloc]init];
         
         for (int i = 0; i<deletedProjectArrDict.count; i++)
         {
         [deletedProjectArr addObject:[[deletedProjectArrDict objectAtIndex:i]objectForKey:@"deletedProject"]];
         }
         
         
         
         NSMutableArray *addedUpdatedProjectArr = [[NSMutableArray alloc]init];
         
         for (int i=0; i<addedUpdatedProjectArrDict.count; i++)
         {
         [addedUpdatedProjectArr addObject:[[addedUpdatedProjectArrDict objectAtIndex:i]objectForKey:@"projectId"]];
         }
         */
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateProjectDataTable" object:nil userInfo:jsonDict];
    }
    else // NO Update found in Project Description - Hide HUD
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hideHUD" object:nil];
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to process your request\n Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
    }
}

// Response - Feeds always updated from server if there is internet connection
-(void) parseResponseForClientFeeds:(NSDictionary *)jsonDict
{
    
    NSString *responseCode =[NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"responseCode"]];
    
    //400 - project found
    
    if ([responseCode isEqualToString:@"400"]) {
        
        NSMutableDictionary *clientFeedsDict = [[NSMutableDictionary alloc]init];
        [clientFeedsDict setObject:[jsonDict objectForKey:@"feed"] forKey:@"feedsData"];
        
        /*
         NSMutableArray *deletedProjectArr = [[NSMutableArray alloc]init];
         
         for (int i = 0; i<deletedProjectArrDict.count; i++)
         {
         [deletedProjectArr addObject:[[deletedProjectArrDict objectAtIndex:i]objectForKey:@"deletedProject"]];
         }
         
         
         
         NSMutableArray *addedUpdatedProjectArr = [[NSMutableArray alloc]init];
         
         for (int i=0; i<addedUpdatedProjectArrDict.count; i++)
         {
         [addedUpdatedProjectArr addObject:[[addedUpdatedProjectArrDict objectAtIndex:i]objectForKey:@"projectId"]];
         }
         */
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"showDataInTable" object:nil userInfo:clientFeedsDict];
    }
    else if ([responseCode isEqualToString:@"104"]) // NO FEEDS FOUND - Remove all existing
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"removeAllFeeds" object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hideHUD" object:nil];
        //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to process your request\n Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
    }
}

// Rupee Sign is needed before Amount, setting locale Indentifier as en_In
-(NSString *)convertNumberToCurrencyAmtStr : (NSNumber *)number
{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    //[currencyFormatter setCurrencySymbol:@""];
    [currencyFormatter setMaximumFractionDigits:0];
    [currencyFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_IN"]];
   // NSLog(@"Final Value :: %@", [currencyFormatter stringFromNumber:[NSNumber numberWithFloat:15544512.33]]);
    NSString *formattedCurrencyStr = [currencyFormatter stringFromNumber:number];

    return formattedCurrencyStr;
}

@end
