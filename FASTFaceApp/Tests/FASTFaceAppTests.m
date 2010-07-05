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
	MainViewController *mainView;
}

- (void)testAppDelegate;
- (void)testMainViewControllerAllocation;

@end

@implementation FASTFaceAppTests

- (void)setUp {
	NSLog(@"%@ start", self.name);
	appDelegate = [[UIApplication sharedApplication] delegate];
	mainView = appDelegate.mainViewController;
}

- (void)testAppDelegate {
	NSLog(@"%@ start", self.name);
	STAssertNotNil(appDelegate, @"failed to get AppDelegate, appDelegate = %@", appDelegate);
}

- (void)testMainViewControllerAllocation {
	NSLog(@"%@ start", self.name);
	STAssertNotNil(mainView, @"failed to get MainViewController, mainView = %@", mainView);
}

@end
