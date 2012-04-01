//
//  AppDelegateProtocol.h
//  Inkle
//
//  Created by mobiapps on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AppDataObject;

@protocol AppDelegateProtocol

- (AppDataObject *) theAppDataObject;

@end
