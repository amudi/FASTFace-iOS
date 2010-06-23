//
//  FASTFaceRecognizerTest.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/21/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "FASTFaceRecognizerTest.h"
#import "FASTFaceRecognizer.h"


@implementation FASTFaceRecognizerTest

- (void)setUp {
	fastFaceRecognizer = [[FASTFaceRecognizer alloc] init];
}

- (void)testAllocation {
	STAssertNotNil(fastFaceRecognizer, @"Failed allocation");
}

- (void)testAllocationFaceTemplate {
	FaceTemplate *ft = [[FaceTemplate alloc] init];
	STAssertNotNil(ft, @"Failed to allocate FaceTemplate");
}

- (void)testAllocationFaceRecognizer {
	FaceTemplate *ft = [[FaceTemplate alloc] init];
	STAssertNotNil(ft, @"Failed to allocate FaceTemplate");
	
	UIImage *image = [UIImage imageNamed:@"test_image.png"];
	//UIImage *image = [[UIImage alloc] init];
	//STAssertNotNil(image, @"Failed to create image");
	
	FaceRecognizer *fr = [[FaceRecognizer alloc] initWithImage:image andFaceTemplate:ft];
	STAssertNotNil(fr, @"Failed to allocate FaceRecognizer");
}

- (void)tearDown {
	[fastFaceRecognizer release];
}

@end
