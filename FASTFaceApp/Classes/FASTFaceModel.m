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
@synthesize fd;

- (id)init {
	if ((self = [super init])) {
		ft = FaceTemplateCreate();
		result = -1.0f;
		isPhoto1Preprocessed = NO;
		isPhoto1Preprocessed = NO;
	}
	return self;
}

- (id)initWithFaceTemplatePath:(NSString *)path {
	if ((self = [self init])) {
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
	FaceDistanceDealloc(fd);
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
	if (self.fd) {
		FaceDistanceDealloc(self.fd);
		self.fd = nil;
	}
}

- (void)generateThumbnails {
	if (photo1 && !thumbnail1) {
		self.thumbnail1 = nil;
		UIImage *tmpImage = [[UIImage alloc] initWithCGImage:[self.photo1 CGImage]];
		UIImage *tmpImageResized = [tmpImage resizedImage:CGSizeMake(kThumbnailSize, kThumbnailSize) interpolationQuality:kCGInterpolationHigh];
		self.thumbnail1 = [tmpImageResized thumbnailImage:kThumbnailSize transparentBorder:1 cornerRadius:kThumbnailRadius interpolationQuality:kCGInterpolationHigh];
		[tmpImage release];
	}
	if (photo2 && !thumbnail2) {
		self.thumbnail2 = nil;
		UIImage *tmpImage = [[UIImage alloc] initWithCGImage:[self.photo2 CGImage]];
		UIImage *tmpImageResized = [tmpImage resizedImage:CGSizeMake(kThumbnailSize, kThumbnailSize) interpolationQuality:kCGInterpolationHigh];
		self.thumbnail2 = [tmpImageResized thumbnailImage:kThumbnailSize transparentBorder:1 cornerRadius:kThumbnailRadius interpolationQuality:kCGInterpolationHigh];
		[tmpImage release];
	}
}

- (void)preprocessPhoto1 {
	self.prepPhoto1 = nil;
	
	DLog(@"converting photo1 to grayscale");
	UIImage *grayscalePhoto1 = [self.photo1 convertToGrayscale];
	DLog(@"resizing photo1");
	UIImage *resizedPhoto1 = [grayscalePhoto1 resizedImage:CGSizeMake(80.0f, 60.0f) interpolationQuality:kCGInterpolationHigh]; 
	self.prepPhoto1 = resizedPhoto1;
	isPhoto1Preprocessed = YES;
}

- (void)preprocessPhoto2 {
	self.prepPhoto2 = nil;
	
	DLog(@"converting photo2 to grayscale");
	UIImage *grayscalePhoto2 = [photo2 convertToGrayscale];
	DLog(@"resizing photo2");
	UIImage *resizedPhoto2 = [grayscalePhoto2 resizedImage:CGSizeMake(80.0f, 60.0f) interpolationQuality:kCGInterpolationHigh]; 
	self.prepPhoto2 = resizedPhoto2;
	isPhoto2Preprocessed = YES;
}

- (void)calculateDistanceFrom:(UIImage *)photoRef to:(UIImage *)photo; {
	// if one of the 
	DLog(@"calculating distance of photoRef = %d to photo = %d", photoRef, photo);
	if (!photoRef || !photo) {
		DLog(@"one of the photo is nil");
		self.result = -1;
		return;
	}
	
	if (!isPhoto1Preprocessed || !isPhoto2Preprocessed) {
		DLog(@"one of the photo is not preprocessed yet");
		self.result = -1;
		return;
	}
	
	// if images are equal
	if ([photoRef isEqual:photo]) {
		DLog(@"photos are equal");
		self.result = 0;
		return;
	}
	
	// create FaceRecognizer object
	FaceRecognizer *fr1 = FaceRecognizerCreate([self.prepPhoto1 CGImage], ft);
	FaceRecognizer *fr2 = FaceRecognizerCreate([self.prepPhoto2 CGImage], ft);
	
	self.result = FaceRecognizerGetDistance(fr1, fr2);
	fd = FaceDistanceCreate(self.result);
	DLog(@"result = %d", self.result);
	
	FaceRecognizerDealloc(fr1);
	FaceRecognizerDealloc(fr2);
	
	return;
}

- (void)calculateDistance {
	[self calculateDistanceFrom:self.photo1 to:self.photo2];
}

@end
