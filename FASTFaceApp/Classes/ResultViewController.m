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
@synthesize mainViewController;
@synthesize result;


- (id)init {
	[super initWithNibName:@"ResultViewController" bundle:nil];
	// Custom initialization
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}


- (void)dealloc {
    [super dealloc];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	DLog(@"Result Screen loaded");
}



// Override to allow orientations other than the default portrait orientation.
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


- (IBAction)startOver:(id)sender {
	DLog(@"Start Over");
	[mainViewController clearPhotos];
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)share:(id)sender {
	DLog(@"Share");
}


@end
