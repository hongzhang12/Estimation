//
//  RoomDetailCell.m
//  Estimation
//
//  Created by zhanghong on 16/4/18.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "RoomDetailCell.h"

@interface RoomDetailCell()

@property (nonatomic ,weak) UIImageView *headerImageView;
@property (nonatomic ,weak) UILabel *problemLabel;
@property (nonatomic ,weak) UILabel *priceLabel;

@end

@implementation RoomDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpView];
    }
    
    return self;
}

- (void)setUpView{
    
    UIImageView *headerImageView = [[UIImageView alloc] init];
    
    headerImageView.layer.cornerRadius = 10.0f;
    headerImageView.clipsToBounds = YES;
    
    [self.contentView addSubview:headerImageView];
    self.headerImageView = headerImageView;
    
    [headerImageView alignLeadingEdgeWithView:self.contentView predicate:@"15"];
    [headerImageView alignCenterYWithView:self.contentView predicate:@"0"];
    [headerImageView constrainWidth:@"20" height:@"20"];
    
    UILabel *problemLabel = [[UILabel alloc] init];
    problemLabel.clipsToBounds = YES;
    
    [self.contentView addSubview:problemLabel];
    self.problemLabel = problemLabel;
    
    [problemLabel alignCenterYWithView:self.contentView predicate:@"0"];
    [problemLabel constrainLeadingSpaceToView:headerImageView predicate:@"10"];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    
    [self.contentView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    [priceLabel alignCenterYWithView:self.contentView predicate:@"0"];
    [priceLabel alignTrailingEdgeWithView:self.contentView predicate:@"-10"];
    [priceLabel constrainLeadingSpaceToView:problemLabel predicate:@"10"];
    
    [priceLabel setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
    
    [self setData];
}

- (void)setData{
    
    self.headerImageView.image = [UIImage imageNamed:@"别墅.jpg"];
    
    self.problemLabel.text = arc4random()%2?@"Appliances/Cooktop/Not Working,Broken Or DamagedAppliances/Cooktop/Not Working,Broken Or Damaged":@"Appliances/Cooktop/Not Working,Broken Or Damaged";
    
    self.priceLabel.text = @"$80.00";
    
    [self layoutIfNeeded];
}

@end
