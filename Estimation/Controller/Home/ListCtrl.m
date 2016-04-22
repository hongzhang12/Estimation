   //
//  ListCtrl.m
//  EstimationDemo
//
//  Created by zhanghong on 16/4/14.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "ListCtrl.h"
#import "ListCell.h"
#import "DetailCtrl.h"
#import "Networking+User.h"
@interface ListCtrl ()<UITableViewDelegate ,UITableViewDataSource>

@end

@implementation ListCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RandomColor;
    
    [Networking getServiceAgentsWithEmail:@"1591320313@qq.com" success:^(id responseObject) {
        
        NSLog(@"");
    } failure:^(NSError *error) {
        
        NSLog(@"");
    }];
}

- (void)setUpView{
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 180;
    tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tableView];
    
    [tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
}

#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * const ListCellID = @"ListCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListCellID];
    if (cell == nil) {
        
        cell = [[ListCell alloc] init];
    }
    
    return cell;
}

#pragma mark - tableView DataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController pushViewController:[[DetailCtrl alloc] init] animated:YES];
}

@end
