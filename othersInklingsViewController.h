//
//  othersInklingsViewController.h
//  Inkle
//
//  Created by Chad Heise on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface othersInklingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    //IBOutlet UITableView *tblView;
    
    //NSMutableArray *inklings;
    
}

@property (nonatomic, strong) NSMutableArray *inklings;
@property (weak, nonatomic) IBOutlet UITableView *inklingTable;
//@property (nonatomic, strong) UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inklingTypeSegment;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIButton *bNButton;

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitButton;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIButton *peopleButton;


@end
