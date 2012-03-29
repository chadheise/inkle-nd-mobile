//
//  Invites.h
//  Inkle
//
//  Created by mobiapps on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Invites : NSObject

@property (nonatomic, copy) NSString *inviteID;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *description;

@end
