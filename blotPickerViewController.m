//
//  blotPickerViewController.m
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BlotPickerViewController.h"
#import "peopleGroups.h"
#import "RXMLElement.h"
#import "OthersInklingsDataObject.h"
#import "AppDelegateProtocol.h"

@implementation BlotPickerViewController {
    NSMutableArray *blotNames;
    NSMutableArray *networkNames;
    NSMutableArray *categoryNames;
    NSMutableArray *namesArr;
    NSString *bNSelection;//set to the name of the blot or network
    NSString *peopleType;
    NSString *peopleId;
}
@synthesize picker;
@synthesize blotNames;//array of strings containing the user's blots
@synthesize networkNames;//array of strings containing the user's networks
@synthesize categoryNames;//array of strings containing the words 'Blots' or 'Networks'
@synthesize namesArr;//array of peopleGroups containing either blotNames or networkNames--it is modified depending on user selection
@synthesize bNLabel;
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
- (OthersInklingsDataObject *) theAppDataObject
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    OthersInklingsDataObject *theDataObject;
    theDataObject = (OthersInklingsDataObject*) theDelegate.theAppDataObject;
    return theDataObject;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *green = UIColorFromRGB(0x288D42);
    [[self view] setBackgroundColor:green];
    [bNLabel setBackgroundColor:green];
    
    self.categoryNames = [[NSMutableArray alloc] initWithObjects: @"Blots",@"Networks",nil];
    
    //Get blots
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/getPeopleGroups/blots/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    RXMLElement *responseXML = [RXMLElement elementFromXMLData:responseData];
    NSString *numBlotsString = [[responseXML child:@"blots"] attribute:@"number"];
    NSInteger numBlots = [numBlotsString integerValue];
        
    self.blotNames = [NSMutableArray arrayWithCapacity:numBlots];
    
    [responseXML iterate:@"blot" with:^(RXMLElement *b) {
        peopleGroups *blot = [[peopleGroups alloc]init];
        blot.pid = [NSString stringWithFormat:@"%@", [b child:@"id"]];
        blot.name = [NSString stringWithFormat:@"%@", [b child:@"name"]];
        blot.type = @"blot";
        [blotNames addObject:blot];        
    }];
    
    //Get networks
    url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/getPeopleGroups/networks/"];
    request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    responseXML = [RXMLElement elementFromXMLData:responseData];
    NSString *numNetworksString = [[responseXML child:@"networks"] attribute:@"number"];
    NSInteger numNetworks = [numNetworksString integerValue];
    
    self.networkNames = [NSMutableArray arrayWithCapacity:numNetworks];
    
    [responseXML iterate:@"network" with:^(RXMLElement *n) {
        peopleGroups *network = [[peopleGroups alloc]init];
        network.pid = [NSString stringWithFormat:@"%@", [n child:@"id"]];
        network.name = [NSString stringWithFormat:@"%@", [n child:@"name"]];
        network.type = @"network";
        [networkNames addObject:network];        
    }];
    
    //Preload picker with blots
    self.namesArr = self.blotNames; 

}
- (void)viewDidAppear:(BOOL)animated
{
    //Get previous selection
    OthersInklingsDataObject* theDataObject = [self theAppDataObject];
    if (theDataObject.selection != NULL){
        UIColor *white = UIColorFromRGB(0xFFFFFF);
        [bNLabel setBackgroundColor:white];
        bNLabel.text = theDataObject.selection;
    }

    NSInteger count = 0;
    if (theDataObject.type == @"blot")
    {
        [picker selectRow:0 inComponent:leftComponent animated:YES];
        self.namesArr = self.blotNames;
        
        //Find the location of the current selection, update picker display
        for (peopleGroups *grp in namesArr)
        {
            if([grp.name isEqualToString:theDataObject.selection]){
                [picker selectRow:count inComponent:rightComponent animated:YES];
                [picker reloadComponent:rightComponent];
                break;
            }
            count++;
        }
    }
    else if (theDataObject.type == @"network")
    {
        [picker selectRow:1 inComponent:leftComponent animated:YES];
        self.namesArr = self.networkNames;
        
        //Find the location of the current selection, update picker display
        for (peopleGroups *grp in namesArr)
        {
            if([grp.name isEqualToString:theDataObject.selection]){
                [picker selectRow:count inComponent:rightComponent animated:YES];
                [picker reloadComponent:rightComponent];
                break;
            }
            count++;
        }

    }
    
}
- (void)viewDidUnload
{
    [self setPicker:nil];
    self.categoryNames = nil;
    self.blotNames = nil;
    self.networkNames = nil;
    self.namesArr = nil;
    [self setBNLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (component == leftComponent)
        return [self.categoryNames count];
    return [self.namesArr count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if(component == leftComponent)
        return [self.categoryNames objectAtIndex:row];
    peopleGroups *group = [namesArr objectAtIndex:row];
    return group.name;
} 

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (component == leftComponent){
        NSString* selectedCat = [self.categoryNames objectAtIndex:row];
        if (selectedCat == @"Blots")
            self.namesArr = self.blotNames;
        else if(selectedCat == @"Networks")   
            self.namesArr = self.networkNames;
        [picker selectRow:0 inComponent:rightComponent animated:YES];
        [picker reloadComponent:rightComponent];
        
    }

    OthersInklingsDataObject *theDataObject = [self theAppDataObject];
    peopleGroups *ppl = [self.namesArr objectAtIndex:row];
    theDataObject.selection = ppl.name;
    theDataObject.pid = ppl.pid;
    theDataObject.type = ppl.type;
    //Update Label Display
    bNLabel.text = ppl.name;
    UIColor *white = UIColorFromRGB(0xFFFFFF);
    [bNLabel setBackgroundColor:white];

}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    switch (component){
        case 0: 
            return 110.0f;
        case 1: 
            return 180.0f;
    }
    return 0;
}

@end
