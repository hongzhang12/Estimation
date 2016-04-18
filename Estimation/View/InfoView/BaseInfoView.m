//
//  BaseInfoView.m
//  EstimationDemo
//
//  Created by zhanghong on 16/4/15.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "BaseInfoView.h"

@interface BaseInfoView()



@end

@implementation BaseInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.layer.masksToBounds = YES;
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.numberOfLines = 0;
    [self addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIButton *bedroomBtn = [[UIButton alloc] init];
    bedroomBtn.enabled = NO;
    bedroomBtn.clipsToBounds = YES;
    [self addSubview:bedroomBtn];
    self.bedroomBtn = bedroomBtn;
    
    UIButton *bathroomBtn = [[UIButton alloc] init];
    [self addSubview:bathroomBtn];
    self.bathroomBtn = bathroomBtn;
    
    UIButton *areaBtn = [[UIButton alloc] init];
    [self addSubview:areaBtn];
    self.areaBtn = areaBtn;
    
//    __weak typeof(self) weakSelf = self;
//    self.constraintsBlock(weakSelf);
    [self addSubviewConstraints];
}

- (void)addSubviewConstraints{
    
    
}

@end
