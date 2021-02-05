//
//  SPYPlantsNoSatisfyViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsNoSatisfyViewController.h"
#import "SPYInfoPlantsListCell.h"
@interface SPYPlantsNoSatisfyViewController ()
@property (nonatomic , strong) NSMutableArray <NSString *> *SPY_BlackPlantsList;
@property (weak, nonatomic) IBOutlet UITableView *SPY_PlantsNoSatisfyTableView;
@property (weak, nonatomic) IBOutlet UILabel *SPY_NoPlantsLabel;
@end

@implementation SPYPlantsNoSatisfyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"黑名单列表";
    [self SPY_NOPlantsView];
}

- (void)SPY_NOPlantsView {
    [self.SPY_PlantsNoSatisfyTableView registerNib:[UINib  nibWithNibName:NSStringFromClass([SPYInfoPlantsListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SPYInfoPlantsListCell class])];
    [self SPY_PlantsNoSatisfyData];
}

- (void)SPY_PlantsNoSatisfyData {
    
    self.SPY_BlackPlantsList = [NSMutableArray array];
    [self.SPY_BlackPlantsList addObjectsFromArray:[SPYPlantsJsonTool SPY_fetchPlantsBlackData]];
    self.SPY_NoPlantsLabel.hidden = self.SPY_BlackPlantsList.count == 0 ? NO  : YES;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.SPY_BlackPlantsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPYInfoPlantsListCell *plantsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SPYInfoPlantsListCell class])];
    [plantsCell.SPYPlantBtn setTitle:self.SPY_BlackPlantsList[indexPath.row] forState:UIControlStateNormal];
    
    return plantsCell;
}

-  (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67.f;
}


@end
