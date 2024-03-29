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
#import "FASTFaceModel.h"
#import <unistd.h>

@interface MainViewController (/*Private*/)
@property (nonatomic, retain) UIActionSheet *photoChoiceActionSheet;
@property (nonatomic, retain) UIActionSheet *clearActionSheet;
@property (nonatomic, retain) UIActionSheet *processActionSheet;
@property (nonatomic, retain) UIImagePickerController *cameraViewController;
@property (nonatomic, retain) UIImagePickerController *photoAlbumViewController;
@end

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
@synthesize resultView;
@synthesize faceModel;

- (id)init {
	if ((self = [super initWithNibName:@"MainViewController" bundle:nil])) {
		// Custom initialization
		DLog(@"Loading faceModel..");
		NSString *templatePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"face_template" ofType:@"txt"];
		faceModel = [[FASTFaceModel alloc] initWithFaceTemplatePath:templatePath];
		
		photoChoice = PhotoChoice_PhotoUnknown;
		defaultBlankImage = [[UIImage imageNamed:@"blank_image.png"] retain];
		hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
		DLog(@"is Camera available: %d", hasCamera);
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}

- (void)dealloc {
	[clearButton release];
	[processButton release];
	[firstPhotoView release];
	[secondPhotoView release];
	[adBanner release];
	[defaultBlankImage release];
	[resultView release];
	[faceModel release];
	
    [super dealloc];
}

- (void)viewDidLoad {
	if ([self.faceModel photo1]) {
		if (![self.faceModel thumbnail1]) {
			[self.faceModel generateThumbnails];
		}
		[self.firstPhotoView setBackgroundImage:[self.faceModel thumbnail1] forState:UIControlStateNormal];
	} else {
		DLog(@"photo1 is not set, using default blank image");
		[self.firstPhotoView setBackgroundImage:defaultBlankImage forState:UIControlStateNormal];
	}

	if ([self.faceModel photo2]) {
		if (![self.faceModel thumbnail2]) {
			[self.faceModel generateThumbnails];
		}
		[self.secondPhotoView setBackgroundImage:[self.faceModel thumbnail2] forState:UIControlStateNormal];
	} else {
		DLog(@"photo2 is not set, using default blank image");
		[self.secondPhotoView setBackgroundImage:defaultBlankImage forState:UIControlStateNormal];
	}
	DLog(@"Main Screen Loaded");
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	DLog(@"Low Memory Warning!!");
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	DLog(@"Main View unloaded");
	self.clearButton = nil;
	self.processButton = nil;
	self.firstPhotoView = nil;
	self.secondPhotoView = nil;
	self.adBanner = nil;
	
	[super viewDidUnload];
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
		self.photoChoice = PhotoChoice_Photo1;
	} else if (photoView == secondPhotoView) {
		DLog(@"Select second photo");
		self.photoChoice = PhotoChoice_Photo2;
	}
	
	if (hasCamera) {
		self.photoChoiceActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select photo source", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Camera", nil), NSLocalizedString(@"Photo Album", nil), nil];
	} else {
		// camera not available
		self.photoChoiceActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select photo source", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Photo Album", nil), nil];
	}
	
	[self.photoChoiceActionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[self.photoChoiceActionSheet showInView:self.view];
	[self.photoChoiceActionSheet release];
}

