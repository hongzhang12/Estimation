//
//  DetailCtrl.m
//  EstimationDemo
//
//  Created by zhanghong on 16/4/14.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "DetailCtrl.h"
#import "DetailInfoView.h"
#import "RoomDetailCell.h"
#import "UIImage+Addition.h"

#import "DetailEditCtrl.h"
#import "DetailCreateCtrl.h"
#import "DetailPresentationController.h"

static CGFloat KRoomTableViewCellPointHeight = 5.0f;

@interface DetailCtrl ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,weak) DetailInfoView *topInfoView;

@property (nonatomic ,weak) UITableView *roomTableView;

@property (nonatomic ,weak) UITableView *roomDetailTableView;

@property (nonatomic ,strong) DetailPresentationController *presentationController;

@end

@implementation DetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBColor(60, 176, 247);
}

- (void)setUpNavBar{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"美女.jpg"]];
}

- (void)setUpView{
    
    DetailInfoView *topInfoView = [[DetailInfoView alloc] init];
    
    [self.view addSubview:topInfoView];
    self.topInfoView = topInfoView;
    
    [topInfoView alignTopEdgeWithView:self.view predicate:@"64"];
    [topInfoView alignLeading:@"0" trailing:@"0" toView:self.view];
    
    [topInfoView setData];
    
    UITableView *roomTableView = [[UITableView alloc] init];
    roomTableView.delegate = self;
    roomTableView.dataSource = self;
    roomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:roomTableView];
    self.roomTableView = roomTableView;
    
    [roomTableView constrainTopSpaceToView:topInfoView predicate:@"0"];
    [roomTableView alignBottomEdgeWithView:self.view predicate:@"0"];
    [roomTableView alignLeadingEdgeWithView:self.view predicate:@"0"];
    [roomTableView constrainWidth:@"200"];
    
    UITableView *roomDetailTableView = [[UITableView alloc] init];
    roomDetailTableView.delegate = self;
    roomDetailTableView.dataSource = self;
    roomDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:roomDetailTableView];
    self.roomDetailTableView = roomDetailTableView;
    
    [roomDetailTableView alignTop:@"0" bottom:@"0" toView:roomTableView];
    [roomDetailTableView constrainLeadingSpaceToView:roomTableView predicate:@"0"];
    [roomDetailTableView alignTrailingEdgeWithView:self.view predicate:@"0"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.roomTableView) {
        
        return 10;
    }else{
        
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.roomTableView) {
        
        static NSString *roomCellID = @"roomCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:roomCellID];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:roomCellID];
            cell.textLabel.text = @"room";
            
            cell.imageView.image = [UIImage imageWithColor:RGBColor(60, 176, 247) size:CGSizeMake(KRoomTableViewCellPointHeight, KRoomTableViewCellPointHeight)];
            cell.imageView.layer.cornerRadius = KRoomTableViewCellPointHeight/2;
        }
        
        return cell;
    }else{
        
        static NSString *roomDetailCellID = @"roomDetailCellID";
        RoomDetailCell *cell = (RoomDetailCell *)[tableView dequeueReusableCellWithIdentifier:roomDetailCellID];
        
        if (cell == nil) {
            
            cell = [[RoomDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:roomDetailCellID];
        }
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.roomDetailTableView) {
     
        DetailEditCtrl *editCtrl = [[DetailEditCtrl alloc] init];
        
        editCtrl.transitioningDelegate = self.presentationController;
        editCtrl.modalPresentationStyle = UIModalPresentationCustom;
        
        [self presentViewController:editCtrl animated:YES completion:nil];
    }
}

#pragma mark - getter and setter

- (UIPresentationController *)presentationController{
    
    if (_presentationController == nil) {
        
        _presentationController = [[DetailPresentationController alloc] init];
    }
    
    return _presentationController;
}

- (void)spliteViewCtrlTest{
    
    UIViewController *ctrl1 = [[UIViewController alloc] init];
    ctrl1.view.backgroundColor = RandomColor;
    
    UIViewController *ctrl2 = [[UIViewController alloc] init];
    ctrl2.view.backgroundColor = RandomColor;
    
    UISplitViewController *split = [[UISplitViewController alloc] init];
    
    split.viewControllers = @[ctrl1 ,ctrl2];
    
    [self addChildViewController:split];
    [self.view addSubview:split.view];
    
    [split.view constrainTopSpaceToView:self.topInfoView predicate:@"0"];
    [split.view alignLeading:@"0" trailing:@"0" toView:self.view];
    [split.view alignBaselineWithView:self.view predicate:@"0"];
    
    [split didMoveToParentViewController:self];
}

@end
