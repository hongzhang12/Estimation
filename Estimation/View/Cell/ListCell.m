
//
//  ListCell.m
//  Estimation
//
//  Created by zhanghong on 16/4/15.
//  Copyright (c) 2016年 zhanghong. All rights reserved.
//

#import "ListCell.h"
#import "ListInfoView.h"
@interface ListCell()

@property (nonatomic ,weak) ListInfoView *infoView;

@end

@implementation ListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpView];
    }
    
    return self;
}

- (void)setUpView{
    
    ListInfoView *infoView = [[ListInfoView alloc] init];
    
    [self.contentView addSubview:infoView];
    self.infoView = infoView;
    
    [infoView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.contentView];

    [infoView setData];
}

@end
