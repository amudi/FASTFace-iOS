//
//  FASTFaceAppDelegate.m
//  FASTFace
//
//  Created by Amudi Sebastian on 6/10/10.
//  Copyright amudi.org 2010. All rights reserved.
//

#import "FASTFaceAppDelegate.h"
#import "MainViewController.h"
#import "ResultViewController.h"
#import "FASTFaceModel.h"

@implementation FASTFaceAppDelegate

@synthesize window;
@synthesize mainViewController;
@synthesize resultViewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	DLog(@"Loading ResultViewController");
	resultViewController = [[ResultViewController alloc] init];
	
	DLog(@"Loading MainViewController");
	mainViewController = [[MainViewController alloc] init];
    mainViewController.view.frame = [[UIScreen mainScreen] applicationFrame];
	
	mainViewController.resultView = resultViewController;
	
	[window addSubview:mainViewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	DLog(@"Low Memory Warning!!");
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc {
	[resultViewController release];
	[mainViewController release];
	[faceModel release];
	[window release];
	
	[super dealloc];
}


@end
