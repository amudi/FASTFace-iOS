//
//  UIImageCategoriesTests.m
//  FASTFace
//
//  Created by Amudi Sebastian on 7/6/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "UIImage+Alpha.h"
#import "UIImage+Grayscale.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"

@interface UIImageCategoriesTests : SenTestCase {
	UIImage *originalImage;
	UIImage *convertedImage;
	NSString *convertedImagePath;
	
	// no alpha image
	UIImage *noAlphaImage;
	NSString *noAlphaImagePath;
	
	NSString *path;
	NSBundle *bundle;
}

- (void)testUIImageAlphaHasAlpha;
- (void)testUIImageAlphaCreateImageWithAlpha;
- (void)testUIImageAlphaCreateTransparentBorderImage;
- (void)testUIImageGrayscale;
- (void)testUIImageRoundedCorner;
- (void)testUIImageResize;
- (void)resizeCropTest;
- (void)resizeThumbnailTest;
- (void)resizeWithInterpolationQualityTest;
- (void)resizeWithContentModeTest;

@end


@implementation UIImageCategoriesTests

- (void)setUp {
	DLog(@"%@ start", self.name);
	
	bundle = [NSBundle bundleForClass:[self class]];
	STAssertNotNil(bundle, @"failed to get bundle, bundle = %@", bundle);
	
	noAlphaImagePath = [bundle pathForResource:@"test_image_noalpha" ofType:@"png"];
	STAssertNotNil(noAlphaImagePath, @"failed to get test_image_noalpha.png path from bundle, noAlphaImagePath = %@", noAlphaImagePath);
	
	noAlphaImage = [[UIImage alloc] initWithContentsOfFile:noAlphaImagePath];
	STAssertNotNil(noAlphaImage, @"failed to load UIImage, noAlphaImage = %@", noAlphaImage);
	
	path = [bundle pathForResource:@"test_image" ofType:@"png"];
	STAssertNotNil(path, @"failed to get test_image.png path from bundle, path = %@", path);
	
	// NOTE: error when using original image with alpha
	originalImage = [[UIImage alloc] initWithContentsOfFile:path];
	UIImage *tmp = [originalImage imageWithAlpha];
	[originalImage release];
	originalImage = [tmp retain];
	STAssertNotNil(originalImage, @"failed to load UIImage, originalImage = %@", originalImage);
}

// - (BOOL)hasAlpha;
// - (UIImage *)imageWithAlpha;
// - (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (void)testUIImageAlphaHasAlpha {
	DLog(@"%@ start", self.name);
	
	BOOL hasAlpha = [originalImage hasAlpha];
	STAssertTrue(hasAlpha, @"failed to detect alpha channel from originalImage");
	
	hasAlpha = [noAlphaImage hasAlpha];
	STAssertFalse(hasAlpha, @"failed to detect alpha channel from noAlphaImage");
}

- (void)testUIImageAlphaCreateImageWithAlpha {
	DLog(@"%@ start", self.name);
	
	convertedImage = [noAlphaImage imageWithAlpha];
	STAssertNotNil(convertedImage, @"failed to create image with alpha, convertedImage = %@", convertedImage);
	
	BOOL hasAlpha = [convertedImage hasAlpha];
	STAssertTrue(hasAlpha, @"failed to detect alpha channel from convertedImage");
	
	convertedImagePath = [path stringByReplacingOccurrencesOfString:@"test_image" withString:@"converted_image_alpha"];
	STAssertNotNil(convertedImagePath, @"failed to get converted image path string, convertedImagePath = %@", convertedImagePath);
	
	NSData *imageData = UIImagePNGRepresentation(convertedImage);
	STAssertNotNil(imageData, @"failed to convert image into PNG");
	
	NSError *error = nil;
	BOOL writeSuccess = [imageData writeToFile:convertedImagePath options:NSDataWritingAtomic error:&error];
	STAssertTrue(writeSuccess, @"failed to save file %@", convertedImagePath);
	STAssertNil(error, @"error while writing file %@ : %@", convertedImagePath, [error localizedDescription]);
}

- (void)testUIImageAlphaCreateTransparentBorderImage {
	DLog(@"%@ start", self.name);
	
	convertedImage = [originalImage transparentBorderImage:10];
	STAssertNotNil(convertedImage, @"failed to create image transparent border, convertedImage = %@", convertedImage);
	
	BOOL hasAlpha = [convertedImage hasAlpha];
	STAssertTrue(hasAlpha, @"failed to detect alpha channel from convertedImage");
	
	convertedImagePath = [path stringByReplacingOccurrencesOfString:@"test_image" withString:@"converted_image_transparentborder"];
	STAssertNotNil(convertedImagePath, @"failed to get converted image path string, convertedImagePath = %@", convertedImagePath);
	
	NSData *imageData = UIImagePNGRepresentation(convertedImage);
	STAssertNotNil(imageData, @"failed to convert image into PNG");
	
	NSError *error = nil;
	BOOL writeSuccess = [imageData writeToFile:convertedImagePath options:NSDataWritingAtomic error:&error];
	STAssertTrue(writeSuccess, @"failed to save file %@", convertedImagePath);
	STAssertNil(error, @"error while writing file %@ : %@", convertedImagePath, [error localizedDescription]);
}

