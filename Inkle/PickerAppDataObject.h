//
//  PickerAppDataObject.h
//  Inkle
//
//  Created by mobiapps on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDataObject.h"

@interface PickerAppDataObject : AppDataObject
{
    NSString* selection;
}

@property (nonatomic, copy) NSString* selection;

@end
