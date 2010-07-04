//
//  FaceTemplate.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/23/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#ifndef FACETEMPLATE_H
#define FACETEMPLATE_H

#define kCR 13
#define kLF 10
#define kZERO 48
#define kNINE 57

#include <CoreGraphics/CoreGraphics.h>

struct FaceTemplate {	
	CGSize areaSize;
	int **pixelInfo;
};
typedef struct FaceTemplate FaceTemplate;

FaceTemplate *FaceTemplateCreate();
void FaceTemplateDealloc(FaceTemplate *ft);
int FaceTemplateGetPixelInfo(const FaceTemplate *ft, int x, int y);
void FaceTemplateSetPixelInfo(FaceTemplate *ft, int x, int y, int value);
void FaceTemplateLoadResource(FaceTemplate *ft, const char *resourceName);
char *FaceTemplateDump();

#endif
