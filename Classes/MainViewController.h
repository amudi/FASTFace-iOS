//
//  MainViewController.h
//  FASTFace
//
//  Created by Amudi Sebastian on 6/17/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController {
	UIButton *clearButton;
	UIButton *processButton;
	UIImageView *image1;
	UIImageView *image2;
}

@property (nonatomic, retain) IBOutlet UIButton *clearButton;
@property (nonatomic, retain) IBOutlet UIButton *processButton;
@property (nonatomic, retain) IBOutlet UIImageView *image1;
@property (nonatomic, retain) IBOutlet UIImageView *image2;

@end
