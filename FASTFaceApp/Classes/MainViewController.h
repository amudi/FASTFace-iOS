//
//  MainViewController.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/17/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@class ResultViewController;

typedef enum PhotoChoice {
	PhotoChoice_PhotoUnknown = 0,
	PhotoChoice_Photo1,
	PhotoChoice_Photo2
} PhotoChoice;


@interface MainViewController : UIViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
	UIButton *clearButton;
	UIButton *processButton;
	UIButton *firstPhotoView;
	UIButton *secondPhotoView;
	PhotoChoice photoChoice;
	UIActionSheet *photoChoiceActionSheet;
	UIActionSheet *clearActionSheet;
	UIActionSheet *processActionSheet;
	UIImagePickerController *cameraViewController;
	UIImagePickerController *photoAlbumViewController;
	ADBannerView *adBanner;
	
	UIImage *defaultBlankImage;
	BOOL hasCamera;
}

@property (nonatomic, retain) IBOutlet UIButton *clearButton;
@property (nonatomic, retain) IBOutlet UIButton *processButton;
@property (nonatomic, retain) IBOutlet UIButton *firstPhotoView;
@property (nonatomic, retain) IBOutlet UIButton *secondPhotoView;
@property (nonatomic, assign) PhotoChoice photoChoice;
@property (nonatomic, retain) UIActionSheet *photoChoiceActionSheet;
@property (nonatomic, retain) UIActionSheet *clearActionSheet;
@property (nonatomic, retain) UIActionSheet *processActionSheet;
@property (nonatomic, retain) UIImagePickerController *cameraViewController;
@property (nonatomic, retain) UIImagePickerController *photoAlbumViewController;
@property (nonatomic, retain) IBOutlet ADBannerView *adBanner;

- (IBAction)selectPhotoSource:(id)sender;
- (IBAction)clearPhotos:(id)sender;
- (IBAction)processPhotos:(id)sender;
- (IBAction)showResult:(id)sender;

- (void)clearPhotos;
- (void)processFirstPhoto:(UIImage *)firstPhoto andSecondPhoto:(UIImage *)secondPhoto;

@end
