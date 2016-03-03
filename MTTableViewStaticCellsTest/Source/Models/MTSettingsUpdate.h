//
//  MTSettingsUpdate.h
//  MTSettingsTest
//
//  Created by Mark Tezza on 01.03.16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTSettingsViewController;

@interface MTSettingsUpdate : NSObject

- (void)saveSettingsWithViewController:(MTSettingsViewController *)viewController;
- (void)loadSettingsWithViewController:(MTSettingsViewController *)viewController;


@end
