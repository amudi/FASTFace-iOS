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
	UIButton *backButton;
	UIButton *shareButton;
	UILabel *resultPercentageLabel;
	UILabel *resultDescriptionLabel;
	ADBannerView *adBanner;
	long result;
}

@property (nonatomic, retain) IBOutlet UIImageView *firstPhotoView;
@property (nonatomic, retain) IBOutlet UIImageView *secondPhotoView;
@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) IBOutlet UIButton *shareButton;
@property (nonatomic, retain) IBOutlet UILabel *resultPercentageLabel;
@property (nonatomic, retain) IBOutlet UILabel *resultDescriptionLabel;
@property (nonatomic, retain) IBOutlet ADBannerView *adBanner;
@property (nonatomic, assign) long result;

- (IBAction)back:(id)sender;
- (IBAction)share:(id)sender;

@end
