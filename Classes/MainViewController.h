//
//  MainViewController.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/17/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum PhotoChoice {
	PhotoChoice_PhotoUnknown = 0,
	PhotoChoice_Photo1,
	PhotoChoice_Photo2
} PhotoChoice;


@interface MainViewController : UIViewController <UIActionSheetDelegate> {
	UIButton *clearButton;
	UIButton *processButton;
	UIButton *firstPhotoView;
	UIButton *secondPhotoView;
}

@property (nonatomic, retain) IBOutlet UIButton *clearButton;
@property (nonatomic, retain) IBOutlet UIButton *processButton;
@property (nonatomic, retain) IBOutlet UIButton *firstPhotoView;
@property (nonatomic, retain) IBOutlet UIButton *secondPhotoView;
@property (nonatomic, assign) PhotoChoice photoChoice;
@property (nonatomic, retain) UIActionSheet *photoChoiceActionSheet;

- (IBAction)selectPhotoSource:(id)sender;
- (IBAction)clearPhotos:(id)sender;
- (IBAction)processPhotos:(id)sender;

@end
