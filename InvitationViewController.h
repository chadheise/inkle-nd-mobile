//
//  InvitesViewController.h
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *invites;
@property (weak, nonatomic) IBOutlet UITableView *invitesTable;
- (IBAction)btnAccept:(id)sender;
- (IBAction)btnDecline:(id)sender;



@end
