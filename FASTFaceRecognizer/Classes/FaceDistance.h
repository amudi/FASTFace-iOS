//
//  FaceDistance.h
//  FASTFace
//
//  Created by Amudi Sebastian on 7/12/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#ifndef FACEDISTANCE_H
#define FACEDISTANCE_H

struct FaceDistance {
	int samePersonPct;	// 1-100
	int relativesPct;	// 1-100
	int soulmatePct;	// 1-100
	int ancestorPct;	// 1-100
	int characteristicPct;	// 1-100
};
typedef struct FaceDistance FaceDistance;

int FaceDistanceGetSamePersonPct(const long distance);
int FaceDistanceGetRelativesPct(const long distance);
int FaceDistanceGetSoulmatePct(const long distance);
int FaceDistanceGetAncestorPct(const long distance);
int FaceDistanceGetCharacteristicPct(const long distance);
FaceDistance *FaceDistanceCreateEmpty();
FaceDistance *FaceDistanceCreate(const long distance);
void FaceDistanceDealloc(FaceDistance *fd);
void FaceDistanceGetDistance(FaceDistance *fd, const long distance);

#endif
