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
@property (nonatomic, strong) UIDatePicker *datePicker;

@end
