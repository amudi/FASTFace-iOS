//
//  FaceTemplate.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/23/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "FaceTemplate.h"

@implementation FaceTemplate

@synthesize areaWidth;
@synthesize areaHeight;

- (void)dealloc {
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		areaWidth = 0;
		areaHeight = 0;
	}
	return self;
}

- (int)pixelInfoWithX:(int)x andY:(int)y {
	if (x < areaWidth && y < areaHeight) {
		return pixelInfo[x][y];
	}
	return -1;
}

- (void)setPixelInfoAtX:(int)x andY:(int)y withValue:(int)value {
	if (x < areaWidth && y < areaHeight) {
		pixelInfo[x][y] = value;
	}
}

- (void)loadResource:(NSString *)resourceName {
	// TODO: convert loadResource method into something relevant here
}

- (NSString *)dump {
	NSMutableString *string = [[NSMutableString alloc] initWithCapacity:100];
	for (int y = 0; y < areaHeight; ++y) {
		for (int x = 0; x < areaWidth; ++x) {
			[string appendFormat:@"%d", pixelInfo[x][y]];
		}
	}
	return [string autorelease];
}

@end
