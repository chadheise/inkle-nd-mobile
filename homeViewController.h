//
//  homeViewController.h
//  Inkle
//
//  Created by Chad Heise on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *calendar;

- (void) hide:()Calendar;



@end
