//
//  SwitchCell.m
//  Yelp
//
//  Created by Juan Pablo Marzetti on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SwitchCell.h"

@interface SwitchCell ()

@property (weak, nonatomic) IBOutlet UISwitch *valueSwitch;
- (IBAction)valueChanged:(UISwitch *)sender;

@end

@implementation SwitchCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)valueChanged:(UISwitch *)sender {
    [self.delegate switchCell:self didUpdateValue:sender.on];
}

- (void) setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void) setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self.valueSwitch setOn:on animated:animated];
}


@end
