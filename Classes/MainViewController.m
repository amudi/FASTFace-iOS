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
@synthesize clearActionSheet;
@synthesize processActionSheet;
@synthesize cameraViewController;
@synthesize photoAlbumViewController;


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


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	DLog(@"Interface will rotate to %@", toInterfaceOrientation);
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
		DLog(@"Will rotate to portrait now");
	}
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
	clearActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Clear All photos", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:NSLocalizedString(@"Clear", nil) otherButtonTitles:nil];
	[clearActionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[clearActionSheet showInView:self.view];
	[clearActionSheet release];
}


- (IBAction)processPhotos:(id)sender {
	DLog(@"Process Photos");
	processActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Process photos now? It may take a few minutes.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Process", nil), nil];
	[processActionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[processActionSheet showInView:self.view];
	[processActionSheet release];
}


#pragma mark Action Sheet Handler
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (actionSheet == photoChoiceActionSheet) {
		DLog(@"photoChoiceActionSheet [%@] tapped at index: %d for photo: %d", actionSheet, buttonIndex, photoChoice);
		if (photoChoice == PhotoChoice_PhotoUnknown) {
			@throw [NSException exceptionWithName:@"FASTFaceException" reason:NSLocalizedString(@"Unknown selected photo on selectPhotoSource", nil) userInfo:nil];
		}
		switch (buttonIndex) {
			case 0: 
				DLog(@"Camera for photo %d", photoChoice);
				// show camera
				cameraViewController = [[UIImagePickerController alloc] init];
				cameraViewController.delegate = self;
				cameraViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
				[self presentModalViewController:cameraViewController animated:YES];
				break;
			case 1:
				DLog(@"Photo Album for photo %d", photoChoice);
				// show photo album
				photoAlbumViewController = [[UIImagePickerController alloc] init];
				photoAlbumViewController.delegate = self;
				photoAlbumViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				[self presentModalViewController:photoAlbumViewController animated:YES];
				break;

			default:
				break;
		}
	} else if (actionSheet == clearActionSheet) {
		DLog(@"clearActionSheet tapped at index: %d", buttonIndex);
		switch (buttonIndex) {
			case 0:
				DLog(@"Clear all photos");
				// TODO: clear all photos
				break;
			default:
				break;
		}
	} else if (actionSheet == processActionSheet) {
		DLog(@"processActionSheet tapped at index: %d", buttonIndex);
		switch (buttonIndex) {
			case 0:
				DLog(@"Process photos")
				// TODO: process photos
				break;
			default:
				break;
		}
	}
}


#pragma mark Delegates methods
- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
	// do nothing on cancel
	DLog(@"Action sheet %@ cancelled");
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	DLog(@"Photo selected from picker [%@] : %@", picker, info);
	[picker dismissModalViewControllerAnimated:YES];
	[picker release];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	DLog(@"Image picker [%@] cancelled", picker);
	[picker dismissModalViewControllerAnimated:YES];
	[picker release];
}


@end
