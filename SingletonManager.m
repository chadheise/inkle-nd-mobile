//
//  SingletonManager.m
//  Inkle
//
//  Created by mobiapps on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingletonManager.h"

@implementation SingletonManager

@synthesize inklingType;

//static SingletonManager *sharedInstance = nil;
// Get the shared instance and create it if necessary.
+(SingletonManager *)sharedInstance {
    static dispatch_once_t pred;
    static SingletonManager *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[SingletonManager alloc] init];
    });
    return shared;
}
// Get the shared instance and create it if necessary.
/*+ (SingletonManager *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}*/


// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
    }
    
    return self;
}

// Your dealloc method will never be called, as the singleton survives for the duration of your app.
// However, I like to include it so I know what memory I'm using (and incase, one day, I convert away from Singleton).
-(void)dealloc
{
    // I'm never called!
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end

/*static SingletonManager *sharedGizmoManager = nil;

+ (SingletonManager*)sharedManager
{
    if (sharedGizmoManager == nil) {
        sharedGizmoManager = [[super allocWithZone:NULL] init];
    }
    return sharedGizmoManager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end*/
