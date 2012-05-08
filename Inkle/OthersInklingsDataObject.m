//
//  PickerAppDataObject.m
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OthersInklingsDataObject.h"

@implementation OthersInklingsDataObject
@synthesize selection;
@synthesize peopleGroup;
@synthesize pid;
@synthesize type;

@synthesize locationId;
@synthesize locationType;

#pragma mark -
#pragma mark -Memory management methods

-(void)dealloc
{
    //Release any properties declared as retain or copy
    self.selection = nil;
    self.peopleGroup = nil;
    self.pid = nil;
    self.type = nil;
    
    self.locationId = nil;
    self.locationType = nil;
}

@end
