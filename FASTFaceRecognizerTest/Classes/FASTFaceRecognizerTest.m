//
//  FASTFaceRecognizerTest.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/21/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "FASTFaceRecognizerTest.h"


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

- (void)testFaceTemplateCreate {
	STAssertFalse(ft == NULL, @"FaceTemplate allocation failed");
}

- (void)testFaceRecognizerCreate {
	STAssertFalse(fr == NULL, @"FaceRecognizer allocation failed");
}

- (void)testFaceTemplateDealloc {
	FaceTemplateDealloc(ft);
	ft = NULL;
	STAssertTrue(ft == NULL, @"FaceTemplate deallocation failed, ft = %d", ft);
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

- (void)tearDown {
	FaceTemplateDealloc(ft);
	FaceRecognizerDealloc(fr);
	[uiImage release];
	CGImageRelease(imageRef);
}

@end
