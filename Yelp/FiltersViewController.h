//
//  FiltersViewController.h
//  Yelp
//
//  Created by Juan Pablo Marzetti on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpFilters.h"

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void) filtersViewController:(FiltersViewController *)filterViewController didChangeFilters:(YelpFilters *)filters;

@end

@interface FiltersViewController : UIViewController

- (instancetype)initWithFilters:(YelpFilters *)filters;

@property (nonatomic, weak) id<FiltersViewControllerDelegate> delegate;

@end
