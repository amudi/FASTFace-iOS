//
//  FaceRecognizer.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/23/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaceRecognizer : NSObject {
	NSInteger imageWidth;
	NSInteger imageHeight;
	NSInteger areaWidth;
	NSInteger areaHeight;
 @private
	NSInteger **eigenface;
}

@property (nonatomic, assign) NSInteger imageWidth;
@property (nonatomic, assign) NSInteger imageHeight;
@property (nonatomic, assign) NSInteger areaWidth;
@property (nonatomic, assign) NSInteger areaHeight;

- (NSInteger)getEigenfaceAtX:(int)x andY:(int)y;
- (NSString *)dump;
- (long)getDistanceFrom:(FaceRecognizer *)fr;

@end