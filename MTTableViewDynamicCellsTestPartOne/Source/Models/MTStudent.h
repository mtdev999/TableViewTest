//
//  MTStudent.h
//  MTTableViewDynamicCellsTestPartOne
//
//  Created by Mark Tezza on 02.03.16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MTStudent : NSObject
@property (nonatomic, strong)   NSString    *name;
@property (nonatomic, strong)   NSString    *surname;
@property (nonatomic, strong)   UIColor     *color;
@property (nonatomic, assign)   double      average;

+ (MTStudent *)student;

@end
