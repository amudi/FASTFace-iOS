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
#define kRetinaDisplayThumbnailSize 300

@interface FASTFaceModel : NSObject {
  @private
	FaceTemplate *ft;
	UIImage *photo1;
	UIImage *thumbnail1;
	UIImage *photo2;
	UIImage *thumbnail2;
}

@property (nonatomic, assign) FaceTemplate *faceTemplate;
@property (nonatomic, retain) UIImage *photo1;
@property (nonatomic, retain) UIImage *thumbnail1;
@property (nonatomic, retain) UIImage *photo2;
@property (nonatomic, retain) UIImage *thumbnail2;

- (id)initWithFaceTemplatePath:(NSString *)path;
- (void)generateThumbnails;
- (CGFloat)getDistanceFrom:(CGImageRef)photoRef to:(CGImageRef)photo;
- (CGFloat)getDistance;

@end
