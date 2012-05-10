//
//  PickerAppDataObject.h
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "peopleGroups.h"

@interface OthersInklingsDataObject : NSObject
{
    NSString* selection;
    peopleGroups *peopleGroup;
    NSString *pid;
    NSString *type;
    
    NSString *locationId;
    NSString *locationType;
    
}

@property (nonatomic, copy) NSString* selection;
@property (nonatomic, copy) peopleGroups *peopleGroup;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *locationId;
@property (nonatomic, copy) NSString *locationName;
@property (nonatomic, copy) NSString *locationType;

@end
