//
//  SPY_SatisfyPlantsKnowViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPY_SatisfyPlantsKnowViewController.h"
#import "SPYPlants_KnowRelativeTableViewCell.h"
#import "SPYPlantsKnowFeatureViewController.h"
@interface SPY_SatisfyPlantsKnowViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *SPY_SatisfyTableView;

@property (weak, nonatomic) IBOutlet UILabel *SPY_PlantsKnowEmptyDataLabel;

@property (nonatomic , strong) NSMutableArray <SPYPlantsKnowModel *> *SPYPlantsKnowData;

@end

@implementation SPY_SatisfyPlantsKnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SPY_FetchPlantsKnowData) name:SPY_PlantsKnowNoti object:nil];
    [self.SPY_SatisfyTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPYPlants_KnowRelativeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SPYPlants_KnowRelativeTableViewCell class])];
    self.SPY_SatisfyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.SPY_SatisfyTableView.mj_header endRefreshing];
    }];
    
    [self SPY_FetchPlantsKnowData];
    
}


- (void)SPY_FetchPlantsKnowData {
    self.SPYPlantsKnowData = [NSMutableArray array];
    NSMutableArray *SDA_MeetData = [SPYPlantsJsonTool SPY_FetchPlantsKnowData];
    [SDA_MeetData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SPYPlantsKnowModel *plantsKnowModel = [SPYPlantsKnowModel mj_objectWithKeyValues:obj];
        if ([plantsKnowModel.SPYIsLike intValue] == 1) {
            [self.SPYPlantsKnowData addObject:plantsKnowModel];
        }
        
    }];
    self.SPY_PlantsKnowEmptyDataLabel.hidden = self.SPYPlantsKnowData.count == 0 ? NO : YES;
    [self.SPY_SatisfyTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPYPlantsKnowFeatureViewController *plantsFeature_VC = [SPYPlantsKnowFeatureViewController new];
    plantsFeature_VC.plantsKnowModel = self.SPYPlantsKnowData[indexPath.row];
    [self.navigationController pushViewController:plantsFeature_VC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.SPYPlantsKnowData.count;
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPYPlants_KnowRelativeTableViewCell *plantsKnow_cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SPYPlants_KnowRelativeTableViewCell class])];
    plantsKnow_cell.plantsKnowModel = self.SPYPlantsKnowData[indexPath.row];
    return plantsKnow_cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 162;
}

@end
