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
@property (nonatomic, strong) UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *businesses;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.delegate = self;
    self.searchBar.text = @"Restaurants";
    [self.searchBar sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonClicked)];

    self.resultsTable.estimatedRowHeight = 100;
    self.resultsTable.rowHeight = UITableViewAutomaticDimension;
    self.resultsTable.delegate = self;
    self.resultsTable.dataSource = (id<UITableViewDataSource>) self;
    
    UINib *cellNib = [UINib nibWithNibName:@"BusinessCell" bundle:nil];
    [self.resultsTable registerNib:cellNib forCellReuseIdentifier:@"businessCell"];
    
    [self searchBarSearchButtonClicked:self.searchBar];
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

    [YelpBusiness searchWithTerm:searchBar.text
                        sortMode:YelpSortModeBestMatched
                      categories:@[@"burgers"]
                           deals:NO
                      completion:^(NSArray *businesses, NSError *error) {
                          if (!error) {
                              self.businesses = businesses;
                              [self.resultsTable reloadData];
                          }
                      }];
}

- (void) filtersViewController:(FiltersViewController *)filterViewController didChangeFilters:(NSDictionary *)filters {
    
}

- (void) filterButtonClicked {
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}


@end
