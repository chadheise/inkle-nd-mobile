//
//  othersInklingsViewController.h
//  Inkle
//
//  Created by Chad Heise on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface othersInklingsViewController : UIViewController <UITableViewDelegate>
{
    IBOutlet UITableView *tblView;
    
    NSMutableArray *inklings;
    
}

@end
