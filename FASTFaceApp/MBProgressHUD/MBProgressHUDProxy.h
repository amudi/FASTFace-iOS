//
//  MBMainThreadProxy.h
//  HudDemo
//
//  Created by Jon on 6/26/10.
//  Copyright 2010 Jonathan Sterling. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MBProgressHUDProxy : NSProxy
@property (nonatomic, retain) id target;
@end

@interface NSObject (MBMainThreadProxy)
- onMainThread;
@end