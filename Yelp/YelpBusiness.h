//
//  YelpBusiness.h
//  Yelp
//
//  Created by Nicholas Aiwazian on 10/24/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "YelpClient.h"
#import "YelpFilters.h"

@interface YelpBusiness : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) NSString *categories;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSURL *ratingImageUrl;
@property (strong, nonatomic) NSNumber *reviewCount;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (NSArray *)businessesFromJsonArray:(NSArray *)jsonArray;

+ (void)searchWithTerm:(NSString *)term
               filters:(YelpFilters *)filters
                offset:(long)offset
              location:(CLLocation *)location
            completion:(void (^)(NSArray *businesses, NSDictionary *region, long nextOffset, NSError *error))completion;

@end
