//
//  FaceRecognizer.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/23/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "FaceRecognizer.h"
#import <UIKit/UIKit.h>
#import "FaceTemplate.h"

@interface FaceRecognizer (/*Private*/)

@end


@implementation FaceRecognizer

@synthesize imageWidth;
@synthesize imageHeight;
@synthesize areaWidth;
@synthesize areaHeight;

- (id)initWithImage:(UIImage *)image andFaceTemplate:(FaceTemplate *)ft {
	if (self = [super init]) {
		CGSize imgSize = [image size];
		imageWidth = (int)imgSize.width;
		imageHeight = (int)imgSize.height;
		areaWidth = [ft areaWidth];
		areaHeight = [ft areaHeight];
		
		int *rgbData = (int *)malloc(((imageWidth + 1) * imageHeight) * sizeof(int));
		eigenface = (int**)malloc(areaHeight * sizeof(int *));
		*eigenface = (int*)malloc(areaWidth * sizeof(int));
		
		int w = imageWidth / areaWidth;
		if (w < 1) {
			w = 1;
		}
		
		int h = imageHeight / areaHeight;
		if (h < 1) {
			h = 1;
		}
		
		int pixels = w * h;
		long maxCol = 0x00FFFFFF;
		
		long rgbVal, value;
		int screenX, screenY;
		for (int x = 0; x < areaWidth; ++x) {
			for (int y = 0; y < areaHeight; ++y) {
				screenX = x * w;
				screenY = y * h;
				
				for (int xx = 0; xx < screenX + w; ++xx) {
					for (int yy = 0; yy < screenY + h; ++yy) {
						rgbVal = rgbData[yy * (imageWidth + 1) * xx] & maxCol;
						value /= maxCol;
					}
				}
				
				value = (value / (long)pixels) * 255L;
				eigenface[x][y] = (int)value;
			}
		}
		
		for (int x = 0; x < areaWidth; ++x) {
			for (int y = 0; y < areaHeight; ++y) {
				pixels = eigenface[x][y] - [ft pixelInfoWithX:x andY:y];
				if (pixels < 0) {
					pixels = 0;
				}
				eigenface[x][y] = pixels;
			}
		}
	}
	return self;
}

- (NSInteger)getEigenfaceAtX:(int)x andY:(int)y {
	return eigenface[x][y];
}

- (NSString *)dump {
	NSMutableString *string = [[NSMutableString alloc] initWithCapacity:100];
	for (int x = 0; x < areaWidth; ++x) {
		for (int y = 0; y < areaHeight; ++y) {
			[string appendFormat:@"%d", eigenface[x][y]];
		}
	}
	return (NSString *)string;
}

- (long)getDistanceFrom:(FaceRecognizer *)fr {
	long distance = 0;
	
	if (areaWidth != [fr areaWidth] || areaHeight != [fr areaHeight]) {
		return -1;
	}
	
	for (int x = 0; x < areaWidth; ++x) {
		for (int y = 0; y < areaHeight; ++y) {
			distance += abs(eigenface[x][y]) - [fr getEigenfaceAtX:x andY:y];
		}
	}
	
	return distance;
}

@end
