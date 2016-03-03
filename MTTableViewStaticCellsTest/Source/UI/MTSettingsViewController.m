//
//  MTSettingsViewController.m
//  MTSettingsTest
//
//  Created by Mark Tezza on 17.02.16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "MTSettingsViewController.h"
#import "MTSettingsUpdate.h"

@interface MTSettingsViewController ()

@end

@implementation MTSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MTSettingsUpdate *settings = [MTSettingsUpdate new];
    [settings loadSettingsWithViewController:self];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(notificationKeyboardWillShow:)
               name:UIKeyboardWillShowNotification
             object:nil];
    
    [nc addObserver:self selector:@selector(notificationKeyboardWillHide:)
               name:UIKeyboardWillHideNotification
             object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Notifications

- (void)notificationKeyboardWillShow:(NSNotification *)notification {
    NSLog(@"notificationKeyboardWillShow:\n%@", notification.userInfo);
}

- (void)notificationKeyboardWillHide:(NSNotification *)notification {
    NSLog(@"notificationKeyboardWillHide:\n%@", notification.userInfo);
}

#pragma mark -
#pragma mark Actions

- (IBAction)actiontextChanged:(UITextField *)sender {
    MTSettingsUpdate *settings = [MTSettingsUpdate new];
    [settings saveSettingsWithViewController:self];
}

- (IBAction)actionValueChanged:(id)sender {
    MTSettingsUpdate *settings = [MTSettingsUpdate new];
    [settings saveSettingsWithViewController:self];
}

- (IBAction)actionMuteAudio:(UISwitch *)sender {
    self.soundSlider.enabled = sender.isOn;
    self.musicSlider.enabled = sender.isOn;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.loginField]) {
        [self.passwordField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
