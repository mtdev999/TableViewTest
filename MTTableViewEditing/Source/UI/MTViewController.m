//
//  MTViewController.m
//  MTTableViewEditing
//
//  Created by Mark Tezza on 03.03.16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "MTViewController.h"

#import "MTWorker.h"
#import "MTGroup.h"

@interface MTViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)   UITableView     *tableView;
@property (nonatomic, strong)   NSMutableArray     *mutableGroups;

@end

@implementation MTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"TableView Editing Test";
    
    [self prepareTableView];
    [self createGroupsWithWorkers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mutableGroups.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.mutableGroups objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MTGroup *group = [self.mutableGroups objectAtIndex:section];
    
    return group.workers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    MTGroup *group = [self.mutableGroups objectAtIndex:indexPath.section];
    MTWorker *worker = [group.workers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", worker.name, worker.surname];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", worker.levelPerformance];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Moving/reordering

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)                tableView:(UITableView *)tableView
               moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
                      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone | UITableViewCellEditingStyleDelete;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Private

- (void)prepareTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.editing = YES;
    
    [self.tableView reloadData];
}

- (void)createGroupsWithWorkers {
    self.mutableGroups = [NSMutableArray array];
    
    NSUInteger countGroups = (arc4random_uniform(300) + 300) / 100;
    NSUInteger countWorkers = (arc4random_uniform(700) + 300) / 100;
    
    for (NSUInteger i = 0; i < countGroups; i++) {
        MTGroup *group = [[MTGroup alloc] init];
        group.name = [NSString stringWithFormat:@"Group #%lu", i];
       
        
        NSMutableArray *workers = [NSMutableArray array];
        for (NSUInteger j = 0; j < countWorkers; j++) {
            MTWorker *worker = [MTWorker randomWorker];
            [workers addObject:worker];
        }
        group.workers = workers;
        [self.mutableGroups addObject:group];
    }
}

@end
