//
//  FaceRecognizer.c
//  FASTFace
//
//  Created by Amudi Sebastian on 6/23/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#include "FaceRecognizer.h"
#include <stdlib.h>
#include <stdio.h>

FaceRecognizer *FaceRecognizerCreate(CGImageRef image, FaceTemplate *ft) {
	if (!image || !ft) {
		fprintf(stderr, "can't init FaceRecognizer, parameters must not be nil");
		return NULL;
	}
	
	FaceRecognizer *fr = (FaceRecognizer*)malloc(sizeof(FaceRecognizer));
	if (!fr) {
		fprintf(stderr, "can't allocate memory for FaceRecognizer");
		return NULL;
	}
	
	fr->imageSize.width = CGImageGetWidth(image);
	fr->imageSize.height = CGImageGetHeight(image);
	fr->areaSize = ft->areaSize;
	
	int rgbData[((int)(fr->imageSize.width + 1)) * ((int)fr->imageSize.height)];
	fr->eigenface = (int**)malloc(fr->areaSize.height * sizeof(int *));
	if (!fr->eigenface) {
		fprintf(stderr, "can't allocate memory for eigenface array");
		return NULL;
	}
	
	for (int i = 0; i < fr->areaSize.height; ++i) {
		fr->eigenface[i] = (int *)malloc(fr->areaSize.width * sizeof(int));
		if (!fr->eigenface[i]) {
			fprintf(stderr, "can't allocate memory for eigenface inner array");
			return NULL;
		}
	}
	
	// TODO: get RGB data from image
	CGImageRef imageRef = image;
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(rgbData, fr->imageSize.width, fr->imageSize.height, 8, fr->imageSize.width * 4, colorSpace, kCGImageAlphaPremultipliedFirst);
	CGColorSpaceRelease(colorSpace);
	
	CGRect rect = CGRectMake(0, 0, fr->imageSize.width, fr->imageSize.height);
	CGContextDrawImage(context, rect, imageRef);
	
	int w = fr->imageSize.width / fr->areaSize.width;
	if (w < 1) w = 1;
	
	int h = fr->imageSize.height / fr->areaSize.height;
	if (h < 1) h = 1;
	
	int pixels = w * h;
	long maxCol = 0x00FFFFFF;
	
	long rgbVal, value = 0;
	int screenX, screenY;
	for (int x = 0; x < fr->areaSize.width; ++x) {
		for (int y = 0; y < fr->areaSize.height; ++y) {
			screenX = x * w;
			screenY = y * h;
			
			for (int xx = 0; xx < screenX + w; ++xx) {
				for (int yy = 0; yy < screenY + h; ++yy) {
					rgbVal = rgbData[yy * ((int)(fr->imageSize.width + 1)) * xx] & maxCol;
					value += rgbVal / maxCol;
				}
			}
			
			value = (value / (long)pixels) * 255L;
			fr->eigenface[x][y] = (int)value;
		}
	}
	
	for (int x = 0; x < fr->areaSize.width; ++x) {
		for (int y = 0; y < fr->areaSize.height; ++y) {
			pixels = fr->eigenface[x][y] - FaceTemplateGetPixelInfo(ft, x, y);
			if (pixels < 0) {
				pixels = 0;
			}
			fr->eigenface[x][y] = pixels;
		}
	}
	
	// release CG stuff
	CGContextRelease(context);
	
	return fr;
}

void FaceRecognizerDealloc(FaceRecognizer *fr) {
	if (fr) {
		for (int i = 0; i < fr->areaSize.height; ++i) {
			free(fr->eigenface[i]);
		}
		free(fr->eigenface);
	}
	free(fr);
}

int FaceRecognizerGetEigenFace(const FaceRecognizer *fr, int x, int y) {
	return fr->eigenface[x][y];
}

long FaceRecognizerGetDistance(const FaceRecognizer *fr, const FaceRecognizer *frReference) {
	long distance = 0;
	
	if (!CGSizeEqualToSize(fr->areaSize, frReference->areaSize)) {
		return -1;
	}
	
	for (int x = 0; x < fr->areaSize.width; ++x) {
		for (int y = 0; y < fr->areaSize.height; ++y) {
			distance += (abs(fr->eigenface[x][y]) - FaceRecognizerGetEigenFace(frReference, x, y));
		}
	}
	
	return distance;
}

char *FaceRecognizerDump(const FaceRecognizer *fr) {
	return "";
}
