//
//  specifyBlotsNetworksViewController.h
//  Inkle
//
//  Created by mobiapps on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class specifyBlotsNetworksViewController;

@protocol specifyBlotsNetworksViewControllerDelegate <NSObject>
-(void)specifyBlotsNetworksViewControllerDidCancel:
    (specifyBlotsNetworksViewController *)controller;
-(void)specifyBlotsNetworksViewControllerDidSave:(specifyBlotsNetworksViewController *)controller;
@end

@interface specifyBlotsNetworksViewController : UIViewController

@property (nonatomic, weak) id <specifyBlotsNetworksViewControllerDelegate> delegate;

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;

@end
