//
//  MainViewController.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/17/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController

@synthesize clearButton;
@synthesize processButton;
@synthesize firstPhotoView;
@synthesize secondPhotoView;
@synthesize photoChoice;
@synthesize photoChoiceActionSheet;


- (void)dealloc {
    [super dealloc];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	photoChoice = PhotoChoice_PhotoUnknown;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (IBAction)selectPhotoSource:(id)sender {
	UIButton *photoView = (UIButton *)sender;
	if (photoView == firstPhotoView) {
		DLog(@"Select first photo");
		photoChoice = PhotoChoice_Photo1;
		photoChoiceActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select photo source", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Camera", nil), NSLocalizedString(@"Photo Album", nil), nil];
		[photoChoiceActionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
		[photoChoiceActionSheet showInView:self.view];
		[photoChoiceActionSheet release];
	} else if (photoView == secondPhotoView) {
		DLog(@"Select second photo");
		photoChoice = PhotoChoice_Photo2;
		photoChoiceActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select photo source", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Camera", nil), NSLocalizedString(@"Photo Album", nil), nil];
		[photoChoiceActionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
		[photoChoiceActionSheet showInView:self.view];
		[photoChoiceActionSheet release];
	} else {
		@throw [NSException exceptionWithName:@"FASTFaceException" reason:NSLocalizedString(@"Unknown sender in selectPhotoSource:", nil) userInfo:nil];
	}
}


- (IBAction)clearPhotos:(id)sender {
	DLog(@"Clear Photos");
}


- (IBAction)processPhotos:(id)sender {
	DLog(@"Process Photos");
}


#pragma mark Action Sheet Handler
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (actionSheet == photoChoiceActionSheet) {
		DLog(@"photoChoiceActionSheet [%@] clicked at index: %d for photo: %d", actionSheet, buttonIndex, photoChoice);
		if (photoChoice == PhotoChoice_PhotoUnknown) {
			@throw [NSException exceptionWithName:@"FASTFaceException" reason:NSLocalizedString(@"Unknown selected photo on selectPhotoSource", nil) userInfo:nil];
		}
		switch (buttonIndex) {
			case 0: 
				DLog(@"Camera for photo %d", photoChoice);
				// show camera
				break;
			case 1:
				DLog(@"Photo Album for photo %d", photoChoice);
				// show photo album
				break;

			default:
				break;
		}
	}
}


@end
