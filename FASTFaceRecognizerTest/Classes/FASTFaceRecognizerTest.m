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
}

- (void)testAllocation {
	STAssertNotNil(uiImage, @"UIImage allocation failed");
	STAssertFalse(imageRef == NULL, @"CGImageRef nil");
}

- (void)testAllocationFaceTemplate {
	ft = FaceTemplateCreate();
	STAssertFalse(ft == NULL, @"FaceTemplate allocation failed");
}

- (void)testAllocationFaceRecognizer {
	//ft = FaceTemplateCreate();
	STAssertFalse(ft == NULL, @"FaceTemplate allocation failed");
	//fr = FaceRecognizerCreate(imageRef, ft);
	STAssertFalse(fr == NULL, @"FaceRecognizer allocation failed");
}

- (void)tearDown {
	[uiImage release];
	CGImageRelease(imageRef);
}

@end
