//
//  BaseInfoView.h
//  EstimationDemo
//
//  Created by zhanghong on 16/4/15.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

// 抽象基类，不要使用，继承并实现基类addSubviewConstraints添加自定义布局

@class BaseInfoView;
typedef void(^SubviewConstraintsBlock)(BaseInfoView *infoView);

@interface BaseInfoView : UIView

@property (nonatomic ,weak) UIImageView *iconView;
@property (nonatomic ,weak) UILabel *addressLabel;
@property (nonatomic ,weak) UILabel *nameLabel;
@property (nonatomic ,weak) UILabel *timeLabel;
@property (nonatomic ,weak) UIButton *bedroomBtn;
@property (nonatomic ,weak) UIButton *bathroomBtn;
@property (nonatomic ,weak) UIButton *areaBtn;

//@property (nonatomic ,copy) SubviewConstraintsBlock constraintsBlock;

- (void)addSubviewConstraints;

- (void)setData;

- (void)setUpView;

@end
