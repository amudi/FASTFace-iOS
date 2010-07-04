//
//  FaceTemplate.c
//  FASTFace
//
//  Created by Amudi Sebastian on 6/23/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#include "FaceTemplate.h"
#include <stdlib.h>
#include <stdio.h>

FaceTemplate *FaceTemplateCreate() {
	FaceTemplate *ft = (FaceTemplate*)malloc(sizeof(FaceTemplate));
	ft->areaSize = CGSizeMake(0.0f, 0.0f);
	ft->pixelInfo = NULL;
	return ft;
}

void FaceTemplateDealloc(FaceTemplate *ft) {
	if (ft) {
		for (int i = 0; i < ft->areaSize.height; ++i) {
			free(ft->pixelInfo[i]);
		}
		free(ft->pixelInfo);
	}
	free(ft);
}

int FaceTemplateGetPixelInfo(const FaceTemplate *ft, int x, int y) {
	if (x < ft->areaSize.width && y < ft->areaSize.height) {
		return ft->pixelInfo[x][y];
	}
	return -1;
}

void FaceTemplateSetPixelInfo(FaceTemplate *ft, int x, int y, int value) {
	if (x < ft->areaSize.width && y < ft->areaSize.height) {
		ft->pixelInfo[x][y] = value;
	}
}

void FaceTemplateLoadResource(FaceTemplate *ft, const char *resourceName) {
	// load face template data from file
	FILE *filePtr = fopen(resourceName, "r");
	if (filePtr == NULL) {
		fprintf(stderr, "Can't open resource: %s", resourceName);
		return;
	}
		
	int x = 0;
	int output = 0;
	
	// get width
	x = fgetc(filePtr);
	while ((x != kLF) && (x != kCR)) {
		if ((x >= kZERO) && (x <= kNINE)) {
			output *= 10;
			output += (x - kZERO);
		}
		x = fgetc(filePtr);
	}
	ft->areaSize.width = output;
	
	// get height
	output = 0;
	x = fgetc(filePtr);
	while ((x != kLF) && (x != kCR)) {
		if ((x >= kZERO) && (x <= kNINE)) {
			output *= 10;
			output += (x - kZERO);
		}
		x = fgetc(filePtr);
	}
	ft->areaSize.height = output;
	
	ft->pixelInfo = (int **)malloc(ft->areaSize.width * sizeof(int *));
	if (!ft->pixelInfo) {
		fprintf(stderr, "Can't allocate memory for pixelInfo");
		return;
	}
	
	for (int i = 0; i < ft->areaSize.width; ++i) {
		ft->pixelInfo[i] = (int *)malloc(ft->areaSize.height * sizeof(int));
		if (!ft->pixelInfo[i]) {
			fprintf(stderr, "Can't allocate memory for pixelInfo inner array");
			return;
		}
	}
	
	output = 0;
	int i = 0;
	int j = 0;
	while ((x = fgetc(filePtr)) != EOF) {
		if ((x != kCR) && (x != kLF)) {
			output *= 10;
			output += (x - kZERO);
		} else if (x == 13) {
			ft->pixelInfo[i][j] = output;
			if (i < (ft->areaSize.width - 1)) {
				++i;
			} else {
				i = 0;
				++j;
			}
			output = 0;
		}
	}
	fclose(filePtr);
}

char *FaceTemplateDump() {
	return "";
}
