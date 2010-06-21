//
//  UIImage+Resize.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/22/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <UIKit/UIKit.h>


// Extends the UIImage class to support resizing/cropping
@interface UIImage (Resize)
- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize transparentBorder:(NSUInteger)borderSize cornerRadius:(NSUInteger)cornerRadius interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode bounds:(CGSize)bounds interpolationQuality:(CGInterpolationQuality)quality;

@end
