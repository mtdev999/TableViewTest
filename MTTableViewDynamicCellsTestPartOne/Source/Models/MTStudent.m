//
//  MTStudent.m
//  MTTableViewDynamicCellsTestPartOne
//
//  Created by Mark Tezza on 02.03.16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "MTStudent.h"
#import "MTRamdomValues.h"
#import "UIColor+MTExtension.h"

static NSString * const firstName[] = {
    @"Emily", @"James", @"Chloe", @"Jack", @"Megan", @"Alex", @"Charlotte", @"Ben", @"Emma", @"Daniel",
    @"Lauren", @"Tom", @"Ellie", @"Matthew", @"Hannah", @"Adam", @"Sophie", @"Sam", @"Katie", @"Ryan",
    @"Amy", @"Callum", @"Lucy", @"Thomas", @"Olivia", @"David", @"Holly", @"Joe", @"Jessica", @"Lewis",
    @"Georgia", @"Josh", @"Rebecca", @"Jake", @"Sarah", @"Harry", @"Caitlin", @"Liam", @"Beth", @"William",
    @"Bethany", @"Kieran", @"Molly", @"Luke", @"Grace", @"Connor", @"Rachel", @"Joshua", @"Laura", @"Charlie"
};

static NSString * const lastName[] = {
    @"Smith", @"Johnson", @"Williams", @"Jones", @"Brown", @"Davis", @"Miller", @"Wilson", @"Moore", @"Taylor",
    @"Anderson", @"Thomas", @"Jackson", @"White", @"Harris", @"Martin", @"Thompson", @"Garcia", @"Martinez", @"Robinson",
    @"Clark", @"Rodriguez", @"Lewis", @"Lee", @"Walker", @"Hall", @"Allen", @"Young", @"Hernandez", @"King",
    @"Wright", @"Lopez", @"Hill", @"Scott", @"Green", @"Adams", @"Baker", @"Gonzalez", @"Nelson", @"Carter",
    @"Mitchell", @"Perez", @"Roberts", @"Turner", @"Phillips", @"Campbell", @"Parker", @"Evans", @"Edwards", @"Collins"
};

static int countName = 50;

@implementation MTStudent

+ (MTStudent *)student {
    MTStudent *student = [[MTStudent alloc] init];
    student.name = [NSString stringWithFormat:@"%@", firstName[arc4random_uniform(countName)]];
    student.surname = [NSString stringWithFormat:@"%@", lastName[arc4random_uniform(countName)]];
    student.average = (float)(arc4random_uniform(1000) + 200)/ 100;
    student.color = [UIColor randomColor];
    
    return student;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

@end
