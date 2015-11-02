//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MainViewController.h"
#import "YelpBusiness.h"
#import "BusinessCell.h"
#import "FiltersViewController.h"

@interface MainViewController () <CLLocationManagerDelegate, UISearchBarDelegate, UITableViewDelegate, FiltersViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *resultsTable;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) NSArray *businesses;

@property (strong, nonatomic) NSString *searchTerm;
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
    self.searchTerm = defaultTerm;
    [self searchBusinesses:self.searchTerm andFilters:self.filters offset:0];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"businessCell"];
    cell.business = self.businesses[indexPath.row];
    
    if (self.nextOffset > 0 && indexPath.row == (self.businesses.count - 1)) {
        UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 50)];
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        loadingView.center = tableFooterView.center;
        [tableFooterView addSubview:loadingView];
        tableView.tableFooterView = tableFooterView;

        [self searchBusinesses:self.searchTerm andFilters:self.filters offset:self.nextOffset];
    }
    
    return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    self.searchTerm = self.searchBar.text;
    [self searchBusinesses:self.searchTerm andFilters:self.filters offset:0];
}

- (void) filtersViewController:(FiltersViewController *)filterViewController didChangeFilters:(YelpFilters *)filters {
    self.filters = filters;
    [self searchBusinesses:self.searchTerm andFilters:self.filters offset:0];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.currentLocation = newLocation;
}

#pragma mark events

- (void) filterButtonClicked {
    FiltersViewController *vc = [[FiltersViewController alloc] initWithFilters:self.filters];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

#pragma mark private methods

- (void) searchBusinesses:(NSString *)searctTerm andFilters:(nullable YelpFilters *)filters offset:(long)offset {
    NSString *controlledSearchTerm = searctTerm;
    if (controlledSearchTerm.length == 0) {
        controlledSearchTerm = @"Restaurants";
    }

    [YelpBusiness searchWithTerm:controlledSearchTerm
                         filters:filters
                          offset:offset
                        location:self.currentLocation
                      completion:^(NSArray *businesses, long nextOffset, NSError *error) {
                          if (!error) {
                              
                              if (offset > 0) {
                                  self.businesses = [self.businesses arrayByAddingObjectsFromArray:businesses];
                                  self.resultsTable.tableFooterView = nil;
                              } else {
                                  self.businesses = businesses;
                              }
                              self.nextOffset = nextOffset;
                              [self.resultsTable reloadData];
                          }
                      }];
    
}

@end
