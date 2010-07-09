//
//  FASTFaceModel.m
//  FASTFace
//
//  Created by Amudi Sebastian on 7/4/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "FASTFaceModel.h"
#import "UIImage+Grayscale.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"

@implementation FASTFaceModel

@synthesize faceTemplate = ft;
@synthesize photo1;
@synthesize thumbnail1;
@synthesize prepPhoto1;
@synthesize photo2;
@synthesize thumbnail2;
@synthesize prepPhoto2;
@synthesize result;

- (id)init {
	if ((self = [super init])) {
		//NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		ft = FaceTemplateCreate();
		result = -1.0f;
		isPhoto1Preprocessed = NO;
		isPhoto1Preprocessed = NO;
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
	[prepPhoto1 release];
	[prepPhoto2 release];
	FaceTemplateDealloc(ft);
	[super dealloc];
}

- (void)clear {
	self.photo1 = nil;
	self.photo2 = nil;
	self.thumbnail1 = nil;
	self.thumbnail2 = nil;
	self.prepPhoto1 = nil;
	self.prepPhoto2 = nil;
}

- (void)generateThumbnails {
	if (photo1 && !thumbnail1) {
		[thumbnail1 release];
		UIImage *tmpImage = [[UIImage alloc] initWithCGImage:[photo1 CGImage]];
		UIImage *tmpImageResized = [tmpImage resizedImage:CGSizeMake(kThumbnailSize, kThumbnailSize) interpolationQuality:kCGInterpolationHigh];
		thumbnail1 = [tmpImageResized thumbnailImage:kThumbnailSize transparentBorder:1 cornerRadius:kThumbnailRadius interpolationQuality:kCGInterpolationHigh];
		[tmpImage release];
	}
	if (photo2 && !thumbnail2) {
		[thumbnail2 release];
		UIImage *tmpImage = [[UIImage alloc] initWithCGImage:[photo2 CGImage]];
		UIImage *tmpImageResized = [tmpImage resizedImage:CGSizeMake(kThumbnailSize, kThumbnailSize) interpolationQuality:kCGInterpolationHigh];
		thumbnail2 = [tmpImageResized thumbnailImage:kThumbnailSize transparentBorder:1 cornerRadius:kThumbnailRadius interpolationQuality:kCGInterpolationHigh];
		[tmpImage release];
	}
}

- (void)preprocessPhoto1 {
	[prepPhoto1 release];
	
	DLog(@"converting photo1 to grayscale");
	UIImage *grayscalePhoto1 = [photo1 convertToGrayscale];
	DLog(@"resizing photo1");
	UIImage *resizedPhoto1 = [grayscalePhoto1 resizedImage:CGSizeMake(80.0f, 60.0f) interpolationQuality:kCGInterpolationHigh]; 
	prepPhoto1 = [resizedPhoto1 retain];
	isPhoto1Preprocessed = YES;
}

- (void)preprocessPhoto2 {
	[prepPhoto2 release];
	
	DLog(@"converting photo2 to grayscale");
	UIImage *grayscalePhoto2 = [photo2 convertToGrayscale];
	DLog(@"resizing photo2");
	UIImage *resizedPhoto2 = [grayscalePhoto2 resizedImage:CGSizeMake(80.0f, 60.0f) interpolationQuality:kCGInterpolationHigh]; 
	prepPhoto2 = [resizedPhoto2 retain];
	isPhoto2Preprocessed = YES;
}

- (void)calculateDistanceFrom:(UIImage *)photoRef to:(UIImage *)photo; {
	// if one of the 
	DLog(@"calculating distance of photoRef = %d to photo = %d", photoRef, photo);
	if (!photoRef || !photo) {
		DLog(@"one of the photo is nil");
		result = -1.0f;
		return;
	}
	
	if (!isPhoto1Preprocessed || !isPhoto2Preprocessed) {
		DLog(@"one of the photo is not preprocessed yet");
		return;
	}
	
	// if images are equal
	if ([photoRef isEqual:photo]) {
		DLog(@"photos are equal");
		result = 0.0f;
		return;
	}
	
	// create FaceRecognizer object
	FaceRecognizer *fr1 = FaceRecognizerCreate([prepPhoto1 CGImage], ft);
	FaceRecognizer *fr2 = FaceRecognizerCreate([prepPhoto2 CGImage], ft);
	
	result = FaceRecognizerGetDistance(fr1, fr2);
	DLog(@"result = %f", result);
	
	FaceRecognizerDealloc(fr1);
	FaceRecognizerDealloc(fr2);
	
	return;
}

- (void)calculateDistance {
	[self calculateDistanceFrom:photo1 to:photo2];
}

@end
