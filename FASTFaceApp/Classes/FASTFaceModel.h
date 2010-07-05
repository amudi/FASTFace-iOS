//
//  FASTFaceModel.h
//  FASTFace
//
//  Created by Amudi Sebastian on 7/4/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FASTFaceRecognizer.h"

@interface FASTFaceModel : NSObject {
  @private
	FaceTemplate *ft;
	CGImageRef photo1;
	CGImageRef photo2;
}

@property (nonatomic, assign) FaceTemplate *faceTemplate;
@property (nonatomic, assign) CGImageRef photo1;
@property (nonatomic, assign) CGImageRef photo2;

- (id)initWithFaceTemplatePath:(NSString *)path;
- (CGFloat)getDistanceFrom:(CGImageRef)photoRef to:(CGImageRef)photo;
- (CGFloat)getDistance;

@end