// - (UIImage *)convertToGrayscale;
- (void)testUIImageGrayscale {
	DLog(@"%@ start", self.name);
	
	convertedImage = [originalImage convertToGrayscale];
	STAssertNotNil(convertedImage, @"failed to convert image to grayscale. convertedImage = %@", convertedImage);
	
	convertedImagePath = [path stringByReplacingOccurrencesOfString:@"test_image" withString:@"converted_image_grayscale"];
	STAssertNotNil(convertedImagePath, @"failed to get converted image path string, convertedImagePath = %@", convertedImagePath);
	
	NSError *error = nil;
	BOOL writeSuccess = [UIImagePNGRepresentation(convertedImage) writeToFile:convertedImagePath options:NSDataWritingAtomic error:&error];
	STAssertTrue(writeSuccess, @"failed to save file %@", convertedImagePath);
	STAssertNil(error, @"error while writing file %@ : %@", convertedImagePath, [error localizedDescription]);
}

// - (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (void)testUIImageRoundedCorner {
	DLog(@"%@ start", self.name);
	
	NSInteger cornerSize = 5;
	NSInteger borderSize = 1;
	
	convertedImage = [originalImage roundedCornerImage:cornerSize borderSize:borderSize];
	STAssertNotNil(convertedImage, @"failed to convert image with rounded corner. convertedImage = %@", convertedImage);
	
	convertedImagePath = [path stringByReplacingOccurrencesOfString:@"test_image" withString:@"converted_image_roundedcorner"];
	STAssertNotNil(convertedImagePath, @"failed to get converted image path string, convertedImagePath = %@", convertedImagePath);
	
	NSData *imageData = UIImagePNGRepresentation(convertedImage);
	STAssertNotNil(imageData, @"failed to convert image into PNG");
	
	NSError *error = nil;
	BOOL writeSuccess = [imageData writeToFile:convertedImagePath options:NSDataWritingAtomic error:&error];
	STAssertTrue(writeSuccess, @"failed to save file %@", convertedImagePath);
	STAssertNil(error, @"error while writing file %@ : %@", convertedImagePath, [error localizedDescription]);
}

// - (UIImage *)croppedImage:(CGRect)bounds;
// - (UIImage *)thumbnailImage:(NSInteger)thumbnailSize transparentBorder:(NSUInteger)borderSize cornerRadius:(NSUInteger)cornerRadius interpolationQuality:(CGInterpolationQuality)quality;
// - (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;
// - (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode bounds:(CGSize)bounds interpolationQuality:(CGInterpolationQuality)quality;
- (void)testUIImageResize {
	DLog(@"%@ start", self.name);
	
	[self resizeCropTest];
	[self resizeThumbnailTest];
	[self resizeWithInterpolationQualityTest];
	[self resizeWithContentModeTest];
}

- (void)resizeCropTest {
	DLog(@"%@ start", self.name);
	
	CGRect bounds = CGRectMake(5.0f, 5.0f, 150.0f, 260.0f);
	
	convertedImage = [originalImage croppedImage:bounds];
	STAssertNotNil(convertedImage, @"failed to convert image with resize crop. convertedImage = %@", convertedImage);
	
	convertedImagePath = [path stringByReplacingOccurrencesOfString:@"test_image" withString:@"converted_image_resizecrop"];
	STAssertNotNil(convertedImagePath, @"failed to get converted image path string, convertedImagePath = %@", convertedImagePath);
	
	NSData *imageData = UIImagePNGRepresentation(convertedImage);
	STAssertNotNil(imageData, @"failed to convert image into PNG");
	
	NSError *error = nil;
	BOOL writeSuccess = [imageData writeToFile:convertedImagePath options:NSDataWritingAtomic error:&error];
	STAssertTrue(writeSuccess, @"failed to save file %@", convertedImagePath);
	STAssertNil(error, @"error while writing file %@ : %@", convertedImagePath, [error localizedDescription]);
}

