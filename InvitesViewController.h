//
//  InvitesViewController.h
//  Inkle
//
//  Created by mobiapps on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *invites;
@property (weak, nonatomic) IBOutlet UITableView *invitesTable;
- (IBAction)btnAccept:(id)sender;
- (IBAction)btnDecline:(id)sender;



@end
