//
//  FASTFaceModel.m
//  FASTFace
//
//  Created by Amudi Sebastian on 7/4/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "FASTFaceModel.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"

@implementation FASTFaceModel

@synthesize faceTemplate = ft;
@synthesize photo1;
@synthesize thumbnail1;
@synthesize photo2;
@synthesize thumbnail2;

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
	[photo1 release];
	[photo2 release];
	[thumbnail1 release];
	[thumbnail2 release];
	FaceTemplateDealloc(ft);
	[super dealloc];
}

- (void)generateThumbnails {
	// generate thumbnail
	[thumbnail1 release];
	[thumbnail2 release];
	
	thumbnail1 = [[UIImage alloc] initWithCGImage:[photo1 CGImage]];
	thumbnail2 = [[UIImage alloc] initWithCGImage:[photo2 CGImage]];
	
	thumbnail1 = [thumbnail1 resizedImage:CGSizeMake(kThumbnailSize, kThumbnailSize) interpolationQuality:kCGInterpolationDefault];
	thumbnail1 = [thumbnail1 thumbnailImage:kThumbnailSize transparentBorder:1 cornerRadius:5 interpolationQuality:kCGInterpolationDefault];
	thumbnail2 = [photo2 resizedImageWithContentMode:UIViewContentModeScaleToFill bounds:CGSizeMake(kThumbnailSize, kThumbnailSize) interpolationQuality:kCGInterpolationDefault];
	thumbnail2 = [thumbnail2 thumbnailImage:kThumbnailSize transparentBorder:1 cornerRadius:5 interpolationQuality:kCGInterpolationDefault];
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
	return [self getDistanceFrom:[photo1 CGImage] to:[photo2 CGImage]];
}

@end
