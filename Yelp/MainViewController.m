//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MainViewController.h"
#import "YelpBusiness.h"
#import "BusinessCell.h"
#import "FiltersViewController.h"

@interface MainViewController () <CLLocationManagerDelegate, UISearchBarDelegate, UITableViewDelegate, MKMapViewDelegate, FiltersViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITableView *resultsTable;
@property (weak, nonatomic) IBOutlet MKMapView *resultsMap;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) NSArray *businesses;

@property (strong, nonatomic) NSString *searchTerm;
@property (strong, nonatomic) YelpFilters *filters;
@property (assign, nonatomic) long nextOffset;

@property (strong, nonatomic) UIImage *filterImage;
@property (strong, nonatomic) UIImage *mapImage;
@property (strong, nonatomic) UIImage *listImage;


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
    

    self.filterImage = [[UIImage imageNamed:@"filter"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.mapImage = [[UIImage imageNamed:@"map"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.listImage = [[UIImage imageNamed:@"list"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:self.filterImage landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(filterButtonClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:self.mapImage landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(mapListButtonClicked)];

    self.resultsTable.estimatedRowHeight = 100;
    self.resultsTable.rowHeight = UITableViewAutomaticDimension;
    self.resultsTable.delegate = self;
    self.resultsTable.dataSource = (id<UITableViewDataSource>) self;
    
    UINib *cellNib = [UINib nibWithNibName:@"BusinessCell" bundle:nil];
    [self.resultsTable registerNib:cellNib forCellReuseIdentifier:@"businessCell"];
    
    self.resultsMap.delegate = self;
    
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

- (void) mapListButtonClicked {
    if (self.resultsMap.hidden) {
        self.navigationItem.rightBarButtonItem.image = self.listImage;
        [UIView transitionFromView:self.resultsTable
                            toView:self.resultsMap
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews
                        completion:^(BOOL finished) {
                            if (finished) {
                            }
                        }];
    } else {
        self.navigationItem.rightBarButtonItem.image = self.mapImage;
        [UIView transitionFromView:self.resultsMap
                            toView:self.resultsTable
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews
                        completion:^(BOOL finished) {
                            if (finished) {
                            }
                        }];
    }
}

#pragma mark private methods

- (void) reloadMapData:(NSDictionary *)region {
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake([region[@"center"][@"latitude"] doubleValue], [region[@"center"][@"longitude"] doubleValue]);
    MKCoordinateSpan span = MKCoordinateSpanMake([region[@"span"][@"latitude_delta"] doubleValue], [region[@"span"][@"longitude_delta"] doubleValue]);
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(center, span);
    [self.resultsMap removeAnnotations:self.resultsMap.annotations];
    
    MKUserLocation *userLocation = self.resultsMap.userLocation;
    
    for (YelpBusiness *business in self.businesses) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake([business.latitude doubleValue], [business.longitude doubleValue]);
        annotation.title = business.name;
        annotation.subtitle = business.address;
        [self.resultsMap addAnnotation:annotation];
    }

    [self.resultsMap addAnnotation:userLocation];

    [self.resultsMap setRegion:coordinateRegion animated:YES];
    [self.resultsMap regionThatFits:coordinateRegion];
}

- (void) searchBusinesses:(NSString *)searctTerm andFilters:(nullable YelpFilters *)filters offset:(long)offset {
    NSString *controlledSearchTerm = searctTerm;
    if (controlledSearchTerm.length == 0) {
        controlledSearchTerm = @"Restaurants";
    }

    [YelpBusiness searchWithTerm:controlledSearchTerm
                         filters:filters
                          offset:offset
                        location:self.currentLocation
                      completion:^(NSArray *businesses, NSDictionary *region, long nextOffset, NSError *error) {
                          if (!error) {
                              
                              if (offset > 0) {
                                  self.businesses = [self.businesses arrayByAddingObjectsFromArray:businesses];
                                  self.resultsTable.tableFooterView = nil;
                              } else {
                                  self.businesses = businesses;
                              }
                              self.nextOffset = nextOffset;
                              [self.resultsTable reloadData];
                              [self reloadMapData:region];
                          }
                      }];
    
}

@end
