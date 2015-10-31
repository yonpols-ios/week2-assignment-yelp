//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpBusiness.h"
#import "BusinessTableViewCell.h"

@interface MainViewController () <UISearchBarDelegate, UITableViewDelegate>
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

    self.resultsTable.estimatedRowHeight = 100;
    self.resultsTable.rowHeight = UITableViewAutomaticDimension;
    self.resultsTable.delegate = self;
    self.resultsTable.dataSource = (id<UITableViewDataSource>) self;
    
    UINib *cellNib = [UINib nibWithNibName:@"BusinessTableViewCell" bundle:nil];
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
    BusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"businessCell"];
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


@end
