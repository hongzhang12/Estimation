//
//  MapInfoView.m
//  EstimationDemo
//
//  Created by zhanghong on 16/4/15.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "MapInfoView.h"

static CGFloat const kArrorHeight = 10.0f;

@implementation MapInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.addressLabel.textColor = [UIColor blackColor];
        self.nameLabel.textColor = [UIColor blackColor];
        self.timeLabel.textColor = [UIColor blackColor];
        
        self.iconView.layer.cornerRadius = 5.0f;
    }
    return self;
}

- (void)addSubviewConstraints{
    
    [self.iconView alignTop:@"15" leading:@"15" toView:self];
    [self.iconView constrainWidth:@"150" height:@"90"];
    
    [self.addressLabel alignTopEdgeWithView:self predicate:@"15"];
    [self.addressLabel constrainLeadingSpaceToView:self.iconView predicate:@"10"];
    [self.addressLabel alignTrailingEdgeWithView:self predicate:@"-10"];
    
    [self.addressLabel setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal | UILayoutConstraintAxisVertical];
    
    [self.nameLabel alignLeading:@"0" trailing:@"0" toView:self.addressLabel];
    [self.nameLabel constrainTopSpaceToView:self.addressLabel predicate:@"10"];
    
//    [self.timeLabel alignBottomEdgeWithView:self.iconView predicate:@"0@100"];
    [self.timeLabel constrainTopSpaceToView:self.nameLabel predicate:@"20"];
    [self.timeLabel alignLeadingEdgeWithView:self.addressLabel predicate:@"0"];
    [self.timeLabel alignTrailingEdgeWithView:self.addressLabel predicate:@"0"];
    
    [self.bedroomBtn alignLeadingEdgeWithView:self.addressLabel predicate:@"0"];
    [self.bedroomBtn constrainTopSpaceToView:self.timeLabel predicate:@"10"];
    [self.bedroomBtn alignBottomEdgeWithView:self.iconView predicate:@"0@100"];
    
    [self.iconView alignBottomEdgeWithView:self predicate:[NSString stringWithFormat:@"<=%f",-kArrorHeight]];
    [self.bedroomBtn alignBottomEdgeWithView:self predicate:[NSString stringWithFormat:@"%f@500",-kArrorHeight]];
}

- (void)setData{
    
    self.iconView.image = [UIImage imageNamed:@"别墅.jpg"];
    self.addressLabel.text = @"addressLabeladdressLabeladdressLabel";
    self.nameLabel.text = @"nameLabelnameLabelnameLabe";
    self.timeLabel.text = @"timeLabel";
    
    [self.bedroomBtn setImage:[UIImage imageNamed:@"美女.jpg"] forState:UIControlStateNormal];
    [self.bedroomBtn setTitle:@"bed" forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
}

- (void)drawRect:(CGRect)rect{
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
}

- (void)drawInContext:(CGContextRef)context{
    
    CGContextSetLineWidth(context, 2.0f);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGRect rect = self.bounds;
    CGFloat radius = 6.0f;
    CGFloat minx = CGRectGetMinX(rect),
    midx = CGRectGetMidX(rect),
    maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect),
    maxy = CGRectGetMaxY(rect) - kArrorHeight;
    
    CGContextMoveToPoint(context, midx + kArrorHeight, maxy);
    CGContextAddLineToPoint(context, midx, maxy + kArrorHeight);
    CGContextAddLineToPoint(context, midx - kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
    
    CGContextFillPath(context);
}
@end
