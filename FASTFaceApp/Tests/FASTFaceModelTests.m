//
//  FASTFaceModelTests.m
//  FASTFace
//
//  Created by Amudi Sebastian on 7/5/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "FASTFaceModel.h"

@interface FASTFaceModelTests : SenTestCase {
	FASTFaceModel *faceModel;
}

- (void)testFaceModelInitWithFaceTemplate;
- (void)testFaceModelLoadResource;
- (void)testFaceModelSetPhotos;
- (void)testGetDistance;

@end


@implementation FASTFaceModelTests

- (void)setUp {
	DLog(@"%@ start", self.name);
	faceModel = [[FASTFaceModel alloc] init];
	STAssertTrue([faceModel retainCount] > 0, @"failed to allocate FASTFaceModel. [faceModel retainCount] = %d", [faceModel retainCount]);
	STAssertNotNil(faceModel, @"failed to allocate FASTFaceModel. faceModel = %@", faceModel);
}

- (void)testFaceModelInitWithFaceTemplate {
	DLog(@"%@ start", self.name);
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSString *pathString = [bundle pathForResource:@"face_template" ofType:@"txt"];
	FASTFaceModel *fm = [[FASTFaceModel alloc] initWithFaceTemplatePath:pathString];
	STAssertNotNil(fm, @"failed to allocate and init FASTFaceModel. fm = %@", fm);
	[fm release];
}

- (void)testFaceModelLoadResource {
	DLog(@"%@ start", self.name);
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSString *pathString = [bundle pathForResource:@"face_template" ofType:@"txt"];
	const char *path = [pathString cStringUsingEncoding:NSUTF8StringEncoding];
	STAssertTrue(sizeof(path) > 0, @"can't get face_template.txt path, path = %s", path);
	
	FaceTemplateLoadResource([faceModel faceTemplate], path);
	STAssertTrue([faceModel faceTemplate] != NULL, @"failed load face template resource, [faceModel faceTemplate] = %d", [faceModel faceTemplate]);
	STAssertTrue([faceModel faceTemplate]->areaSize.width > 0, @"failed load face template resource, [faceModel faceTemplate].areaSize.width = %d", [faceModel faceTemplate]->areaSize.width);
	STAssertTrue([faceModel faceTemplate]->areaSize.height > 0, @"failed load face template resource, [faceModel faceTemplate].areaSize.height = %d", [faceModel faceTemplate]->areaSize.height);
}

- (void)testFaceModelSetPhotos {
	DLog(@"%@ start", self.name);
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	STAssertNotNil(bundle, @"failed to get bundle, bundle = %@", bundle);
	
	NSString *path = [bundle pathForResource:@"test_image" ofType:@"png"];
	STAssertNotNil(path, @"failed to get test_image.png path from bundle, path = %@", path);
	
	UIImage *uiImage = [[UIImage alloc] initWithContentsOfFile:path];;
	STAssertNotNil(uiImage, @"failed to load UIImage, uiImage = %@", uiImage);
	
	CGImageRef cgImage = [uiImage CGImage];
	CGImageRetain(cgImage);
	STAssertTrue(cgImage != NULL, @"failed to load CGImage, cgImage = %d", cgImage);
	
	[faceModel setPhoto1:cgImage];
	STAssertTrue([faceModel photo1] != NULL, @"failed to load photo1, photo1 = %d", [faceModel photo1]);
	
	[faceModel setPhoto2:cgImage];
	STAssertTrue([faceModel photo2] != NULL, @"failed to load photo2, photo2 = %d", [faceModel photo2]);
	
	CGImageRelease(cgImage);
	[uiImage release];
}

- (void)testGetDistance {
	DLog(@"%@ start", self.name);
	DLog(@"%@ start", self.name);
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	STAssertNotNil(bundle, @"failed to get bundle, bundle = %@", bundle);
	
	NSString *path = [bundle pathForResource:@"test_image" ofType:@"png"];
	STAssertNotNil(path, @"failed to get test_image.png path from bundle, path = %@", path);
	
	UIImage *uiImage = [[UIImage alloc] initWithContentsOfFile:path];;
	STAssertNotNil(uiImage, @"failed to load UIImage, uiImage = %@", uiImage);
	
	CGImageRef cgImage = [uiImage CGImage];
	CGImageRetain(cgImage);
	STAssertTrue(cgImage != NULL, @"failed to load CGImage, cgImage = %d", cgImage);
	
	[faceModel setPhoto1:cgImage];
	STAssertTrue([faceModel photo1] != NULL, @"failed to load photo1, photo1 = %d", [faceModel photo1]);
	
	[faceModel setPhoto2:cgImage];
	STAssertTrue([faceModel photo2] != NULL, @"failed to load photo2, photo2 = %d", [faceModel photo2]);
	
	CGFloat distance = [faceModel getDistance];
	STAssertEquals(distance, 0.0f, @"failed to get correct distance from same image, distance = %f", distance);
	
	CGImageRelease(cgImage);
	[uiImage release];
}

- (void)tearDown {
	DLog(@"%@ start", self.name);
	[faceModel release];
}


@end
