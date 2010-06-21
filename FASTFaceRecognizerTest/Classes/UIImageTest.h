//
//  UIImageTest.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/22/10.
//  Copyright 2010 amudi.org. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>


@interface UIImageTest : SenTestCase {

}

- (void)testGrayscale;
- (void)testResize;

@end
