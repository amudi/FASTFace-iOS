//
//  FaceRecognizer.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/23/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#ifndef FACERECOGNIZER_H
#define FACERECOGNIZER_H

#include <CoreGraphics/CoreGraphics.h>
#include "FaceTemplate.h"

struct FaceRecognizer {
	/*FaceRecognizer()
		: imageSize(0.0f, 0.0f)
		, areaSize(0.0f, 0.0f)
		, eigenface(NULL)
	{}*/
	
	CGSize imageSize;
	CGSize areaSize;
	int **eigenface;
};
typedef struct FaceRecognizer FaceRecognizer;

FaceRecognizer *FaceRecognizerCreate(CGImageRef image, FaceTemplate *ft);
void FaceRecognizerDealloc(FaceRecognizer *fr);
int FaceRecognizerGetEigenFace(const FaceRecognizer *fr, int x, int y);
long FaceRecognizerGetDistance(const FaceRecognizer *fr, const FaceRecognizer *frReference);
void FaceRecognizerGetRGBDataFromImage(FaceRecognizer *fr, int *rgbData, CGImageRef image);
char *FaceRecognizerDump(const FaceRecognizer *fr);

#endif
