//
//  ResultViewController.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/19/10.
//  Copyright 2010 amudi.org. All rights reserved.
//

#import "ResultViewController.h"
#import "MainViewController.h"

@implementation ResultViewController

@synthesize firstPhotoView;
@synthesize secondPhotoView;
@synthesize startOverButton;
@synthesize shareButton;
@synthesize resultPercentageLabel;
@synthesize resultDescriptionLabel;
@synthesize adBanner;
@synthesize result;


- (id)init {
	if ((self = [super initWithNibName:@"ResultViewController" bundle:nil])) {
		// Custom initialization
	
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	return [self init];
}

- (void)dealloc {
	[firstPhotoView release];
	[secondPhotoView release];
	[startOverButton release];
	[shareButton release];
	[resultPercentageLabel release];
	[resultDescriptionLabel release];
	[adBanner release];
	
	[super dealloc];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	DLog(@"Result Screen loaded");
	[super viewDidLoad];
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
	self.firstPhotoView = nil;
	self.secondPhotoView = nil;
	self.startOverButton = nil;
	self.shareButton = nil;
	self.resultPercentageLabel = nil;
	self.resultDescriptionLabel = nil;
	self.adBanner = nil;
	
	[super viewDidUnload];
}

- (IBAction)startOver:(id)sender {
	DLog(@"Start Over");
	//[mainViewController clearPhotos];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)share:(id)sender {
	DLog(@"Share");
}

@end
