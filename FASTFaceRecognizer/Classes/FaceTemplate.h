//
//  FaceTemplate.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/23/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FaceTemplate : NSObject {
	NSInteger areaWidth;
	NSInteger areaHeight;
  @private
	int **pixelInfo;
}

@property (nonatomic, assign) NSInteger areaWidth;
@property (nonatomic, assign) NSInteger areaHeight;

- (int)pixelInfoWithX:(int)x andY:(int)y;
- (void)setPixelInfoAtX:(int)x andY:(int)y withValue:(int)value;
- (void)loadResource:(NSString *)resourceName;
- (NSString *)dump;

@end
