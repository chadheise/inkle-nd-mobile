//
//  Invites.h
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Invitation : NSObject

@property (nonatomic, copy) NSString *inviteID;
@property (nonatomic, copy) NSString *locationType;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *locationID;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) UIImage *image;

@end
