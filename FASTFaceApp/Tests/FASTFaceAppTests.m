//
//  FASTFaceAppTests.m
//  FASTFace
//
//  Created by Amudi Sebastian on 7/5/10.
//  Copyright 2010 amudi.org. All rights reserved.
//


#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "FASTFaceAppDelegate.h"

@interface FASTFaceAppTests : SenTestCase {
	FASTFaceAppDelegate *appDelegate;
}

- (void)testAppDelegate;

@end

@implementation FASTFaceAppTests

- (void)setUp {
	NSLog(@"%@ start", self.name);
	appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)testAppDelegate {
	NSLog(@"%@ start", self.name);
	//STAssertNotNil(appDelegate, @"failed to get app delegate, appDelegate = %@", appDelegate);
}

- (void)tearDown {
	NSLog(@"%@ start", self.name);
	[appDelegate release];
	//STAssertNil(appDelegate, @"failed to release app delegate, appDelegate = %@", appDelegate);
}

@end
