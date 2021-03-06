//
//  AppDelegate.h
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "othersInklingsNavigationController.h"
#import "othersInklingsViewController.h"
#import "AppDelegateProtocol.h"
#import "BlotPickerViewController.h"
#import "DateViewController.h"


@class OthersInklingsDataObject;
@class InklingDate;

//@interface AppDelegate : UIResponder <UIApplicationDelegate>
@interface AppDelegate : NSObject <UIApplicationDelegate, AppDelegateProtocol>
{
    UIWindow *window;
    UINavigationController *navController;
    OthersInklingsDataObject *globalOthersInklingsDataObject;
    IBOutlet BlotPickerViewController *theBlotPickerViewController;
    NSString *othersInklingsDate;
    IBOutlet DateViewController *theOthersInklingsDateViewController;
    NSDate *myInklingsDate;
    
    InklingDate *globalInklingDate;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@property (nonatomic, retain) NSString *othersInklingsDate;
@property (nonatomic, retain) IBOutlet DateViewController *theOthersInklingsDateViewController;

@property (nonatomic, retain) NSDate *myInklingsDate;

@property (nonatomic, retain) OthersInklingsDataObject *globalOthersInklingsDataObject;
@property (nonatomic, retain) IBOutlet BlotPickerViewController *theBlotPickerViewController;

@property (nonatomic, retain) InklingDate *globalInklingDate;

/*-----------------------------------*/

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
