//
//  ResultViewController.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/19/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@class MainViewController;

@interface ResultViewController : UIViewController {
	UIImageView *firstPhotoView;
	UIImageView *secondPhotoView;
	UIToolbar *toolbar;
	UIBarButtonItem *doneButton;
	UIBarButtonItem *shareButton;
	UILabel *resultPercentageLabel;
	UILabel *resultDescriptionLabel;
	ADBannerView *adBanner;
	long result;
}

@property (nonatomic, retain) IBOutlet UIImageView *firstPhotoView;
@property (nonatomic, retain) IBOutlet UIImageView *secondPhotoView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *shareButton;
@property (nonatomic, retain) IBOutlet UILabel *resultPercentageLabel;
@property (nonatomic, retain) IBOutlet UILabel *resultDescriptionLabel;
@property (nonatomic, retain) IBOutlet ADBannerView *adBanner;
@property (nonatomic, assign) long result;

- (IBAction)done:(id)sender;
- (IBAction)share:(id)sender;

@end
