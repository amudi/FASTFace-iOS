//
//  UIImage+RoundedCorner.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/22/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <UIKit/UIKit.h>


// Extends the UIImage class to support making rounded corners
@interface UIImage (RoundedCorner)
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
@end
