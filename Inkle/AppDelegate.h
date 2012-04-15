//
//  AppDelegate.h
//  Inkle
//
//  Created by Chad Heise on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "othersInklingsNavigationController.h"
#import "othersInklingsViewController.h"
#import "AppDelegateProtocol.h"
#import "blotPickerViewController.h"


@class OthersInklingsDataObject;

//@interface AppDelegate : UIResponder <UIApplicationDelegate>
@interface AppDelegate : NSObject <UIApplicationDelegate, AppDelegateProtocol>
{
    UIWindow *window;
    UINavigationController *navController;
    OthersInklingsDataObject *theAppDataObject;
    IBOutlet blotPickerViewController *theBlotPickerViewController;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@property (nonatomic, retain) OthersInklingsDataObject *theAppDataObject;
@property (nonatomic, retain) NSDate *othersInklingsDate;
@property (nonatomic, retain) NSDate *myInklingsDate;
@property (nonatomic, retain) IBOutlet blotPickerViewController *theBlotPickerViewController;





/*-----------------------------------*/
//@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
