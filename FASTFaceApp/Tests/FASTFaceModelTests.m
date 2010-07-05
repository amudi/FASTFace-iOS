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

- (void)testFaceModelLoadResource;

@end


@implementation FASTFaceModelTests

- (void)setUp {
	NSLog(@"%@ start", self.name);
	faceModel = [[FASTFaceModel alloc] init];
	STAssertTrue([faceModel retainCount] > 0, @"failed to allocate FASTFaceModel. [faceModel retainCount] = %d", [faceModel retainCount]);
	STAssertNotNil(faceModel, @"failed to allocate FASTFaceModel. faceModel = %d", faceModel);
}

- (void)testFaceModelLoadResource {
	NSLog(@"%@ start", self.name);
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSString *pathString = [bundle pathForResource:@"face_template" ofType:@"txt"];
	const char *path = [pathString cStringUsingEncoding:NSUTF8StringEncoding];
	STAssertTrue(sizeof(path) > 0, @"can't get face_template.txt path, path = %s", path);
	
	FaceTemplateLoadResource([faceModel faceTemplate], path);
	STAssertTrue([faceModel faceTemplate] != NULL, @"failed load face template resource, [faceModel faceTemplate] = %d", [faceModel faceTemplate]);
	STAssertTrue([faceModel faceTemplate]->areaSize.width > 0, @"failed load face template resource, [faceModel faceTemplate].areaSize.width = %d", [faceModel faceTemplate]->areaSize.width);
	STAssertTrue([faceModel faceTemplate]->areaSize.height > 0, @"failed load face template resource, [faceModel faceTemplate].areaSize.height = %d", [faceModel faceTemplate]->areaSize.height);
}

- (void)tearDown {
	NSLog(@"%@ start", self.name);
	[faceModel release];
	//STAssertNil(faceModel, @"failed to deallocate FASTFaceModel. faceModel = %d", faceModel);
	//STAssertTrue([faceModel retainCount] <= 0, @"failed to deallocate FASTFaceModel. [faceModel retainCount] = %d", [faceModel retainCount]);
}


@end
