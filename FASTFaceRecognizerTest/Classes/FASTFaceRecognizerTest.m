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
	uiImage = [UIImage imageNamed:@"test_image.png"];
	[uiImage retain];
	
	imageRef = [uiImage CGImage];
	CGImageRetain(imageRef);
	
	//FaceTemplateInit(ft);
	//FaceRecognizerInit(fr, imageRef, ft);
}

- (void)testAllocation {
	STAssertNotNil(uiImage, @"UIImage allocation failed");
}

- (void)testAllocationFaceTemplate {

}

- (void)testAllocationFaceRecognizer {
}

- (void)tearDown {
	[uiImage release];
	CGImageRelease(imageRef);
}

@end
