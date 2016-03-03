//
//  MTRandVal.m
//  iOSProject
//
//  Created by Student 111 on 9/16/15.
//  Copyright (c) 2015 Mark Tezza. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "MTRamdomValues.h"

float MTRandomFloat() {
    return arc4random() % 256 / 255.0f;
}