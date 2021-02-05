//
//  SPY_PlantsCircleSayListViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPY_PlantsCircleSayListViewController.h"
#import "SPY_PlantCircleCell.h"
#import "SPYPlantsCircleSayCell.h"
#import "SPYPlantSectionView.h"
@interface SPY_PlantsCircleSayListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *SPY_PlantsCircleSayTableView;

@property (nonatomic , strong) NSMutableArray <SPYPlantsCircleSayModel *> *SPY_plantsSayData;

@property (weak, nonatomic) IBOutlet UITextField *SPY_plantsSayTextField;
@end

@implementation SPY_PlantsCircleSayListViewController

- (IBAction)SPY_userRelasePlantsSay:(id)sender {
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
        if (self.SPY_plantsSayTextField.text.length < 1) {
            [SVProgressHUD SPY_ShowPlantsErrortext:@"请输入你要发表的评论内容"];
            return;
        }
        NSMutableArray *plantsSayArray = [NSMutableArray arrayWithArray:self.plantsModel.plantsCommentArray];
        SPYPlantsCircleSayModel *plantsSayModel = [SPYPlantsCircleSayModel new];
        plantsSayModel.commentTime = [SPYPlantsJsonTool SPY_FetchNowadaysStr];
        plantsSayModel.isZan = @"0";
        plantsSayModel.State = @"0";
        plantsSayModel.plantsCMText = self.SPY_plantsSayTextField.text;
        plantsSayModel.plantsCMfabuRen = [SPYPlantsJsonTool SPY_FtechPlantUserName];

        [SVProgressHUD showWithStatus:@"发布中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.8 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [plantsSayArray addObject:plantsSayModel.mj_keyValues];
            self.plantsModel.plantsCommentArray = plantsSayArray;
            [SPYPlantsJsonTool SPY_ModifyPlantCircleData:self.plantsModel];
            [SVProgressHUD SPY_ShowPlantsTruertext:@"评论发布成功!"];
            self.SPY_plantsSayTextField.text = @"";
        });
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帖子详情";
    [self.SPY_PlantsCircleSayTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPY_PlantCircleCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SPY_PlantCircleCell class])];
    [self.SPY_PlantsCircleSayTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPYPlantsCircleSayCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SPYPlantsCircleSayCell class])];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SPY_FetchPlantsSayData) name:SPY_PlantsCircleNoti object:nil];
    [self SPY_LayoutPlantsSayListUI];
}

- (void)SPY_LayoutPlantsSayListUI {

    [self.SPY_PlantsCircleSayTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPYPlantSectionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SPYPlantSectionView class])];
    
    [self SPY_FetchPlantsSayData];
}

- (void)SPY_FetchPlantsSayData {
    self.SPY_plantsSayData = [NSMutableArray array];
    [self.plantsModel.plantsCommentArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SPYPlantsCircleSayModel *plantsReviwerData = [SPYPlantsCircleSayModel mj_objectWithKeyValues:obj];
        if ([plantsReviwerData.State intValue] == 0) {
            [self.SPY_plantsSayData addObject:plantsReviwerData];
        }
    }];
    
    self.SPY_plantsSayData = (NSMutableArray *)[[self.SPY_plantsSayData reverseObjectEnumerator] allObjects];
    [self.SPY_PlantsCircleSayTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==1) {
        return self.SPY_plantsSayData.count;
    }
    return 1;
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SPY_PlantCircleCell *plantsCircleCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SPY_PlantCircleCell class])];
        plantsCircleCell.SPY_PlantsFeature  = YES;
        plantsCircleCell.plantsModel = self.plantsModel;
        return plantsCircleCell;
    }else {
        SPYPlantsCircleSayCell *plantsSayCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SPYPlantsCircleSayCell class])];
        plantsSayCell.plantModel = self.plantsModel;
        plantsSayCell.plantSayModel = self.SPY_plantsSayData[indexPath.row];
        return plantsSayCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self.SPY_PlantsCircleSayTableView fd_heightForCellWithIdentifier:NSStringFromClass([SPY_PlantCircleCell class]) configuration:^(SPY_PlantCircleCell *mouseTieZiCell) {
            mouseTieZiCell.SPY_PlantsFeature = YES;
            mouseTieZiCell.plantsModel  = self.plantsModel;
        }];
    }else {
        return [self.SPY_PlantsCircleSayTableView fd_heightForCellWithIdentifier:NSStringFromClass([SPYPlantsCircleSayCell class]) configuration:^(SPYPlantsCircleSayCell *cell) {
            cell.plantModel = self.plantsModel;
            cell.plantSayModel = self.SPY_plantsSayData[indexPath.row];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section ==  0) {
        return 0;
    }
    return 61.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section  ==  1) {
        SPYPlantSectionView *plantsSayView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SPYPlantSectionView class])];
        plantsSayView.SPY_PlantsSection_Label.text = @"所有评论";
        return plantsSayView;
    }
    return [UIView new];
}



@end
