//
//  AcyImage.m
//  Collage
//
//  Created by Ranjeet on 8/13/13.
//  Copyright (c) 2013 beyond. All rights reserved.
/*download Image and save into local file for chache*/

#import "AcyImage.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation AcyImage


- (id)initWithFrame:(CGRect)frame :(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
        [self setBackgroundColor:[UIColor clearColor]];
        
        thumbnailImage=[[UIImageView alloc]initWithFrame:[self bounds]];
        thumbnailImage.backgroundColor=[UIColor clearColor];
        thumbnailImage.image=[UIImage imageNamed:imageName];//place holdder set on thumnailimage
        
        [self addSubview:thumbnailImage];
        
    }
    return self;
}


//cache image local path convert into url and call method for download Image


-(void)loadimage:(NSString *)localImagePath :(NSString *)serverUrl{
    
    [self addSubview:thumbnailImage];
    NSURL *url = [NSURL URLWithString:[localImagePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];// localImagePath convert in url
    [self imageLoad:url :serverUrl];
    
}

//this Method first check image is available in local file if available then show thumnail image otherwise download image from server
- (void)imageLoad:(NSURL *)url :(NSString *)serverUrl{
    
   
    NSURL *imageURL = [[NSURL alloc] initWithString:serverUrl];
    
    imagePath = [url absoluteString];
    imagePath= [imagePath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *imgdata= [NSData dataWithContentsOfFile:imagePath];
   
    if (imgdata.length>0) //check image is save or not in file
    {
       
        UIImage *thumimage = [UIImage imageWithData:imgdata];
        thumbnailImage.image=thumimage;
       
    }
    else{
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:imageURL];
        lazyUplaodImageConn=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];// connection for  image Download
        
    }

    
}


#pragma mark- Connection DelegatesMethod

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
    imageData = [[NSMutableData alloc] init];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if (imageData.length>0&&[UIImage imageWithData:imageData]!=nil){
        
        thumbnailImage.image = [UIImage imageWithData:imageData];
        
        BOOL success=[imageData writeToFile:imagePath atomically:NO];//image save in local file for cache
               
    }
    
    [self cancelImageLoad];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self cancelImageLoad];
}

-(void)cancelImageLoad{ //cancel server connection 
    
    [lazyUplaodImageConn cancel];
    
}


@end
