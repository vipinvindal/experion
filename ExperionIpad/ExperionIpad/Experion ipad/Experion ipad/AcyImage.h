//
//  AcyImage.h
//  Collage
//
//  Created by Ranjeet on 8/13/13.
//  Copyright (c) 2013 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcyImage : UIView{
    
    UIImageView *thumbnailImage;
    NSURLConnection *lazyUplaodImageConn;
    NSMutableData *imageData;
    NSString *imagePath;
}

-(void)loadimage:(NSString *)localImagePath :(NSString *)serverUrl;
-(id)initWithFrame:(CGRect)frame :(NSString *)imageName;
-(void)cancelImageLoad;
@end
