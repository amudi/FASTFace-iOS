//
//  FASTFaceModel.m
//  FASTFace
//
//  Created by Amudi Sebastian on 7/4/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "FASTFaceModel.h"


@implementation FASTFaceModel

@synthesize faceTemplate = ft;
@synthesize photo1;
@synthesize photo2;

- (id)init {
	if ((self = [super init])) {
		//NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		ft = FaceTemplateCreate();
	}
	return self;
}

- (id)initWithFaceTemplatePath:(NSString *)path {
	if ([self init]) {
		FaceTemplateLoadResource(ft, [path cStringUsingEncoding:NSUTF8StringEncoding]);
	}
	return self;
}

- (void)dealloc {
	FaceTemplateDealloc(ft);
	[super dealloc];
}

- (CGFloat)getDistanceFrom:(CGImageRef)photoRef to:(CGImageRef)photo; {
	// if one of the 
	DLog(@"calculating distance of photoRef = %d to photo = %d", photoRef, photo);
	if (!photoRef || !photo) {
		DLog(@"one of the photo is nil");
		return -1.0f;
	}
	
	// if images are equal
	if (photoRef == photo) {
		DLog(@"photos are equal");
		return 0.0f;
	}
	
	CGFloat result = 0.0f;
	
	FaceRecognizer *fr1 = FaceRecognizerCreate(photoRef, ft);
	FaceRecognizer *fr2 = FaceRecognizerCreate(photo, ft);
	result = FaceRecognizerGetDistance(fr1, fr2);
	
	FaceRecognizerDealloc(fr1);
	FaceRecognizerDealloc(fr2);
	
	return result;
}

- (CGFloat)getDistance {
	return [self getDistanceFrom:photo1 to:photo1];
}

@end
