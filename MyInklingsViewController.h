//
//  MyInklingsViewController.h
//  Inkle
//
//  Created by Chad Heise on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Inklings.h"

@interface MyInklingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    
}

@property (weak, nonatomic) IBOutlet UIButton *myInklingDate;
@property (weak, nonatomic) IBOutlet UITableView *myInklingTable;

- (void)pushAnotherView;
@end
