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
	FaceTemplate *ft;
	CGImageRef photo1;
	CGImageRef photo2;
}

- (CGFloat)getDistanceFromImage:(CGImageRef)image toImage:(CGImageRef)imageRef;

@end
