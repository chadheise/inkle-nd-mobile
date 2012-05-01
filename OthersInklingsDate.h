//
//  OthersInklingsDate.h
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OthersInklingsDate : NSObject
{
    NSString* dateString;
    NSDate* date;    
}

@property (nonatomic, copy) NSString* dateString;
@property (nonatomic, copy) NSDate *date;

- (NSString *)stringFromDate:(NSDate *)date;

@end
