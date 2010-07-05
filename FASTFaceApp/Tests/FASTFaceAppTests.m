//
//  FASTFaceAppTests.m
//  FASTFace
//
//  Created by Amudi Sebastian on 7/5/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "FASTFaceAppTests.h"
#import "FASTFaceAppDelegate.h"

@implementation FASTFaceAppTests

- (void)setUp {
	NSLog(@"%@ start", self.name);
	appDelegate = [[UIApplication sharedApplication] delegate];
	STAssertNotNil(appDelegate, @"failed to get app delegate");
}

- (void)tearDown {
	NSLog(@"%@ start", self.name);
}

@end
