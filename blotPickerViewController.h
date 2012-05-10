//
//  blotPickerViewController.h
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define leftComponent 0
#define rightComponent 1

@interface BlotPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    __weak UIPickerView *picker;
}

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic, strong) NSMutableArray *blotNames;
@property (nonatomic, strong) NSMutableArray *networkNames;
@property (nonatomic, strong) NSMutableArray *categoryNames;
@property (nonatomic, strong) NSMutableArray *namesArr;
@property (weak, nonatomic) IBOutlet UILabel *bNLabel;



@end
