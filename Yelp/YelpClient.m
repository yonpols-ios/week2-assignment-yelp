//
//  YelpClient.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpClient.h"
#import "YelpBusiness.h"

// You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
NSString * const kYelpConsumerKey = @"dV6-zlhDffKiuxOr_PNw3A";
NSString * const kYelpConsumerSecret = @"mkCwOmihq4dlQ4MOZY_9U5bh1OE";
NSString * const kYelpToken = @"4YoXM7-f0FSZIWDl0dMjiTmLrxVYUq03";
NSString * const kYelpTokenSecret = @"yjAOS-PATgE24FgIWMm0ypl_HXg";

@interface YelpClient ()

@end

@implementation YelpClient

// Singleton
+ (instancetype)sharedInstance {
    static YelpClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YelpClient alloc] init];
    });
    return instance;
}

- (instancetype)init {
    NSURL *baseURL = [NSURL URLWithString:@"https://api.yelp.com/v2/"];
    if (self = [super initWithBaseURL:baseURL consumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret]) {
        
        BDBOAuth1Credential *token = [BDBOAuth1Credential credentialWithToken:kYelpToken
                                                                       secret:kYelpTokenSecret
                                                                   expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term
                                  sortMode:(YelpSortMode)sortMode
                                  distance:(long)distance
                                categories:(NSArray *)categories
                                     deals:(BOOL)hasDeal
                                    offset:(long)offset
                                completion:(void (^)(NSArray *businesses, long nextOffset, NSError *error))completion {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSMutableDictionary *parameters = [@{
                                         @"offset": [NSNumber numberWithLong:offset],
                                         @"term": term,
                                         @"ll" : @"37.774866,-122.394556",
                                         @"sort": [NSNumber numberWithInt:sortMode]}
                                       mutableCopy];
    
    if (categories && categories.count > 0) {
        parameters[@"category_filter"] = [categories componentsJoinedByString:@","];
    }
    
    if (hasDeal) {
        parameters[@"deals_filter"] = [NSNumber numberWithBool:hasDeal];
    }
    
    if (distance > 0) {
        parameters[@"radius_filter"] = [NSNumber numberWithLong:distance];
    }
    
    
    NSLog(@"%@", parameters);
    
    return [self GET:@"search"
          parameters:parameters
             success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                 long nextOffset = 0;
                 long total = [responseObject[@"total"] longValue];
                 NSArray *businesses = responseObject[@"businesses"];
                 
                 if (offset + businesses.count < total) {
                     nextOffset = offset + businesses.count;
                 }
                 NSLog(@"total: %ld", total);

                 completion([YelpBusiness businessesFromJsonArray:businesses], nextOffset, nil);
             } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                 NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                 NSLog(@"%@",ErrorResponse);
                 
                 
                 completion(nil, 0, error);
             }];
}

@end
