//
//  AcyImage.m
//  Collage
//
//  Created by Ranjeet on 8/13/13.
//  Copyright (c) 2013 beyond. All rights reserved.
// Lazy Loading Class to download Image Asynchronously

#import "AcyImage.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation AcyImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        thumImage=[[UIImageView alloc]initWithFrame:[self bounds]];
        thumImage.backgroundColor=[UIColor clearColor];
        thumImage.image=[UIImage imageNamed:@"albumIcon.png"];
        [self addSubview:thumImage];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame :(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //NSLog(@"create");
        thumImage=[[UIImageView alloc]initWithFrame:[self bounds]];
        thumImage.backgroundColor=[UIColor clearColor];
        thumImage.image=[UIImage imageNamed:imageName];
        // NSLog(@"call for image");
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:thumImage];
        
    }
    return self;
}

//Method to load Image from Local Path if exists
-(void)loadimage:(NSString *)localImagePath :(NSString *)serverUrl{
    thumImage.backgroundColor=[UIColor clearColor];
    [self addSubview:thumImage];
    // NSURL *url=[[NSURL alloc] initWithString:localImagePath];
    // NSURL *url=localImagePath;
    NSURL *url = [NSURL URLWithString:[localImagePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //NSURL *url = [NSURL URLWithString:localImagePath];
    //[self performSelectorInBackground:@selector(preparePhotosasert:) withObject:url];
    [self imageLoad:url :serverUrl];
    
}

//Method to download Image from Server if not exists in Local App Doc Directory
- (void)imageLoad:(NSURL *)url :(NSString *)serverUrl{
    
    //NSLog(@"server url======%@",serverUrl);
    NSURL *imageURL = [[NSURL alloc] initWithString:serverUrl];
    
    //this is NSData may be what you want
    
    imagePath = [url absoluteString];
    imagePath= [imagePath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *imgdata= [NSData dataWithContentsOfFile:imagePath];
    // NSLog(@"image path======%@",imagePath);
    
    if (imgdata.length>0)   //  IF EXISTS
    {
        //NSLog(@"save image");
        UIImage *thumimage = [UIImage imageWithData:imgdata];
        thumImage.image=thumimage;
        //cell.imageView.image = imagedis;
    }
    else      // NOT EXIST
    {
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:imageURL];
        
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        //_activityIndicator.color = [UIColor colorWithRed:53.0/255.0 green:53.0/255.0 blue:53.0/255.0 alpha:1.0];
        _activityIndicator.color = [UIColor darkTextColor];
        _activityIndicator.alpha = 1.0;
        _activityIndicator.center = thumImage.center;
        _activityIndicator.hidesWhenStopped = NO;
        [thumImage addSubview:_activityIndicator];
        [_activityIndicator startAnimating];
        
//        _imageLoadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(_activityIndicator.frame.origin.x-10,_activityIndicator.frame.origin.y+30, 80, 20)];
//        
//        _imageLoadingLabel.backgroundColor = [UIColor clearColor];
//        _imageLoadingLabel.textColor = [UIColor whiteColor];
//        _imageLoadingLabel.text = @"Loading...";
//        [thumImage addSubview:_imageLoadingLabel];
        
        lazyUplaodImageConn=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
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
    [_activityIndicator stopAnimating];
    [_activityIndicator removeFromSuperview];
    //[_imageLoadingLabel removeFromSuperview];
    
    if (imageData.length>0&&[UIImage imageWithData:imageData]!=nil){
        thumImage.image = [UIImage imageWithData:imageData];
        
        // NSLog(@"suceess====%@",imagePath);
        BOOL success=[imageData writeToFile:imagePath atomically:NO];
        if (success) {
            NSLog(@"success");
            
        }
        else{
            NSLog(@" not success");
        }
        
    }
    [self cancelImageLoad];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self cancelImageLoad];
}

-(void)cancelImageLoad{
    
    [lazyUplaodImageConn cancel];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
