//
//  AppDelegateProtocol.h
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class OthersInklingsDataObject;
@class InklingDate;

@protocol AppDelegateProtocol

- (OthersInklingsDataObject *) theAppDataObject;
- (InklingDate *) theAppDataObject2;
- (NSString *) othersInklingsDate;

@end
