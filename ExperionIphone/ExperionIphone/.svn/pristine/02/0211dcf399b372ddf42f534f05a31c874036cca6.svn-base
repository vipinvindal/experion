//
//  AcyImage.h
//  Collage
//
//  Created by Ranjeet on 8/13/13.
//  Copyright (c) 2013 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcyImage : UIView{
    UIImageView *thumImage;
    NSURLConnection *lazyUplaodImageConn;
    NSMutableData *imageData;
    NSString *imagePath;
}
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
//@property (nonatomic, retain) UILabel *imageLoadingLabel;

-(void)loadimage:(NSString *)localImagePath :(NSString *)serverUrl;
 - (id)initWithFrame:(CGRect)frame :(NSString *)imageName;
-(void)cancelImageLoad;
@end
