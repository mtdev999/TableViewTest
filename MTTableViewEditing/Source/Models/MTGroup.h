//
//  MTGroup.h
//  MTTableViewEditing
//
//  Created by Mark Tezza on 04/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTGroup : NSObject
@property (nonatomic, strong)   NSString    *name;
@property (nonatomic, strong)   NSArray     *workers;
@property (nonatomic, assign)   BOOL        groupWokersEmpty;

@end
