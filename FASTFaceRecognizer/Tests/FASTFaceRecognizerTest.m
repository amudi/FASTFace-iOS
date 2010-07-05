//
//  FASTFaceRecognizerTest.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/21/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
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
	int rgbData[((int)(fr->imageSize.width + 1)) * ((int)fr->imageSize.height)];
	FaceRecognizerGetRGBDataFromImage(fr, rgbData, imageRef);
	STAssertFalse(rgbData == NULL, @"Get RGB data failed, rgbData = %@", rgbData);
	
	int arrayOfZeros[((int)(fr->imageSize.width + 1)) * ((int)fr->imageSize.height)];
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

- (void)tearDown {
	FaceTemplateDealloc(ft);
	FaceRecognizerDealloc(fr);
	[uiImage release];
	CGImageRelease(imageRef);
}

@end
