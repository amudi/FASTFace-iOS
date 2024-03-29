//
//  FaceDistance.c
//  FASTFace
//
//  Created by Amudi Sebastian on 7/12/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#include "FaceDistance.h"
#include <stdlib.h>
#include <stdio.h>

int FaceDistanceGetSamePersonPct(const long distance) {
	if (distance < 21000L) {
		return (int)((distance / (-210L)) + 99L);
	} else {
		return 1;
	}
}

int FaceDistanceGetRelativesPct(const long distance) {
	if (distance < 21000L) {
		return (int)(((distance * distance) / (-4410000L)) + 99L);
	} else {
		return 1;
	}
}

int FaceDistanceGetSoulmatePct(const long distance) {
	if (distance < 21000L) {
		return (int) (((distance * distance) / (-980000L)) + (distance / 70L) + 50L);
	} else {
		return 1;
	}
}

int FaceDistanceGetAncestorPct(const long distance) {
	if (distance < 21000L) {
		return (int) (((distance * distance * 5) / (11L * 1000000L)) - (distance * 105L / 11000L) + 99L);
	} else {
		return 1;
	}
}

int FaceDistanceGetCharacteristicPct(const long distance) {
	if (distance < 21000L) {
		return (int)((distance * distance) / 4410000L);
	} else {
		return 99;
	}
}

FaceDistance *FaceDistanceCreateEmpty() {
	FaceDistance *fd = (FaceDistance *)malloc(sizeof(FaceDistance));
	fd->samePersonPct = 0;
	fd->relativesPct = 0;
	fd->soulmatePct = 0;
	fd->ancestorPct = 0;
	fd->characteristicPct = 0;
	return fd;
}

FaceDistance *FaceDistanceCreate(const long distance) {
	FaceDistance *fd = (FaceDistance *)malloc(sizeof(FaceDistance));
	if (!fd) {
		fprintf(stderr, "can't allocate memory for FaceDistance");
		return NULL;
	}
	FaceDistanceGetDistance(fd, distance);
	return fd;
}

void FaceDistanceDealloc(FaceDistance *fd) {
	if (fd) {
		free(fd);
	}
	fd = NULL;
}

void FaceDistanceGetDistance(FaceDistance *fd, const long distance) {
	if (!fd) {
		fd = FaceDistanceCreate(distance);
	}
	fd->samePersonPct = FaceDistanceGetSamePersonPct(distance);
	fd->relativesPct = FaceDistanceGetRelativesPct(distance);
	fd->soulmatePct = FaceDistanceGetSoulmatePct(distance);
	fd->ancestorPct = FaceDistanceGetAncestorPct(distance);
	fd->characteristicPct = FaceDistanceGetCharacteristicPct(distance);
}

