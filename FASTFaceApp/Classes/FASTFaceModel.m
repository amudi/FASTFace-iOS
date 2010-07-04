//
//  FASTFaceModel.m
//  FASTFace
//
//  Created by Amudi Sebastian on 7/4/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "FASTFaceModel.h"


@implementation FASTFaceModel

- (id)init {
	if ((self = [super init])) {
		//NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		ft = FaceTemplateCreate();
	}
	return self;
}

- (void)dealloc {
	FaceTemplateDealloc(ft);
	[super dealloc];
}

- (CGFloat)getDistanceFromImage:(CGImageRef)image toImage:(CGImageRef)imageRef {
	CGFloat result = 0.0f;
	
	FaceRecognizer *fr1 = FaceRecognizerCreate(image, ft);
	FaceRecognizer *fr2 = FaceRecognizerCreate(imageRef, ft);
	result = FaceRecognizerGetDistance(fr1, fr2);
	
	FaceRecognizerDealloc(fr1);
	FaceRecognizerDealloc(fr2);
	
	return result;
}

@end
