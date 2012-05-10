//
//  othersInklingsViewController.h
//  Inkle
//
//  Created by Chad Heise on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OthersInklingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    
}

@property (nonatomic, strong) NSMutableArray *inklings;
@property (weak, nonatomic) IBOutlet UITableView *inklingTable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inklingTypeSegment;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIButton *bNButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UIButton *peopleButton;



@end
