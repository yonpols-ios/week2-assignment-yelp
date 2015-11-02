//
//  YelpConstants.m
//  Yelp
//
//  Created by Juan Pablo Marzetti on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

NSArray *_yelpSelectedCategories = nil;
NSArray *_yelpCategories = nil;
NSArray *_yelpSortOptions = nil;
NSArray *_yelpDistanceOptions = nil;

NSArray *yelpSelectedCategories() {
    if (!_yelpSelectedCategories) {
        _yelpSelectedCategories = @[
                            @{@"code":@"argentine", @"name":@"Argentine"},
                            @{@"code":@"breakfast_brunch", @"name":@"Breakfast & Brunch"},
                            @{@"code":@"french", @"name":@"French"},
                            @{@"code":@"italian", @"name":@"Italian"},
                            @{@"code":@"latin", @"name":@"Latin American"},
                            @{@"code":@"mediterranean", @"name":@"Mediterranean"},
                            @{@"code":@"thai", @"name":@"Thai"}
                            ];
    }
    
    return _yelpSelectedCategories;
}

NSArray *yelpCategories() {
    if (!_yelpCategories) {
        _yelpCategories = @[
                            @{@"code":@"afghani", @"name":@"Afghan"},
                            @{@"code":@"african", @"name":@"African"},
                            @{@"code":@"arabian", @"name":@"Arabian"},
                            @{@"code":@"argentine", @"name":@"Argentine"},
                            @{@"code":@"armenian", @"name":@"Armenian"},
                            @{@"code":@"asianfusion", @"name":@"Asian Fusion"},
                            @{@"code":@"australian", @"name":@"Australian"},
                            @{@"code":@"austrian", @"name":@"Austrian"},
                            @{@"code":@"bangladeshi", @"name":@"Bangladeshi"},
                            @{@"code":@"basque", @"name":@"Basque"},
                            @{@"code":@"bbq", @"name":@"Barbeque"},
                            @{@"code":@"belgian", @"name":@"Belgian"},
                            @{@"code":@"bistros", @"name":@"Bistros"},
                            @{@"code":@"brasseries", @"name":@"Brasseries"},
                            @{@"code":@"brazilian", @"name":@"Brazilian"},
                            @{@"code":@"breakfast_brunch", @"name":@"Breakfast & Brunch"},
                            @{@"code":@"british", @"name":@"British"},
                            @{@"code":@"buffets", @"name":@"Buffets"},
                            @{@"code":@"bulgarian", @"name":@"Bulgarian"},
                            @{@"code":@"burgers", @"name":@"Burgers"},
                            @{@"code":@"burmese", @"name":@"Burmese"},
                            @{@"code":@"cafes", @"name":@"Cafes"},
                            @{@"code":@"cafeteria", @"name":@"Cafeteria"},
                            @{@"code":@"cajun", @"name":@"Cajun/Creole"},
                            @{@"code":@"cambodian", @"name":@"Cambodian"},
                            @{@"code":@"caribbean", @"name":@"Caribbean"},
                            @{@"code":@"catalan", @"name":@"Catalan"},
                            @{@"code":@"cheesesteaks", @"name":@"Cheesesteaks"},
                            @{@"code":@"chicken_wings", @"name":@"Chicken Wings"},
                            @{@"code":@"chickenshop", @"name":@"Chicken Shop"},
                            @{@"code":@"chinese", @"name":@"Chinese"},
                            @{@"code":@"comfortfood", @"name":@"Comfort Food"},
                            @{@"code":@"creperies", @"name":@"Creperies"},
                            @{@"code":@"cuban", @"name":@"Cuban"},
                            @{@"code":@"czech", @"name":@"Czech"},
                            @{@"code":@"delis", @"name":@"Delis"},
                            @{@"code":@"diners", @"name":@"Diners"},
                            @{@"code":@"ethiopian", @"name":@"Ethiopian"},
                            @{@"code":@"filipino", @"name":@"Filipino"},
                            @{@"code":@"fishnchips", @"name":@"Fish & Chips"},
                            @{@"code":@"fondue", @"name":@"Fondue"},
                            @{@"code":@"food_court", @"name":@"Food Court"},
                            @{@"code":@"foodstands", @"name":@"Food Stands"},
                            @{@"code":@"french", @"name":@"French"},
                            @{@"code":@"gastropubs", @"name":@"Gastropubs"},
                            @{@"code":@"german", @"name":@"German"},
                            @{@"code":@"gluten_free", @"name":@"Gluten-Free"},
                            @{@"code":@"greek", @"name":@"Greek"},
                            @{@"code":@"halal", @"name":@"Halal"},
                            @{@"code":@"hawaiian", @"name":@"Hawaiian"},
                            @{@"code":@"himalayan", @"name":@"Himalayan/Nepalese"},
                            @{@"code":@"hotdog", @"name":@"Hot Dogs"},
                            @{@"code":@"hotdogs", @"name":@"Fast Food"},
                            @{@"code":@"hotpot", @"name":@"Hot Pot"},
                            @{@"code":@"hungarian", @"name":@"Hungarian"},
                            @{@"code":@"iberian", @"name":@"Iberian"},
                            @{@"code":@"indonesian", @"name":@"Indonesian"},
                            @{@"code":@"indpak", @"name":@"Indian"},
                            @{@"code":@"irish", @"name":@"Irish"},
                            @{@"code":@"italian", @"name":@"Italian"},
                            @{@"code":@"japanese", @"name":@"Japanese"},
                            @{@"code":@"kebab", @"name":@"Kebab"},
                            @{@"code":@"korean", @"name":@"Korean"},
                            @{@"code":@"kosher", @"name":@"Kosher"},
                            @{@"code":@"laotian", @"name":@"Laotian"},
                            @{@"code":@"latin", @"name":@"Latin American"},
                            @{@"code":@"malaysian", @"name":@"Malaysian"},
                            @{@"code":@"mediterranean", @"name":@"Mediterranean"},
                            @{@"code":@"mexican", @"name":@"Mexican"},
                            @{@"code":@"mideastern", @"name":@"Middle Eastern"},
                            @{@"code":@"modern_european", @"name":@"Modern European"},
                            @{@"code":@"mongolian", @"name":@"Mongolian"},
                            @{@"code":@"moroccan", @"name":@"Moroccan"},
                            @{@"code":@"newamerican", @"name":@"American (New)"},
                            @{@"code":@"pakistani", @"name":@"Pakistani"},
                            @{@"code":@"persian", @"name":@"Persian/Iranian"},
                            @{@"code":@"peruvian", @"name":@"Peruvian"},
                            @{@"code":@"pizza", @"name":@"Pizza"},
                            @{@"code":@"polish", @"name":@"Polish"},
                            @{@"code":@"portuguese", @"name":@"Portuguese"},
                            @{@"code":@"poutineries", @"name":@"Poutineries"},
                            @{@"code":@"raw_food", @"name":@"Live/Raw Food"},
                            @{@"code":@"russian", @"name":@"Russian"},
                            @{@"code":@"salad", @"name":@"Salad"},
                            @{@"code":@"sandwiches", @"name":@"Sandwiches"},
                            @{@"code":@"scandinavian", @"name":@"Scandinavian"},
                            @{@"code":@"scottish", @"name":@"Scottish"},
                            @{@"code":@"seafood", @"name":@"Seafood"},
                            @{@"code":@"singaporean", @"name":@"Singaporean"},
                            @{@"code":@"slovakian", @"name":@"Slovakian"},
                            @{@"code":@"soulfood", @"name":@"Soul Food"},
                            @{@"code":@"soup", @"name":@"Soup"},
                            @{@"code":@"southern", @"name":@"Southern"},
                            @{@"code":@"spanish", @"name":@"Spanish"},
                            @{@"code":@"srilankan", @"name":@"Sri Lankan"},
                            @{@"code":@"steak", @"name":@"Steakhouses"},
                            @{@"code":@"supperclubs", @"name":@"Supper Clubs"},
                            @{@"code":@"sushi", @"name":@"Sushi Bars"},
                            @{@"code":@"syrian", @"name":@"Syrian"},
                            @{@"code":@"taiwanese", @"name":@"Taiwanese"},
                            @{@"code":@"tapas", @"name":@"Tapas Bars"},
                            @{@"code":@"tapasmallplates", @"name":@"Tapas/Small Plates"},
                            @{@"code":@"tex-mex", @"name":@"Tex-Mex"},
                            @{@"code":@"thai", @"name":@"Thai"},
                            @{@"code":@"tradamerican", @"name":@"American (Traditional)"},
                            @{@"code":@"turkish", @"name":@"Turkish"},
                            @{@"code":@"ukrainian", @"name":@"Ukrainian"},
                            @{@"code":@"uzbek", @"name":@"Uzbek"},
                            @{@"code":@"vegan", @"name":@"Vegan"},
                            @{@"code":@"vegetarian", @"name":@"Vegetarian"},
                            @{@"code":@"vietnamese", @"name":@"Vietnamese"},
                            @{@"code":@"wok", @"name":@"Wok"}
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