- (void)resizeThumbnailTest {
	DLog(@"%@ start", self.name);
	
	NSInteger thumbnailSize = 60;
	NSUInteger borderSize = 5;
	NSUInteger cornerRadius = 5;
	CGInterpolationQuality quality = kCGInterpolationHigh;
	
	convertedImage = [originalImage thumbnailImage:thumbnailSize transparentBorder:borderSize cornerRadius:cornerRadius interpolationQuality:quality];
	STAssertNotNil(convertedImage, @"failed to convert image into thumbnail. convertedImage = %@", convertedImage);
	
	convertedImagePath = [path stringByReplacingOccurrencesOfString:@"test_image" withString:@"converted_image_thumbnail"];
	STAssertNotNil(convertedImagePath, @"failed to get converted image path string, convertedImagePath = %@", convertedImagePath);
	
	NSData *imageData = UIImagePNGRepresentation(convertedImage);
	STAssertNotNil(imageData, @"failed to convert image into PNG");
	
	NSError *error = nil;
	BOOL writeSuccess = [imageData writeToFile:convertedImagePath options:NSDataWritingAtomic error:&error];
	STAssertTrue(writeSuccess, @"failed to save file %@", convertedImagePath);
	STAssertNil(error, @"error while writing file %@ : %@", convertedImagePath, [error localizedDescription]);
}

- (void)resizeWithInterpolationQualityTest {
	DLog(@"%@ start", self.name);
	
	CGSize newSize = CGSizeMake(50.0f, 70.0f);
	CGInterpolationQuality quality = kCGInterpolationHigh;
	
	convertedImage = [originalImage resizedImage:newSize interpolationQuality:quality];
	STAssertNotNil(convertedImage, @"failed to convert image with resize with interpolation quality. convertedImage = %@", convertedImage);
	
	convertedImagePath = [path stringByReplacingOccurrencesOfString:@"test_image" withString:@"converted_image_resizeimterpolation"];
	STAssertNotNil(convertedImagePath, @"failed to get converted image path string, convertedImagePath = %@", convertedImagePath);
	
	NSData *imageData = UIImagePNGRepresentation(convertedImage);
	STAssertNotNil(imageData, @"failed to convert image into PNG");
	
	NSError *error = nil;
	BOOL writeSuccess = [imageData writeToFile:convertedImagePath options:NSDataWritingAtomic error:&error];
	STAssertTrue(writeSuccess, @"failed to save file %@", convertedImagePath);
	STAssertNil(error, @"error while writing file %@ : %@", convertedImagePath, [error localizedDescription]);
}

- (void)resizeWithContentModeTest {
	DLog(@"%@ start", self.name);
	
	UIViewContentMode contentModeFit = UIViewContentModeScaleAspectFit;
	UIViewContentMode contentModeFill = UIViewContentModeScaleAspectFill;
	CGSize newSize = CGSizeMake(50.0f, 70.0f);
	CGInterpolationQuality quality = kCGInterpolationHigh;
	
	// content mode fit
	convertedImage = [originalImage resizedImageWithContentMode:contentModeFit bounds:newSize interpolationQuality:quality];
	STAssertNotNil(convertedImage, @"failed to convert image with resize with content mode fit. convertedImage = %@", convertedImage);
	
	convertedImagePath = [path stringByReplacingOccurrencesOfString:@"test_image" withString:@"converted_image_resizecontentmodefit"];
	STAssertNotNil(convertedImagePath, @"failed to get converted image path string, convertedImagePath = %@", convertedImagePath);
	
	[UIImagePNGRepresentation(convertedImage) writeToFile:convertedImagePath atomically:YES];
	
	// content mode fill
	convertedImage = [originalImage resizedImageWithContentMode:contentModeFill bounds:newSize interpolationQuality:quality];
	STAssertNotNil(convertedImage, @"failed to convert image with resize with content mode fill. convertedImage = %@", convertedImage);
	
	convertedImagePath = [path stringByReplacingOccurrencesOfString:@"test_image" withString:@"converted_image_resizecontentmodefill"];
	STAssertNotNil(convertedImagePath, @"failed to get converted image path string, convertedImagePath = %@", convertedImagePath);
	
	NSData *imageData = UIImagePNGRepresentation(convertedImage);
	STAssertNotNil(imageData, @"failed to convert image into PNG");
	
	NSError *error = nil;
	BOOL writeSuccess = [imageData writeToFile:convertedImagePath options:NSDataWritingAtomic error:&error];
	STAssertTrue(writeSuccess, @"failed to save file %@", convertedImagePath);
	STAssertNil(error, @"error while writing file %@ : %@", convertedImagePath, [error localizedDescription]);
}

- (void)tearDown {
	DLog(@"%@ start", self.name);
	
	[noAlphaImagePath release];
	[originalImage release];
}


@end
