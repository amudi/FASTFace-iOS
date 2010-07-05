//
//  FASTFaceModelTests.m
//  FASTFace
//
//  Created by Amudi Sebastian on 7/5/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "FASTFaceModelTests.h"
#import "FASTFaceModel.h"

@implementation FASTFaceModelTests

- (void)setUp {
	faceModel = [[FASTFaceModel alloc] init];
	STAssertNotNil(faceModel, @"failed to allocate FASTFaceModel");
}


@end
