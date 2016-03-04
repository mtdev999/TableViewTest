//
//  MTWorker.h
//  MTTableViewEditing
//
//  Created by Mark Tezza on 04/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTWorker : NSObject
@property (nonatomic, strong)   NSString  *name;
@property (nonatomic, strong)   NSString  *surname;
@property (nonatomic, assign)   float     levelPerformance;

+ (MTWorker *)randomWorker;

@end
