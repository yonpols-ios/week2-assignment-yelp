//
//  SwitchCell.m
//  Yelp
//
//  Created by Juan Pablo Marzetti on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SwitchCell.h"
#import "SevenSwitch.h"

@interface SwitchCell ()

@property (weak, nonatomic) IBOutlet UIView *switchContainerView;
@property (strong, nonatomic) SevenSwitch *valueSwitch;

@end

@implementation SwitchCell

- (void)awakeFromNib {
    // Initialization code
    self.valueSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 31)];
    [self.valueSwitch addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    self.valueSwitch.thumbImage = [UIImage imageNamed:@"yelp-off"];
    self.valueSwitch.onLabel.textColor = [UIColor whiteColor];
    self.valueSwitch.offLabel.textColor = [UIColor whiteColor];
    self.valueSwitch.offLabel.text = @"off";
    self.valueSwitch.onLabel.text = @"on";
    self.valueSwitch.inactiveColor = [UIColor colorWithRed:(189.0f/255.0f) green:(189.0f/255.0f) blue:(189.0f/255.0f) alpha:1.00f];
    self.valueSwitch.activeColor = self.valueSwitch.inactiveColor;
    self.valueSwitch.borderColor = self.valueSwitch.inactiveColor;
    self.valueSwitch.onTintColor = [UIColor colorWithRed:(27.0f/255.0f) green:(134.0f/255.0f) blue:(230.0f/255.0f) alpha:1.00f];
    self.valueSwitch.shadowColor = [UIColor whiteColor];

    [self.switchContainerView addSubview:self.valueSwitch];
}

- (void) setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void) setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self.valueSwitch setOn:on animated:animated];
}

- (void)valueChanged {
    self.valueSwitch.thumbImage = [UIImage imageNamed:(self.valueSwitch.on ? @"yelp-on" : @"yelp-off")];
    [self.delegate switchCell:self didUpdateValue:self.valueSwitch.on];
}


@end