- (IBAction)clearPhotos:(id)sender {
	DLog(@"Clear Photos");
	clearActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Clear All photos", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:NSLocalizedString(@"Clear", nil) otherButtonTitles:nil];
	[self.clearActionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[self.clearActionSheet showInView:self.view];
	[self.clearActionSheet release];
}

- (IBAction)processPhotos:(id)sender {
	DLog(@"Process Photos");
	processActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Process photos now? It may take a few minutes.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Process", nil), nil];
	[self.processActionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[self.processActionSheet showInView:self.view];
	[self.processActionSheet release];
}

- (IBAction)showResult:(id)sender {
	DLog(@"Show Result Screen");
	self.resultView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:self.resultView animated:YES];
}

#pragma mark -
#pragma mark Action Sheet Handler

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([actionSheet isEqual:photoChoiceActionSheet]) {
		DLog(@"photoChoiceActionSheet [%@] tapped at index: %d for photo: %d", actionSheet, buttonIndex, photoChoice);
		if (self.photoChoice == PhotoChoice_PhotoUnknown) {
			@throw [NSException exceptionWithName:@"FASTFaceException" reason:NSLocalizedString(@"Unknown selected photo on selectPhotoSource", nil) userInfo:nil];
		}
		switch (buttonIndex) {
			case 0: 				
				// show camera or photo album
				cameraViewController = [[UIImagePickerController alloc] init];
				self.cameraViewController.delegate = self;
				self.cameraViewController.allowsEditing = YES;
				
				if (hasCamera) {
					DLog(@"Camera for photo %d", self.photoChoice);
					self.cameraViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
					self.cameraViewController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
				} else {
					DLog(@"Photo Album for photo %d", self.photoChoice);
					self.cameraViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				}

				[self presentModalViewController:self.cameraViewController animated:YES];
				break;
				
			case 1:
				// show photo album or cancel
				if (hasCamera) {
					DLog(@"Photo Album for photo %d", self.photoChoice);
					photoAlbumViewController = [[UIImagePickerController alloc] init];
					self.photoAlbumViewController.delegate = self;
					self.photoAlbumViewController.allowsEditing = YES;
					self.photoAlbumViewController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
					self.photoAlbumViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
					[self presentModalViewController:self.photoAlbumViewController animated:YES];
				} else {
					DLog(@"Cancel photo %d", self.photoChoice);
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
				progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
				progressHUD.mode = MBProgressHUDModeIndeterminate;
				[self.view addSubview:progressHUD];
				progressHUD.delegate = self;
				progressHUD.labelText = NSLocalizedString(@"Loading", nil);
				progressHUD.detailsLabelText = NSLocalizedString(@"clearing all photos", nil);
				[progressHUD showWhileExecuting:@selector(clearPhotos) onTarget:self withObject:nil animated:YES];
				break;
			default:
				break;
		}
	} else if ([actionSheet isEqual:processActionSheet]) {
		DLog(@"processActionSheet tapped at index: %d", buttonIndex);
		switch (buttonIndex) {
			case 0:
				DLog(@"Process photos")
				progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
				progressHUD.mode = MBProgressHUDModeIndeterminate;
				[self.view addSubview:progressHUD];
				progressHUD.delegate = self;
				progressHUD.labelText = NSLocalizedString(@"Loading", nil);
				progressHUD.detailsLabelText = NSLocalizedString(@"processing photos", nil);
				[progressHUD showWhileExecuting:@selector(processPhotos) onTarget:self withObject:nil animated:YES];
				break;
			default:
				break;
		}
	}
}

#pragma mark -
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
		switch (self.photoChoice) {
			case PhotoChoice_Photo1:
				self.faceModel.photo1 = photo;
				self.faceModel.thumbnail1 = nil;
				self.faceModel.prepPhoto1 = nil;
				[self.faceModel generateThumbnails];
				[self.firstPhotoView setBackgroundImage:[self.faceModel thumbnail1] forState:UIControlStateNormal];
				break;
			case PhotoChoice_Photo2:
				self.faceModel.photo2 = photo;
				self.faceModel.thumbnail2 = nil;
				self.faceModel.prepPhoto2 = nil;
				[self.faceModel generateThumbnails];
				[self.secondPhotoView setBackgroundImage:[self.faceModel thumbnail2] forState:UIControlStateNormal];
				break;
			default:
				break;
		}
		self.photoChoice = PhotoChoice_PhotoUnknown;
	}
	
	[picker release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	DLog(@"Image picker [%@] cancelled", picker);
	[picker dismissModalViewControllerAnimated:YES];
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
	[picker release];
}

- (void)hudWasHidden {
	[progressHUD removeFromSuperview];
	[progressHUD release];
}

#pragma mark -
#pragma mark Photo processing methods

- (void)clearPhotos {
	[self.firstPhotoView setBackgroundImage:defaultBlankImage forState:UIControlStateNormal];
	[self.secondPhotoView setBackgroundImage:defaultBlankImage forState:UIControlStateNormal];
	[self.faceModel clear];
	sleep(1);
}

- (void)processPhotos {
	[self.faceModel preprocessPhoto1];
	[self.faceModel preprocessPhoto2];
	[self.faceModel calculateDistance];
	sleep(1);
	
	progressHUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	progressHUD.mode = MBProgressHUDModeCustomView;
	progressHUD.labelText = NSLocalizedString(@"Completed", nil);
	progressHUD.detailsLabelText = NSLocalizedString(@"", nil);
	sleep(1);
	[self showResult:self];
}


@end
