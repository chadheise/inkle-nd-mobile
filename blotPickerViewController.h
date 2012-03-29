//
//  blotPickerViewController.h
//  Inkle
//
//  Created by Chad Heise on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define leftComponent 0
#define rightComponent 1

@interface blotPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    __weak UIPickerView *picker;
    __weak UILabel *resultsLabel;
}

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic, strong) NSMutableArray *blotNames;
@property (nonatomic, strong) NSMutableArray *networkNames;
@property (nonatomic, strong) NSMutableArray *categoryNames;
@property (nonatomic, strong) NSMutableArray *namesArr;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

-(IBAction) buttonPressed;

@end
