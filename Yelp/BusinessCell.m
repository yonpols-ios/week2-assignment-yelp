//
//  BusinessCell.m
//  Yelp
//
//  Created by Juan Pablo Marzetti on 10/30/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "BusinessCell.h"
#import "UIImageView+AFNetworking.h"

@interface BusinessCell ()

@property (weak, nonatomic) IBOutlet UIImageView *businessImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starsImage;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodLabel;

@end

@implementation BusinessCell

- (void)awakeFromNib {
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
    self.businessImage.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) setBusiness:(YelpBusiness *)business {
    _business = business;
    self.nameLabel.text = business.name;
    self.distanceLabel.text = business.distance;
    self.reviewsLabel.text = [NSString stringWithFormat:@"%ld reviews", [business.reviewCount integerValue]];
    self.addressLabel.text = business.address;
    self.foodLabel.text = business.categories;

    [self.businessImage setImageWithURL:business.imageUrl];
    [self.starsImage setImageWithURL:business.ratingImageUrl];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
}

@end
