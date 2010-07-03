//
//  FaceTemplate.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/23/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#ifndef FACETEMPLATE_H
#define FACETEMPLATE_H

#include <CoreGraphics/CoreGraphics.h>

typedef struct FaceTemplate {	
	CGSize areaSize;
	int **pixelInfo;
} FaceTemplate;

void FaceTemplateInit(FaceTemplate *ft);
void FaceTemplateDealloc(FaceTemplate *ft);
int FaceTemplateGetPixelInfo(FaceTemplate *ft, int x, int y);
void FaceTemplateSetPixelInfo(FaceTemplate *ft, int x, int y, int value);
void FaceTemplateLoadResource(FaceTemplate *ft, char *resourceName);
char *FaceTemplateDump();

#endif
