//
//  UIImageTest.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/22/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "UIImageTest.h"
#import "UIImage+Alpha.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Grayscale.h"


@implementation UIImageTest

- (void)testGrayscale {
	STAssertTrue(YES, @"Yes is not true");
}

- (void)testResize {
	STAssertTrue(YES, @"Yesss");
	STAssertFalse(YES, @"NOooo");
}


@end
