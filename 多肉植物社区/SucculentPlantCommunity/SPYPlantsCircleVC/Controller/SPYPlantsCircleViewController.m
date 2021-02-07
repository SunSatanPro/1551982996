//
//  SPYPlantsCircleViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsCircleViewController.h"
#import "SPY_PlantCircleCell.h"
#import "SPY_PlantsCircleSayListViewController.h"
#import "SPY_PlantsUserPostCircleDataViewController.h"
@interface SPYPlantsCircleViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *SPY_PlantsCircleTableView;

@property (nonatomic , strong) NSMutableArray <SPYPlantsCircleModel *> *SPYPlantsCircleData;

@property (weak, nonatomic) IBOutlet UILabel *SPY_PlantsNoDataLabel;
@end

@implementation SPYPlantsCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"多肉圈子";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"SPY_RelaseCircle_Image"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(SPY_PlantsCirlceHandle)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SPY_fetchPlantCircleData) name:SPY_PlantsCircleNoti object:nil];
    [self SPY_PlantsCirlceListView];
}

- (void)SPY_PlantsCirlceHandle {
    [self showADComplete:^{
        [self.navigationController pushViewController:[SPY_PlantsUserPostCircleDataViewController new] animated:YES];
    }];
}

- (void)SPY_PlantsCirlceListView {
    [self.SPY_PlantsCircleTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPY_PlantCircleCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SPY_PlantCircleCell class])];
    
    
    [self SPY_fetchPlantCircleData];
    self.SPY_PlantsCircleTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.SPY_PlantsCircleTableView.mj_header endRefreshing];
    }];
}

- (void)SPY_fetchPlantCircleData {
    self.SPYPlantsCircleData = [NSMutableArray array];
    NSMutableArray *plantsCircleData = [SPYPlantsJsonTool SPY_FetchPlantsCircleData];
    
    [plantsCircleData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SPYPlantsCircleModel *plantsModel = [SPYPlantsCircleModel mj_objectWithKeyValues:obj];
        if ([plantsModel.State isEqualToString:@"0"]) {
            if (self.SPY_MineLikeCirlce) {
                if ([plantsModel.SPYIsLike isEqualToString:@"1"]) {
                    [self.SPYPlantsCircleData addObject:plantsModel];
                }
               
            }else {
                [self.SPYPlantsCircleData addObject:plantsModel];
            }
        }
        
    }];
    self.SPYPlantsCircleData = [NSMutableArray arrayWithArray:[self.SPYPlantsCircleData reverseObjectEnumerator].allObjects];
    self.SPY_PlantsNoDataLabel.hidden = self.SPYPlantsCircleData.count == 0 ? NO : YES;
    [self.SPY_PlantsCircleTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showADComplete:^{
        SPY_PlantsCircleSayListViewController *plants_circleVC = [SPY_PlantsCircleSayListViewController new];
        plants_circleVC.plantsModel = self.SPYPlantsCircleData[indexPath.row];
        [self.navigationController pushViewController:plants_circleVC animated:YES];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.SPYPlantsCircleData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPY_PlantCircleCell *plantsCircleCell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SPY_PlantCircleCell class])];
    plantsCircleCell.plantsModel = self.SPYPlantsCircleData[indexPath.row];
    return plantsCircleCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.SPY_PlantsCircleTableView fd_heightForCellWithIdentifier:NSStringFromClass([SPY_PlantCircleCell class]) configuration:^(SPY_PlantCircleCell *cell) {
        cell.plantsModel = self.SPYPlantsCircleData[indexPath.row];
    }];
}



@end
