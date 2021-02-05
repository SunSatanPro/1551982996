//
//  SPYPlantsKnowFeatureViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsKnowFeatureViewController.h"
#import "SPY_PlantsKnow_DtCell.h"
#import "SPYPlantSectionView.h"
#import "SPYPlants_KnowRelativeTableViewCell.h"

@interface SPYPlantsKnowFeatureViewController ()

@property (weak, nonatomic) IBOutlet UITableView *SPY_PlantsFeatureTableView;

@property (nonatomic , strong) NSMutableArray <SPYPlantsKnowModel *> *SPYPlantsKnowRelativeData;
@end

@implementation SPYPlantsKnowFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"详情";
    [self.SPY_PlantsFeatureTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPY_PlantsKnow_DtCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SPY_PlantsKnow_DtCell class])];
    [self.SPY_PlantsFeatureTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPYPlants_KnowRelativeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SPYPlants_KnowRelativeTableViewCell class])];
    [self.SPY_PlantsFeatureTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPYPlantSectionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SPYPlantSectionView class])];
    
    [self SPY_fetchRelativePlantsData];
}


- (void)SPY_fetchRelativePlantsData {
    
    NSMutableArray *plantsKnowRelativeData = [SPYPlantsJsonTool SPY_FetchPlantsKnowData];
    self.SPYPlantsKnowRelativeData =  [NSMutableArray array];
    [plantsKnowRelativeData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SPYPlantsKnowModel *plantsKnowModel = [SPYPlantsKnowModel mj_objectWithKeyValues:obj];
        if (![plantsKnowModel.plantsKnowTitle isEqual:self.plantsKnowModel.plantsKnowTitle]) {
            [self.SPYPlantsKnowRelativeData addObject:plantsKnowModel];
        }
    }];
    [self.SPY_PlantsFeatureTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        SPYPlantsKnowFeatureViewController *plantsKnowFeature_VC = [SPYPlantsKnowFeatureViewController new];
        plantsKnowFeature_VC.plantsKnowModel = self.SPYPlantsKnowRelativeData[indexPath.row];
        [self.navigationController pushViewController:plantsKnowFeature_VC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.SPYPlantsKnowRelativeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SPY_PlantsKnow_DtCell *plants_infoCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SPY_PlantsKnow_DtCell class])];
        plants_infoCell.plantsKnowModel = self.plantsKnowModel;
        
        return plants_infoCell;
    }else {
        SPYPlants_KnowRelativeTableViewCell *relativeInfoCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SPYPlants_KnowRelativeTableViewCell class])];
        relativeInfoCell.plantsKnowModel = self.SPYPlantsKnowRelativeData[indexPath.row];
        
        return relativeInfoCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self.SPY_PlantsFeatureTableView fd_heightForCellWithIdentifier:NSStringFromClass([SPY_PlantsKnow_DtCell class]) configuration:^(SPY_PlantsKnow_DtCell *cell) {
            cell.plantsKnowModel = self.plantsKnowModel;
        }];
    }else {
        return 162;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    return 61.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        SPYPlantSectionView *plantsKnowheadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SPYPlantSectionView class])];
        plantsKnowheadView.SPY_PlantsSection_Label.text = @"相关技术";
        return plantsKnowheadView;
    }
    return [UIView new];
}


@end
