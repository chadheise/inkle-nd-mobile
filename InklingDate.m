//
//  OthersInklingsDate.m
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InklingDate.h"

@implementation InklingDate
@synthesize dateString;
@synthesize date;

#pragma mark -
#pragma mark -Memory management methods

-(void)dealloc
{
    //Release any properties declared as retain or copy
    self.dateString = nil;
    self.date = nil;
}
- (NSString *)stringFromDate:(NSDate *)date2
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    return [dateFormat stringFromDate:date2];
}
@end