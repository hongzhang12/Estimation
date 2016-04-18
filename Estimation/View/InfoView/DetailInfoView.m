//
//  DetailInfoView.m
//  EstimationDemo
//
//  Created by zhanghong on 16/4/15.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "DetailInfoView.h"

@interface DetailInfoView()

@property (nonatomic ,weak) UILabel *priceLabel;

@end

@implementation DetailInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.iconView.layer.cornerRadius = 5.0f;
        
        self.addressLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.timeLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setUpView{
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.font = [UIFont systemFontOfSize:36];
    
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    [super setUpView];
}

- (void)addSubviewConstraints{
    
    [self.iconView alignTop:@"15" leading:@"15" toView:self];
    [self.iconView constrainWidth:@"150" height:@"90"];
    
    [self.addressLabel alignTopEdgeWithView:self predicate:@"15"];
    [self.addressLabel constrainLeadingSpaceToView:self.iconView predicate:@"10"];
    [self.addressLabel constrainWidth:@"400"];
    
    [self.addressLabel setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal | UILayoutConstraintAxisVertical];
    
    [self.nameLabel alignLeadingEdgeWithView:self.addressLabel predicate:@"0"];
    [self.nameLabel constrainTopSpaceToView:self.addressLabel predicate:@"10"];
    
    [self.nameLabel setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
    
    //    [self.timeLabel alignBottomEdgeWithView:self.iconView predicate:@"0@100"];
    [self.timeLabel alignTopEdgeWithView:self.nameLabel predicate:@"0"];
    [self.timeLabel constrainLeadingSpaceToView:self.nameLabel predicate:@"10"];
    [self.timeLabel alignTrailingEdgeWithView:self.addressLabel predicate:@"0"];
    
    [self.bedroomBtn alignLeadingEdgeWithView:self.addressLabel predicate:@"0"];
    [self.bedroomBtn constrainTopSpaceToView:self.nameLabel predicate:@"10"];
    [self.bedroomBtn alignBottomEdgeWithView:self.iconView predicate:@"0@100"];
    
    [self.iconView alignBottomEdgeWithView:self predicate:@"<=0"];
    [self.bedroomBtn alignBottomEdgeWithView:self predicate:@"0@500"];
    
    [self.priceLabel alignTop:@"0" bottom:@"0" toView:self];

    [self.priceLabel alignTrailingEdgeWithView:self predicate:@"-40"];
}

- (void)setData{
    
    self.iconView.image = [UIImage imageNamed:@"别墅.jpg"];
    self.addressLabel.text = @"addressLabeladdressLabeladdressLabeladdressLabeladdressLabeladdressLabel";
    self.nameLabel.text = @"Jack Smith";
    self.timeLabel.text = @"timeLabel";
    
    [self.bedroomBtn setImage:[UIImage imageNamed:@"美女.jpg"] forState:UIControlStateNormal];
    [self.bedroomBtn setTitle:@"bed" forState:UIControlStateNormal];
    
    self.priceLabel.text = @"$2000,00";
    
    [self layoutIfNeeded];
}

@end
