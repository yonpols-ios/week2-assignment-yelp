//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpBusiness.h"
#import "BusinessCell.h"
#import "FiltersViewController.h"

@interface MainViewController () <UISearchBarDelegate, UITableViewDelegate, FiltersViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *resultsTable;
@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *businesses;
@property (strong, nonatomic) YelpFilters *filters;
@property (assign, nonatomic) long nextOffset;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    static NSString *defaultTerm = @"Restaurants";
    
    self.searchBar = [[UISearchBar alloc] init];
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = defaultTerm;
    [self.searchBar sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonClicked)];

    self.resultsTable.estimatedRowHeight = 100;
    self.resultsTable.rowHeight = UITableViewAutomaticDimension;
    self.resultsTable.delegate = self;
    self.resultsTable.dataSource = (id<UITableViewDataSource>) self;
    
    UINib *cellNib = [UINib nibWithNibName:@"BusinessCell" bundle:nil];
    [self.resultsTable registerNib:cellNib forCellReuseIdentifier:@"businessCell"];
    
    self.filters = [[YelpFilters alloc] init];
    [self searchBusinesses:defaultTerm andFilters:nil offset:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"businessCell"];
    cell.business = self.businesses[indexPath.row];
    
    return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    [self searchBusinesses:searchBar.text andFilters:self.filters offset:0];
}

- (void) filtersViewController:(FiltersViewController *)filterViewController didChangeFilters:(YelpFilters *)filters {
    self.filters = filters;
    NSString *searchTerm = self.searchBar.text;
    if (searchTerm.length == 0) {
        searchTerm = self.searchBar.placeholder;
    }
    
    [self searchBusinesses:searchTerm andFilters:self.filters offset:0];
}

- (void) filterButtonClicked {
    FiltersViewController *vc = [[FiltersViewController alloc] initWithFilters:self.filters];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void) searchBusinesses:(NSString *)searctTerm andFilters:(nullable YelpFilters *)filters offset:(long)offset {
    [YelpBusiness searchWithTerm:searctTerm
                         filters:filters
                          offset:offset
                      completion:^(NSArray *businesses, long nextOffset, NSError *error) {
                          if (!error) {
                              self.businesses = businesses;
                              self.nextOffset = nextOffset;
                              [self.resultsTable reloadData];
                          }
                      }];
    
}

@end
