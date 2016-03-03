//
//  MTSettingsUpdate.m
//  MTSettingsTest
//
//  Created by Mark Tezza on 01.03.16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "MTSettingsUpdate.h"

#import "MTSettingsViewController.h"

static NSString * const kMTSettingsLogin = @"login";
static NSString * const kMTSettingsPassword = @"password";
static NSString * const kMTSettingsLevel = @"level";
static NSString * const kMTSettingsShadows = @"shadows";
static NSString * const kMTSettingsDetalization = @"detalization";
static NSString * const kMTSettingsSound = @"sound";
static NSString * const kMTSettingsMusic = @"music";

static double kMTDoubleDefault = 0.5f;


@interface MTSettingsUpdate ()

@end

@implementation MTSettingsUpdate

#pragma mark -
#pragma mark Public

- (void)saveSettingsWithViewController:(MTSettingsViewController *)viewController {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:viewController.loginField.text forKey:kMTSettingsLogin];
    [userDefaults setObject:viewController.passwordField.text forKey:kMTSettingsPassword];
    [userDefaults setInteger:viewController.levelControl.selectedSegmentIndex forKey:kMTSettingsLevel];
    [userDefaults setInteger:viewController.detalizationControl.selectedSegmentIndex forKey:kMTSettingsDetalization];
    [userDefaults setBool:viewController.shadowSwitch.isOn forKey:kMTSettingsShadows];
    [userDefaults setDouble:viewController.soundSlider.value forKey:kMTSettingsSound];
    [userDefaults setDouble:viewController.musicSlider.value forKey:kMTSettingsMusic];
    
    [userDefaults synchronize];
}

- (void)loadSettingsWithViewController:(MTSettingsViewController *)viewController {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    viewController.loginField.text = [userDefaults objectForKey:kMTSettingsLogin];
    viewController.passwordField.text = [userDefaults objectForKey:kMTSettingsPassword];
    viewController.levelControl.selectedSegmentIndex = [userDefaults integerForKey:kMTSettingsLevel];
    viewController.detalizationControl.selectedSegmentIndex = [userDefaults integerForKey:kMTSettingsDetalization];
    viewController.shadowSwitch.on = [userDefaults boolForKey:kMTSettingsShadows];

    viewController.soundSlider.value =
    ( [userDefaults doubleForKey:kMTSettingsSound] > 0.8f ? kMTDoubleDefault : [userDefaults doubleForKey:kMTSettingsSound]);
    
    viewController.musicSlider.value =
    ( [userDefaults doubleForKey:kMTSettingsMusic] > 0.8f ? kMTDoubleDefault : [userDefaults doubleForKey:kMTSettingsMusic]);
    
    
}


@end
