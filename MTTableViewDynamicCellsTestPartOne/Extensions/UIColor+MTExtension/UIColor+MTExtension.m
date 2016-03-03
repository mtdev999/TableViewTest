//
//  UIColor+MTExtension.m
//  iOSProject
//
//  Created by Mark Tezza on 12.09.15.
//  Copyright (c) 2015 Mark Tezza. All rights reserved.
//

#import "UIColor+MTExtension.h"
#include "MTRamdomValues.h"

@implementation UIColor (MTExtension)

+ (id)randomColor {
    CGFloat red = MTRandomFloat();
    CGFloat green = MTRandomFloat();
    CGFloat blue = MTRandomFloat();

    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
