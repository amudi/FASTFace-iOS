//
//  MainViewController.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/17/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "MainViewController.h"
#import "ResultViewController.h"


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
@synthesize adBanner;

- (id)init {
	[super initWithNibName:@"MainViewController" bundle:nil];
	// Custom initialization
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}


- (void)dealloc {
	[defaultBlankImage release];
	defaultBlankImage = nil;
	
    [super dealloc];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	photoChoice = PhotoChoice_PhotoUnknown;
	defaultBlankImage = [UIImage imageNamed:@"blank_image.png"];
	hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
	DLog(@"is Camera available: %d", hasCamera);
	
	DLog(@"Main Screen Loaded");
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
	if (([firstPhotoView currentBackgroundImage] != defaultBlankImage) && ([secondPhotoView currentBackgroundImage] != defaultBlankImage)) {
		[defaultBlankImage release];
	}
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSString *)viewNibName {
	return @"MainViewController";
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	DLog(@"Interface will rotate to %@", toInterfaceOrientation);
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
		DLog(@"Will rotate to portrait now");
	}
}


- (IBAction)selectPhotoSource:(id)sender {
	UIButton *photoView = (UIButton *)sender;
	
	if (photoView == nil) {
		@throw [NSException exceptionWithName:@"FASTFaceException" reason:@"Invalid photo tap source" userInfo:nil];
	}
	
	if (photoView == firstPhotoView) {
		DLog(@"Select first photo");
		photoChoice = PhotoChoice_Photo1;
	} else if (photoView == secondPhotoView) {
		DLog(@"Select second photo");
		photoChoice = PhotoChoice_Photo2;
	}
	
	if (hasCamera) {
		photoChoiceActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select photo source", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Camera", nil), NSLocalizedString(@"Photo Album", nil), nil];
	} else {
		// camera not available
		photoChoiceActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select photo source", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Photo Album", nil), nil];
	}
	
	[photoChoiceActionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[photoChoiceActionSheet showInView:self.view];
	[photoChoiceActionSheet release];
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


- (IBAction)showResult:(id)sender {
	DLog(@"Show Result Screen");
	ResultViewController *resultScreen = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
	[resultScreen setMainViewController:self];
	
	resultScreen.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:resultScreen animated:YES];
	[resultScreen release];
}


#pragma mark Action Sheet Handler
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([actionSheet isEqual:photoChoiceActionSheet]) {
		DLog(@"photoChoiceActionSheet [%@] tapped at index: %d for photo: %d", actionSheet, buttonIndex, photoChoice);
		if (photoChoice == PhotoChoice_PhotoUnknown) {
			@throw [NSException exceptionWithName:@"FASTFaceException" reason:NSLocalizedString(@"Unknown selected photo on selectPhotoSource", nil) userInfo:nil];
		}
		switch (buttonIndex) {
			case 0: 				
				// show camera or photo album
				cameraViewController = [[UIImagePickerController alloc] init];
				cameraViewController.delegate = self;
				cameraViewController.allowsEditing = YES;
				
				if (hasCamera) {
					DLog(@"Camera for photo %d", photoChoice);
					cameraViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
					cameraViewController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
				} else {
					DLog(@"Photo Album for photo %d", photoChoice);
					cameraViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				}

				[self presentModalViewController:cameraViewController animated:YES];
				break;
				
			case 1:
				// show photo album or cancel
				if (hasCamera) {
					DLog(@"Photo Album for photo %d", photoChoice);
					photoAlbumViewController = [[UIImagePickerController alloc] init];
					photoAlbumViewController.delegate = self;
					photoAlbumViewController.allowsEditing = YES;
					photoAlbumViewController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
					photoAlbumViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
					[self presentModalViewController:photoAlbumViewController animated:YES];
				} else {
					DLog(@"Cancel photo %d", photoChoice);
				}				
				break;

			default:
				DLog(@"Unknown button tapped in action sheet : %d", buttonIndex);
				break;
		}
	} else if ([actionSheet isEqual:clearActionSheet]) {
		DLog(@"clearActionSheet tapped at index: %d", buttonIndex);
		switch (buttonIndex) {
			case 0:
				DLog(@"Clear all photos");
				// TODO: clear all photos
				[self clearPhotos];
				break;
			default:
				break;
		}
	} else if ([actionSheet isEqual:processActionSheet]) {
		DLog(@"processActionSheet tapped at index: %d", buttonIndex);
		switch (buttonIndex) {
			case 0:
				DLog(@"Process photos")
				// TODO: process photos
				[self showResult:self];
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
	
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	if (CFStringCompare((CFStringRef)mediaType, (CFStringRef)kUTTypeImage, 0) == kCFCompareEqualTo) {
		UIImage *photo = [info objectForKey:UIImagePickerControllerEditedImage];
		if (!photo) {
			// no edited photo available
			photo = [info objectForKey:UIImagePickerControllerOriginalImage];
			DLog(@"No edited image, using original image");
		}
		switch (photoChoice) {
		case PhotoChoice_Photo1:
			[firstPhotoView setBackgroundImage:photo forState:UIControlStateNormal];
			break;
		case PhotoChoice_Photo2:
			[secondPhotoView setBackgroundImage:photo forState:UIControlStateNormal];
			break;
		default:
			break;
		}
		photoChoice = PhotoChoice_PhotoUnknown;
	}
	
	[picker release];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	DLog(@"Image picker [%@] cancelled", picker);
	[picker dismissModalViewControllerAnimated:YES];
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
	[picker release];
}


#pragma mark Photo processing methods
- (void)clearPhotos {
	if (!defaultBlankImage) {
		defaultBlankImage = [UIImage imageNamed:@"blank_image.png"];
	}
	[firstPhotoView setBackgroundImage:defaultBlankImage forState:UIControlStateNormal];
	[secondPhotoView setBackgroundImage:defaultBlankImage forState:UIControlStateNormal];
}


- (void)processFirstPhoto:(UIImage *)firstPhoto andSecondPhoto:(UIImage *)secondPhoto {
	
}


@end
