//
//  ViewController.m
//  MTTableViewDynamicCellsTestPartOne
//
//  Created by Mark Tezza on 02.03.16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "ViewController.h"

#import "MTStudent.h"
#import "MTGroups.h"

#import "MTRamdomValues.h"
#import "UIColor+MTExtension.h"

static NSString * const kMTKeyName = @"firstName";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)   UITableView             *tableView;
@property (nonatomic, strong)   NSArray                 *studentsArray;
@property (nonatomic, strong)   NSMutableArray          *mutableGroups;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createStudents];
    [self sortingInGroups];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mutableGroups.count + 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section > 3) {
        return @"Custom Group";
    } else {
        return [[self.mutableGroups objectAtIndex:section] name];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section > 3) {
        return 10;
    } else {
        MTGroups *group = [self.mutableGroups objectAtIndex:section];
        return group.students.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section > 3) {
        static NSString *customIdentifier = @"customCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customIdentifier];
        }
        
        [self settingCell:cell];
        
        return cell;
    } else {
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        
        // level pupil
        /*
         [self settingCell:cell];
         */
        
        // level student
        /*
         [self settingCell:cell indexRow:indexPath.row];
         */
        
        //level master
        /*
         [self settingCell:cell indexRow:indexPath.row];
         */
        
        // level superMan
        [self settingCell:cell indexPath:indexPath];
        
        return cell;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Private

- (void)settingCell:(UITableViewCell *)cell {
    float r = MTRandomFloat();
    float g = MTRandomFloat();
    float b = MTRandomFloat();
    
    cell.textLabel.text = [NSString stringWithFormat:@"RGB {%.f, %.f, %.f}", r*100, g*100, b*100];
    cell.textLabel.textColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    cell.textLabel.shadowColor = [UIColor blackColor];
    cell.textLabel.shadowOffset = CGSizeMake(1, -1);
    cell.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
}

//level student
/*
- (void)settingCell:(UITableViewCell *)cell indexRow:(NSUInteger)index{
    MTStudent *student = [self.students objectAtIndex:index];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", student.name];
    cell.textLabel.textColor = student.color;
}
 */

//level master
/*
- (void)settingCell:(UITableViewCell *)cell indexRow:(NSUInteger)index {
    MTStudent *student = [self.studentsArray objectAtIndex:index];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.surname];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", student.average];
    
    if (student.average < 4) {
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.textLabel.textColor = [UIColor redColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        cell.textLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    }
}
 */

// level superMan

- (void)settingCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    MTGroups *group = [self.mutableGroups objectAtIndex:indexPath.section];
    MTStudent *student = [group.students objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.surname];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", student.average];
    
    if (indexPath.section == 3) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
    } else {
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    }
}

#pragma mark -
#pragma mark Private

- (void)createStudents {
    NSMutableArray *arrayStudents = [NSMutableArray array];
    for (NSUInteger i = 0; i < 30; i++) {
        MTStudent *student = [MTStudent student];
        [arrayStudents addObject:student];
    }
    
    self.studentsArray = arrayStudents;
}

- (void)sortingInGroups {
    NSMutableArray *better = [NSMutableArray array];
    NSMutableArray *normal = [NSMutableArray array];
    NSMutableArray *low = [NSMutableArray array];
    NSMutableArray *bad = [NSMutableArray array];
    
    for (MTStudent *student in self.studentsArray) {
        if (student.average <= 3) {
            [bad addObject:student];
        } else if (student.average <= 6) {
            [low addObject:student];
        } else if (student.average <= 10) {
            [normal addObject:student];
        } else {
            [better addObject:student];
        }
    }
    
    NSMutableArray *groups = [NSMutableArray array];
    [groups addObject:better];
    [groups addObject:normal];
    [groups addObject:low];
    [groups addObject:bad];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = 0; i < 4; i++) {
        MTGroups *group = [[MTGroups alloc] init];
        group.students = [groups objectAtIndex:i];
        group.name = [NSString stringWithFormat:@"GROUP #%lu", i];
        
        group.students = [self sortingArrayWithArray:group.students];
        [array addObject:group];
    }
    
    self.mutableGroups = array;
}

- (NSArray *)sortingArrayWithArray:(NSArray *)array {
    NSArray *arrayObjects = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if (obj1 && obj2) {
            return [[obj1 name] compare:[obj2 name]];
        } else if (obj1) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    return arrayObjects;
}

@end
