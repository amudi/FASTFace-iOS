//
//  FASTFaceAppDelegate.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/10/10.
//  Copyright amudi.org 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class ResultViewController;
@class FASTFaceModel;

@interface FASTFaceAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	MainViewController *mainViewController;
	ResultViewController *resultViewController;
	FASTFaceModel *faceModel;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;
@property (nonatomic, retain) ResultViewController *resultViewController;

@end
