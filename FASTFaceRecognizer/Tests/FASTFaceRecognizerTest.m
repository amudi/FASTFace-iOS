//
//  FASTFaceRecognizerTest.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/21/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "UIImage+Resize.h"
#import "UIImage+Grayscale.h"
#import "FaceTemplate.h"
#import "FaceRecognizer.h"

@interface FASTFaceRecognizerTest : SenTestCase {
	UIImage *uiImage;
	CGImageRef imageRef;
	FaceRecognizer *fr;
	FaceTemplate *ft;
}

- (void)testSetUpAllocation;

- (void)testFaceRecognizerCreate;
- (void)testFaceRecognizerDealloc;
- (void)testFaceRecognizerGetRGBData;

- (void)testFaceTemplateCreate;
- (void)testFaceTemplateDealloc;
- (void)testFaceTemplateLoadResource;

// Issue #24
- (void)testFaceTemplateLoadAndGetDistance;

@end


@implementation FASTFaceRecognizerTest

- (void)setUp {
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSString *path = [bundle pathForResource:@"test_image" ofType:@"png"];
	uiImage = [[UIImage alloc] initWithContentsOfFile:path];
	
	imageRef = [uiImage CGImage];
	CGImageRetain(imageRef);
	ft = FaceTemplateCreate();
	fr = FaceRecognizerCreate(imageRef, ft);
}

- (void)testSetUpAllocation {
	STAssertNotNil(uiImage, @"UIImage allocation failed");
	STAssertFalse(imageRef == NULL, @"CGImageRef nil");
}

- (void)testFaceRecognizerCreate {
	STAssertFalse(fr == NULL, @"FaceRecognizer allocation failed");
}

- (void)testFaceRecognizerDealloc {
	FaceRecognizerDealloc(fr);
	fr = NULL;
	STAssertTrue(fr == NULL, @"FaceRecognizer deallocation failed, fr = %d", fr);
}

- (void)testFaceRecognizerGetRGBData {
	uint32_t rgbData[((int)(fr->imageSize.width + 1)) * ((int)fr->imageSize.height)];
	FaceRecognizerGetRGBDataFromImage(fr, rgbData, imageRef);
	STAssertFalse(rgbData == NULL, @"Get RGB data failed, rgbData = %@", rgbData);
	
	uint32_t arrayOfZeros[((int)(fr->imageSize.width + 1)) * ((int)fr->imageSize.height)];
	memset(arrayOfZeros, 0, ((int)(fr->imageSize.width + 1)) * ((int)fr->imageSize.height));
	STAssertFalse(rgbData == arrayOfZeros, @"Get RGB data returns all zeros");
}

- (void)testFaceTemplateCreate {
	STAssertFalse(ft == NULL, @"FaceTemplate allocation failed");
}

- (void)testFaceTemplateDealloc {
	FaceTemplateDealloc(ft);
	ft = NULL;
	STAssertTrue(ft == NULL, @"FaceTemplate deallocation failed, ft = %d", ft);
}

- (void)testFaceTemplateLoadResource {
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSString *pathString = [bundle pathForResource:@"face_template" ofType:@"txt"];
	const char *path = [pathString cStringUsingEncoding:NSUTF8StringEncoding];
	STAssertTrue(sizeof(path) > 0, @"can't get face_template.txt path, path = %s", path);
	
	FaceTemplateLoadResource(ft, path);
	STAssertTrue(sizeof(ft->pixelInfo) > 0, @"load resource failed, sizeof(ft->pixelInfo) = %d", sizeof(ft->pixelInfo));
	STAssertTrue(ft->areaSize.width > 0, @"load resource resulted in a 0 width, areaSize.width = %d", (int)ft->areaSize.width);
	STAssertTrue(ft->areaSize.height > 0, @"load resource resulted in a 0 height, areaSize.height = %d", (int)ft->areaSize.height);
}

// Issue #24
- (void)testFaceTemplateLoadAndGetDistance {
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	
	NSString *templatePathString = [bundle pathForResource:@"face_template" ofType:@"txt"];
	const char *templatePath = [templatePathString cStringUsingEncoding:NSUTF8StringEncoding];
	FaceTemplateLoadResource(ft, templatePath);
	
	NSString *photo1Path = [bundle pathForResource:@"photo1" ofType:@"jpg"];
	UIImage *photo1 = [[UIImage alloc] initWithContentsOfFile:photo1Path];
	UIImage *photo1Grayscale = [photo1 convertToGrayscale];
	UIImage *photo1Resized = [photo1Grayscale resizedImage:CGSizeMake(80.0f, 60.0f) interpolationQuality:kCGInterpolationHigh]; 
	CGImageRef photo1CGImage = [photo1Resized CGImage];
	FaceRecognizer *fr1 = FaceRecognizerCreate(photo1CGImage, ft);
	
	NSString *photo2Path = [bundle pathForResource:@"photo2" ofType:@"jpg"];
	UIImage *photo2 = [[UIImage alloc] initWithContentsOfFile:photo2Path];
	UIImage *photo2Grayscale = [photo2 convertToGrayscale];
	UIImage *photo2Resized = [photo2Grayscale resizedImage:CGSizeMake(80.0f, 60.0f) interpolationQuality:kCGInterpolationHigh]; 
	CGImageRef photo2CGImage = [photo2Resized CGImage];
	FaceRecognizer *fr2 = FaceRecognizerCreate(photo2CGImage, ft);
	
	long distance = -1;
	distance = FaceRecognizerGetDistance(fr1, fr2);
	STAssertTrue(distance != 1, @"failed to get distance, distance = %d", distance);
	STAssertTrue(distance != 0, @"failed to get distance, distance = %d", distance);
	STAssertTrue(distance < LONG_MAX, @"failed to get distance, distance = %d", distance);
	STAssertTrue(distance > LONG_MIN, @"failed to get distance, distance = %d", distance);
	
	FaceRecognizerDealloc(fr1);
	FaceRecognizerDealloc(fr2);
	[photo1 release];
	[photo2 release];
}

- (void)tearDown {
	FaceTemplateDealloc(ft);
	FaceRecognizerDealloc(fr);
	[uiImage release];
	CGImageRelease(imageRef);
}

@end
