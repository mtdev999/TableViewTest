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
    self.mutableGroups = [NSMutableArray array];
    [self prepareTableView];
    [self addBarButtonItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Actions

- (void)actionAdding:(UIBarButtonItem *)sender {
    
    MTGroup *group = [[MTGroup alloc] init];
    group.name  = [NSString stringWithFormat:@"Group @%lu", self.mutableGroups.count + 1];
    group.workers = @[[NSObject new]];
    
    NSUInteger newIndex = 0;
    [self.mutableGroups insertObject:group atIndex:newIndex];
    
    NSIndexSet *newIndexSection = [NSIndexSet indexSetWithIndex:newIndex];
    [self.tableView beginUpdates];
    [self.tableView insertSections:newIndexSection withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
    
    [self suspendUserIteractions];
}

- (void)actionEditing:(UIBarButtonItem *)sender {
    BOOL isEditing = self.tableView.editing;
    [self.tableView setEditing:!isEditing animated:YES];
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    if (!isEditing) {
        item = UIBarButtonSystemItemDone;
    }
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                target:self
                                                                                action:@selector(actionEditing:)];
    [self.navigationItem setRightBarButtonItem:editButton animated:YES];
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
    
    if (indexPath.row == 0) {
        static NSString *firstcellIdentifier = @"firstcellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstcellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstcellIdentifier];
        }
        cell.textLabel.text = @"Add New Worker";
        cell.textLabel.textColor = [UIColor blueColor];
        
        return cell;
    } else {
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
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row > 0;
}

// Moving/reordering

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row > 0;
}

- (void)                tableView:(UITableView *)tableView
               moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
                      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    MTGroup *sourceGroup = [self.mutableGroups objectAtIndex:sourceIndexPath.section];
    MTWorker *worker = [sourceGroup.workers objectAtIndex:sourceIndexPath.row];
    
    NSMutableArray *tempArray =[NSMutableArray arrayWithArray:sourceGroup.workers];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [tempArray removeObject:worker];
        [tempArray insertObject:worker atIndex:destinationIndexPath.row];
        sourceGroup.workers = tempArray;
    } else {
        [tempArray removeObject:worker];
        sourceGroup.workers = tempArray;
        
        MTGroup *destinationGroup = [self.mutableGroups objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.workers];
        [tempArray insertObject:worker atIndex:destinationIndexPath.row];
        destinationGroup.workers = tempArray;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone | UITableViewCellEditingStyleDelete;
}

// Deleting

- (void)        tableView:(UITableView *)tableView
       commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTGroup *group = [self.mutableGroups objectAtIndex:indexPath.section];
    MTWorker *worker = [group.workers objectAtIndex:indexPath.row];
    NSMutableArray *tempArray =[NSMutableArray arrayWithArray:group.workers];
    
    [tempArray removeObject:worker];
    group.workers = tempArray;
    
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [tableView endUpdates];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        MTGroup *group = [self.mutableGroups objectAtIndex:indexPath.section];
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:group.workers];
        NSUInteger newIndex = 1;
        
        MTWorker *worker = [MTWorker randomWorker];
        [tempArray insertObject:worker atIndex:newIndex];
        group.workers = tempArray;
        
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:newIndex inSection:indexPath.section];
        [tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[newPath] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];
        
        [self suspendUserIteractions];
    }
    
}

- (NSIndexPath *)                   tableView:(UITableView *)tableView
     targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
                          toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.row == 0) {
        return sourceIndexPath;
    } else {
        return proposedDestinationIndexPath;
    }
}

#pragma mark -
#pragma mark Private

- (void)prepareTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //tableView.editing = YES;
    
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
            if (j == 0) {
                NSObject *object = [NSObject new];
                [workers addObject:object];
            } else {
                MTWorker *worker = [MTWorker randomWorker];
                [workers addObject:worker];
            }
            
        }
        group.workers = workers;
        [self.mutableGroups addObject:group];
    }
}

- (void)addBarButtonItems {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(actionAdding:)];
    self.navigationItem.leftBarButtonItem = addButton;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                               target:self
                                                                               action:@selector(actionEditing:)];
    self.navigationItem.rightBarButtonItem = editButton;
}

- (void)suspendUserIteractions{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

@end
