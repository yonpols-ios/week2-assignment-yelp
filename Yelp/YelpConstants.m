//
//  YelpConstants.m
//  Yelp
//
//  Created by Juan Pablo Marzetti on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

NSArray *_yelpCategories = nil;
NSArray *_yelpSortOptions = nil;
NSArray *_yelpDistanceOptions = nil;

NSArray *yelpCategories() {
    if (!_yelpCategories) {
        _yelpCategories = @[
  @{@"code":@"active", @"name":@"Active Life"},
  @{@"code":@"arts", @"name":@"Arts & Entertainment"},
  @{@"code":@"auto", @"name":@"Automotive"},
  @{@"code":@"beautysvc", @"name":@"Beauty & Spas"},
  @{@"code":@"education", @"name":@"Education"},
  @{@"code":@"eventservices", @"name":@"Event Planning & Services"},
  @{@"code":@"financialservices", @"name":@"Financial Services"},
  @{@"code":@"food", @"name":@"Food"},
  @{@"code":@"health", @"name":@"Health & Medical"},
  @{@"code":@"homeservices", @"name":@"Home Services"},
  @{@"code":@"hotelstravel", @"name":@"Hotels & Travel"},
  @{@"code":@"localflavor", @"name":@"Local Flavor"},
  @{@"code":@"localservices", @"name":@"Local Services"},
  @{@"code":@"massmedia", @"name":@"Mass Media"},
  @{@"code":@"nightlife", @"name":@"Nightlife"},
  @{@"code":@"pets", @"name":@"Pets"},
  @{@"code":@"professional", @"name":@"Professional Services"},
  @{@"code":@"publicservicesgovt", @"name":@"Public Services & Government"},
  @{@"code":@"religiousorgs", @"name":@"Religious Organizations"},
  @{@"code":@"restaurants", @"name":@"Restaurants"},
  @{@"code":@"shopping", @"name":@"Shopping"},
                            
                            ];
    }
    
    return _yelpCategories;
}

NSArray *yelpSortOptions() {
    if (!_yelpSortOptions) {
        _yelpSortOptions = @[@"Best matched", @"Distance", @"Highest Rated"];
    }
    
    return _yelpSortOptions;
}

NSArray *yelpDistanceOptions() {
    if (!_yelpDistanceOptions) {
        _yelpDistanceOptions = @[
                                 @{@"name": @"Best matched", @"value":@(0)},
                                 @{@"name": @"0.3 miles", @"value":@(500)},
                                 @{@"name": @"1 mile", @"value":@(1600)},
                                 @{@"name": @"5 miles", @"value":@(8000)},
                                 @{@"name": @"20 miles", @"value":@(32000)}
                                 ];
    }
    
    return _yelpDistanceOptions;
}


