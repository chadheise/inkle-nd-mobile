//
//  PickerAppDataObject.m
//  Inkle
//
//  Created by mobiapps on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PickerAppDataObject.h"

@implementation PickerAppDataObject
@synthesize selection;

#pragma mark -
#pragma mark -Memory management methods

-(void)dealloc
{
    //Release any properties declared as retain or copy
    self.selection = nil;
}

@end
