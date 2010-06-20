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

- (void)tearDown {
	[fastFaceRecognizer release];
}

@end
