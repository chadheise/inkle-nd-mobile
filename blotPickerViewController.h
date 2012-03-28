//
//  blotPickerViewController.h
//  Inkle
//
//  Created by Chad Heise on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface blotPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    __weak UIPickerView *blotPicker;
    __weak UILabel *resultsLabel;
}

@property (weak, nonatomic) IBOutlet UIPickerView *blotPicker;
@property (nonatomic, strong) NSMutableArray *blotNames;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

@end
