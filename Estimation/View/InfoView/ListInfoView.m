//
//  ListInfoView.m
//  EstimationDemo
//
//  Created by zhanghong on 16/4/15.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "ListInfoView.h"

@implementation ListInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.iconView.layer.cornerRadius = 10.0f;
    }
    return self;
}

- (void)addSubviewConstraints{
    
    [self.iconView alignTop:@"30" leading:@"30" toView:self];
    [self.iconView constrainWidth:@"300" height:@"180"];
    
    [self.addressLabel alignTopEdgeWithView:self predicate:@"15"];
    [self.addressLabel constrainLeadingSpaceToView:self.iconView predicate:@"10"];
    [self.addressLabel alignTrailingEdgeWithView:self predicate:@"-10"];
    
    [self.addressLabel setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal | UILayoutConstraintAxisVertical];
    
    [self.nameLabel alignLeading:@"0" trailing:@"0" toView:self.addressLabel];
    [self.nameLabel constrainTopSpaceToView:self.addressLabel predicate:@"10"];
    
    [self.timeLabel alignBottomEdgeWithView:self.iconView predicate:@"0@100"];
    [self.timeLabel constrainTopSpaceToView:self.nameLabel predicate:@"20"];
    [self.timeLabel alignLeadingEdgeWithView:self.addressLabel predicate:@"0"];
    
    [self.bedroomBtn constrainLeadingSpaceToView:self.timeLabel predicate:@"20"];
    [self.bedroomBtn alignTopEdgeWithView:self.timeLabel predicate:@"0"];
    [self.bedroomBtn alignBottomEdgeWithView:self.timeLabel predicate:@"0"];
    
    [self.iconView alignBottomEdgeWithView:self predicate:@"<=0"];
    [self.timeLabel alignBottomEdgeWithView:self predicate:@"0@500"];
}

- (void)setData{
    
    self.iconView.image = [UIImage imageNamed:@"别墅.jpg"];
    self.addressLabel.text = arc4random()%2?@"addressLabeladdressLabeladdressaddressLabeladdressLabeladdress":@"addressLabeladdressLabeladdressaddressLabeladdressLabeladdressaddressLabeladdressLabeladdressaddressLabeladdressLabeladdressaddressLabeladdressLabeladdressaddressLabeladdressLabeladdressaddressLabeladdressLabeladdressaddressLabeladdressLabeladdressaddressLabeladdressLabeladdressaddressLabeladdressLabeladdress";
    self.nameLabel.text = @"Jack Smith";
    self.timeLabel.text = @"2016-01-03 04:40 PM";
    
    [self.bedroomBtn setImage:[UIImage imageNamed:@"美女.jpg"] forState:UIControlStateNormal];
    [self.bedroomBtn setTitle:@"bedroomBtn" forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
}

@end
