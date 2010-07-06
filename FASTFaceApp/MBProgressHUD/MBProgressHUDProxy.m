//
//  MBMainThreadProxy.m
//  HudDemo
//
//  Created by Jon on 6/26/10.
//  Copyright 2010 Jonathan Sterling. All rights reserved.
//

#import "MBProgressHUDProxy.h"


@implementation MBProgressHUDProxy
@synthesize target;

- (void)forwardInvocation:(NSInvocation *)invocation {
	if ([self.target respondsToSelector:invocation.selector]) {
		[invocation performSelectorOnMainThread:@selector(invokeWithTarget:) 
																 withObject:self.target
															waitUntilDone:YES];
	}
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
	return [self.target methodSignatureForSelector:sel];
}

- (void)dealloc {
	self.target = nil;
	[super dealloc];
}

@end


@implementation NSObject (MBMainThreadProxy)

- onMainThread {
	MBProgressHUDProxy *p = [MBProgressHUDProxy alloc];
	p.target = self;
	
	return [p autorelease];
}

@end
