//
//  MTSettingsViewController.h
//  MTSettingsTest
//
//  Created by Mark Tezza on 17.02.16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTSettingsViewController : UITableViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField          *loginField;
@property (strong, nonatomic) IBOutlet UITextField          *passwordField;

@property (strong, nonatomic) IBOutlet UISegmentedControl   *levelControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl   *detalizationControl;

@property (strong, nonatomic) IBOutlet UISlider             *soundSlider;
@property (strong, nonatomic) IBOutlet UISlider             *musicSlider;

@property (strong, nonatomic) IBOutlet UISwitch             *shadowSwitch;
@property (strong, nonatomic) IBOutlet UISwitch             *muteSwitch;

- (IBAction)actiontextChanged:(UITextField *)sender;
- (IBAction)actionValueChanged:(id)sender;
- (IBAction)actionMuteAudio:(UISwitch *)sender;

@end
