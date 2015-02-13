//
//  ProjectDetails.h
//  Experion
//
//  Created by Sam on 04/12/13.
//  Copyright (c) 2013 Bets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectDetails : NSObject

@property (nonatomic, assign) int projectId;
@property (nonatomic,retain) NSString *longDescription;
@property (nonatomic,retain) NSString *projectFeatures;
@property (nonatomic,retain) NSString *walkthrough;
@property (nonatomic, retain) NSString *locationImageURL;
@property (nonatomic, retain) NSString *locationImageLocalPath;
@property (nonatomic,retain) NSMutableArray *galleryImageURLArr;
@property (nonatomic,retain) NSMutableArray *galleryImageLocalPathArr;


@end
