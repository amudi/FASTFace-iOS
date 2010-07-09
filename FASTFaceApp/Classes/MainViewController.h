//
//  MainViewController.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/17/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "MBProgressHUD.h"

@class ResultViewController;
@class FASTFaceModel;

typedef enum PhotoChoice {
	PhotoChoice_PhotoUnknown = 0,
	PhotoChoice_Photo1,
	PhotoChoice_Photo2
} PhotoChoice;


@interface MainViewController : UIViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MBProgressHUDDelegate> {
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
	MBProgressHUD *progressHUD;
	
	UIImage *defaultBlankImage;
	BOOL hasCamera;
	
	FASTFaceModel *faceModel;
}

@property (nonatomic, retain) IBOutlet UIButton *clearButton;
@property (nonatomic, retain) IBOutlet UIButton *processButton;
@property (nonatomic, retain) IBOutlet UIButton *firstPhotoView;
@property (nonatomic, retain) IBOutlet UIButton *secondPhotoView;
@property (nonatomic, assign) PhotoChoice photoChoice;
@property (nonatomic, retain) IBOutlet ADBannerView *adBanner;
@property (nonatomic, retain) ResultViewController *resultView;

- (IBAction)selectPhotoSource:(id)sender;
- (IBAction)clearPhotos:(id)sender;
- (IBAction)processPhotos:(id)sender;
- (IBAction)showResult:(id)sender;

- (void)clearPhotos;

@end
