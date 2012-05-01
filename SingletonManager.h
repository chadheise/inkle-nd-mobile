//
//  SingletonManager.h
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonManager : NSObject{
    NSString *inklingType;//type of myinkling
    
}
@property (nonatomic, copy) NSString* inklingType;
+ (id) sharedInstance;


//+ (SingletonManager*)sharedManager;

//- (id)copyWithZone:(NSZone *)zone;

@end
