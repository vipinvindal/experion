 //
//  HttpConnection.m
//  Experion
//
//  Created by ALOK NATH KHANNA on 21/11/2013.
//  Copyright (c) 2013 Bets. All rights reserved.
// Singleton Class for HTTP Connection

#import "HttpConnection.h"
static NSURLConnection *singeltonConnection = nil;
@implementation HttpConnection


+ (NSURLConnection *)sharedSingleton
{
    @synchronized([HttpConnection class])
    {
        
        if ( !singeltonConnection || singeltonConnection ==nil )
        {
            // allocate the shared instance, because it hasn't been done yet
            singeltonConnection = [[NSURLConnection alloc] init];
        }
    }
    
    return singeltonConnection;
    
}


@end
