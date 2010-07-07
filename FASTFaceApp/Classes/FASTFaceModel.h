//
//  FASTFaceModel.h
//  FASTFace
//
//  Created by Amudi Sebastian on 7/4/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FASTFaceRecognizer.h"

#define kThumbnailSize 150
#define kThumbnailSizeRetinaDisplay 300
#define kThumbnailRadius 10
#define kThumbnailRadiusRetinaDisplay 20

@interface FASTFaceModel : NSObject {
  @private
	FaceTemplate *ft;
	UIImage *photo1;
	UIImage *thumbnail1;
	UIImage *prepPhoto1;
	UIImage *photo2;
	UIImage *thumbnail2;
	UIImage *prepPhoto2;
	CGFloat result;
	BOOL isPhoto1Preprocessed;
	BOOL isPhoto2Preprocessed;
}

@property (nonatomic, assign) FaceTemplate *faceTemplate;
@property (nonatomic, retain) UIImage *photo1;
@property (nonatomic, retain) UIImage *thumbnail1;
@property (nonatomic, retain) UIImage *photo2;
@property (nonatomic, retain) UIImage *thumbnail2;
@property (nonatomic, assign) CGFloat result;

- (id)initWithFaceTemplatePath:(NSString *)path;
- (void)clear;
- (void)generateThumbnails;
- (void)preprocessPhoto1;
- (void)preprocessPhoto2;
- (void)calculateDistanceFrom:(UIImage *)photoRef to:(UIImage *)photo;
- (void)calculateDistance;

@end
