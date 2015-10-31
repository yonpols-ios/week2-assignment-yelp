//
//  FiltersViewController.m
//  Yelp
//
//  Created by Juan Pablo Marzetti on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "YelpConstants.h"
#import "FiltersViewController.h"
#import "SwitchCell.h"


@interface FiltersViewController () <UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *filtersTableView;

@property (nonatomic, readonly) NSDictionary *filters;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *sortOptions;
@property (nonatomic, strong) NSArray *distanceOptions;

@property (nonatomic, strong) NSMutableSet *selectedCategories;
@property (nonatomic, assign) long sortBy;
@property (nonatomic, strong) NSDictionary *distanceFilter;
@property (nonatomic, assign) BOOL showDeals;

@property (nonatomic, assign) BOOL isSortOptionsOpen;
@property (nonatomic, assign) BOOL isDistanceOptionsOpen;
@end

@implementation FiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButtonClicked)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButtonClicked)];
    
    self.filtersTableView.delegate = self;
    self.filtersTableView.dataSource = self;
    
    [self.filtersTableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"switchCell"];
    
    self.categories = yelpCategories();
    self.sortOptions = yelpSortOptions();
    self.distanceOptions = yelpDistanceOptions();
    self.isSortOptionsOpen = NO;

    self.selectedCategories = [NSMutableSet set];
    self.sortBy = 0;
    self.distanceFilter = self.distanceOptions[0];
    self.showDeals = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.categories.count;
        case 1:
            if (self.isSortOptionsOpen) {
                return self.sortOptions.count;
            } else {
                return 1;
            }
        case 2:
            if (self.isDistanceOptionsOpen) {
                return self.distanceOptions.count;
            } else {
                return 1;
            }
        case 3:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    switch (indexPath.section) {
        case 0:
            return [self tableView:tableView cellForCategoriesSection:indexPath];

        case 1:
            return [self tableView:tableView cellForSortOptionsSection:indexPath];

        case 2:
            return [self tableView:tableView cellForDistanceOptionsSection:indexPath];

        case 3:
            return [self tableView:tableView cellForOthersSection:indexPath];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // category, sort by, distance, deals
    return 4;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Category";
        case 1:
            return @"Sort By";
        case 2:
            return @"Distance";
        case 3:
            return @"Other";
        default:
            return @"Error";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 1:
            if (self.isSortOptionsOpen) {
                self.sortBy = indexPath.row;
            }
            self.isSortOptionsOpen = !self.isSortOptionsOpen;
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case 2:
            if (self.isDistanceOptionsOpen) {
                self.distanceFilter = self.distanceOptions[indexPath.row];
            }
            self.isDistanceOptionsOpen = !self.isDistanceOptionsOpen;
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}

- (void) switchCell:(SwitchCell *)switchCell didUpdateValue:(BOOL)value {
    NSIndexPath *indexPath = [self.filtersTableView indexPathForCell:switchCell];

    switch (indexPath.section) {
        case 0:
            if (value) {
                [self.selectedCategories addObject:self.categories[indexPath.row][@"code"]];
            } else {
                [self.selectedCategories removeObject:self.categories[indexPath.row][@"code"]];
            }
            break;

        case 3:
            self.showDeals = value;
            
        default:
            break;
    }
}

#pragma mark event actions

- (void) onCancelButtonClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onApplyButtonClicked {
    [self.delegate filtersViewController:self didChangeFilters:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark private methods

- (UITableViewCell *) tableView:(UITableView *)tableView cellForCategoriesSection:(NSIndexPath *)indexPath {
    SwitchCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
    switchCell.titleLabel.text = self.categories[indexPath.row][@"name"];
    switchCell.delegate = self;
    switchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    switchCell.on = [self.selectedCategories containsObject:self.categories[indexPath.row][@"code"]];
    
    return switchCell;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForSortOptionsSection:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self dequeueBasicCellForTableView:tableView];

    if (self.isSortOptionsOpen) {
        cell.textLabel.text = self.sortOptions[indexPath.row];

        if (self.sortBy == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cell.textLabel.text = self.sortOptions[self.sortBy];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForDistanceOptionsSection:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self dequeueBasicCellForTableView:tableView];

    if (self.isDistanceOptionsOpen) {
        NSDictionary *option = self.distanceOptions[indexPath.row];
        cell.textLabel.text = option[@"name"];
        
        if (self.distanceFilter == option) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cell.textLabel.text = self.distanceFilter[@"name"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForOthersSection:(NSIndexPath *)indexPath {
    SwitchCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
    switchCell.titleLabel.text = @"Show Deals";
    switchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    switchCell.on = self.showDeals;

    return switchCell;
}

- (UITableViewCell *)dequeueBasicCellForTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

@end
