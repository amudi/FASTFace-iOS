//
//  FASTFaceRecognizerTest.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/21/10.
//  Copyright 2010 amudi.org. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

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
- (void)testFaceTemplateCreate;
- (void)testFaceRecognizerCreate;
- (void)testFaceTemplateDealloc;
- (void)testFaceRecognizerDealloc;
- (void)testFaceRecognizerGetRGBData;

@end
