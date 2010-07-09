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
	
	NSBundle *bundle;
	NSString *templatePath;
	
	UIImage *testImage;
	NSString *imagePath;
}

- (void)testFaceModelInitWithFaceTemplate;
- (void)testFaceModelLoadResource;
- (void)testFaceModelSetPhotos;
- (void)testGenerateThumbnails;
- (void)testGetDistance;

@end


@implementation FASTFaceModelTests

- (void)setUp {
	DLog(@"%@ start", self.name);
	faceModel = [[FASTFaceModel alloc] init];
	STAssertTrue([faceModel retainCount] > 0, @"failed to allocate FASTFaceModel. [faceModel retainCount] = %d", [faceModel retainCount]);
	STAssertNotNil(faceModel, @"failed to allocate FASTFaceModel. faceModel = %@", faceModel);

	bundle = [NSBundle bundleForClass:[self class]];
	[bundle retain];
	STAssertNotNil(bundle, @"failed to get bundle, bundle = %@", bundle);
	
	templatePath = [bundle pathForResource:@"face_template" ofType:@"txt"];
	[templatePath retain];
	STAssertNotNil(templatePath, @"failed to get face_template.txt path from bundle, path = %@", templatePath);
	
	imagePath = [bundle pathForResource:@"test_image" ofType:@"png"];
	[imagePath retain];
	STAssertNotNil(imagePath, @"failed to get test_image.png path from bundle, path = %@", imagePath);
	
	testImage = [UIImage imageWithContentsOfFile:imagePath];
	[testImage retain];
	STAssertNotNil(testImage, @"failed to load testImage, testImage = %@", testImage);
}

- (void)testFaceModelInitWithFaceTemplate {
	DLog(@"%@ start", self.name);
	
	FASTFaceModel *fm = [[FASTFaceModel alloc] initWithFaceTemplatePath:templatePath];
	STAssertNotNil(fm, @"failed to allocate and init FASTFaceModel. fm = %@", fm);
	[fm release];
}

- (void)testFaceModelLoadResource {
	DLog(@"%@ start", self.name);
	
	const char *path = [templatePath cStringUsingEncoding:NSUTF8StringEncoding];
	STAssertTrue(sizeof(path) > 0, @"can't get face_template.txt path, path = %s", path);
	
	FaceTemplateLoadResource([faceModel faceTemplate], path);
	STAssertTrue([faceModel faceTemplate] != NULL, @"failed load face template resource, [faceModel faceTemplate] = %d", [faceModel faceTemplate]);
	STAssertTrue([faceModel faceTemplate]->areaSize.width > 0, @"failed load face template resource, [faceModel faceTemplate].areaSize.width = %d", [faceModel faceTemplate]->areaSize.width);
	STAssertTrue([faceModel faceTemplate]->areaSize.height > 0, @"failed load face template resource, [faceModel faceTemplate].areaSize.height = %d", [faceModel faceTemplate]->areaSize.height);
}

- (void)testFaceModelSetPhotos {
	DLog(@"%@ start", self.name);
	
	[faceModel setPhoto1:testImage];
	STAssertNotNil([faceModel photo1], @"failed to load photo1, photo1 = %@", [faceModel photo1]);
	
	[faceModel setPhoto2:testImage];
	STAssertNotNil([faceModel photo2], @"failed to load photo1, photo2 = %@", [faceModel photo2]);
}

- (void)testGenerateThumbnails {
	DLog(@"%@ start", self.name);
	
	[faceModel setPhoto1:testImage];
	STAssertNotNil([faceModel photo1], @"failed to load photo1, photo1 = %@", [faceModel photo1]);
	
	[faceModel setPhoto2:testImage];
	STAssertNotNil([faceModel photo2], @"failed to load photo1, photo2 = %@", [faceModel photo2]);
	
	[faceModel generateThumbnails];
	STAssertNotNil([faceModel thumbnail1], @"failed to generate thumbnail1, thumbnail1 = %@", [faceModel thumbnail1]);
	STAssertNotNil([faceModel thumbnail2], @"failed to generate thumbnail2, thumbnail2 = %@", [faceModel thumbnail2]);
}

- (void)testGetDistance {
	DLog(@"%@ start", self.name);
	
	[faceModel setPhoto1:testImage];
	STAssertNotNil([faceModel photo1], @"failed to load photo1, photo1 = %@", [faceModel photo1]);
	
	[faceModel setPhoto2:testImage];
	STAssertNotNil([faceModel photo2], @"failed to load photo1, photo2 = %@", [faceModel photo2]);
	
	[faceModel preprocessPhoto1];
	STAssertNotNil([faceModel prepPhoto1], @"failed to preprocess photo1, prepPhoto1 = %@", [faceModel prepPhoto1]);
	
	[faceModel preprocessPhoto2];
	STAssertNotNil([faceModel prepPhoto2], @"failed to preprocess photo1, prepPhoto2 = %@", [faceModel prepPhoto2]);
	
	[faceModel calculateDistance];
	STAssertEquals([faceModel result], 0L, @"failed to get correct distance from same image, distance = %d", [faceModel result]);
}

- (void)tearDown {
	DLog(@"%@ start", self.name);
	[faceModel release];
	
	[testImage release];
	testImage = nil;
	
	[imagePath release];
	imagePath = nil;
	
	[templatePath release];
	templatePath = nil;
	
	[bundle release];
	bundle = nil;
}


@end
