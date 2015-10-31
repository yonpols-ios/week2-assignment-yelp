//
//  YelpFilters.h
//  Yelp
//
//  Created by Juan Pablo Marzetti on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#ifndef YelpFilters_h
#define YelpFilters_h

#import <Foundation/Foundation.h>
#import "YelpClient.h"

@interface YelpFilters : NSObject

@property (strong, nonatomic) NSArray *categories;
@property (assign, nonatomic) YelpSortMode sortMode;
@property (assign, nonatomic) long distance;
@property (assign, nonatomic) BOOL showDeals;

@end


#endif /* YelpFilters_h */
