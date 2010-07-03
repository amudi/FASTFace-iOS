//
//  FaceTemplate.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/23/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#include "FaceTemplate.h"

void FaceTemplateInit(FaceTemplate *ft) {
	ft->areaSize = CGSizeMake(0.0f, 0.0f);
	ft->pixelInfo = NULL;
}

void FaceTemplateDealloc(FaceTemplate *ft) {

}

int FaceTemplateGetPixelInfo(FaceTemplate *ft, int x, int y) {
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

void FaceTemplateLoadResource(FaceTemplate *ft, char *resourceName) {
	// TODO: convert loadResource method into something relevant here
}

char *FaceTemplateDump() {
	return "";
}
