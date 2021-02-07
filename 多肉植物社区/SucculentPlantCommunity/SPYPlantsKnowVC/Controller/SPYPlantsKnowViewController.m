//
//  SPYPlantsKnowViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsKnowViewController.h"
#import "SPYPlantsScrollReusableView.h"
#import "SPYTodayPlantsKnowCell.h"
#import "SPYPlantsListCell.h"
#import "SPYPlantsKnowFeatureViewController.h"
#import "SPY_PlantsCircleSayListViewController.h"
@interface SPYPlantsKnowViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *SPY_PlantCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *SPY_PlantsLayout;

@property (nonatomic , strong) NSMutableArray <SPYPlantsKnowModel *> *SPY_PlantsKnowScrollData;

@property (nonatomic , strong) SPYPlantsCircleModel *SPY_HotPlantsCircleModel;

@property (nonatomic , strong) NSMutableArray <SPYPlantsKnowModel *> *SPY_PlantsKnowListData;

@end

@implementation SPYPlantsKnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"多肉种植技巧";
    [self COC_LayoutHomeViews];
    self.SPY_PlantCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.SPY_PlantCollectionView.mj_header endRefreshing];
    }];
}

- (void)COC_LayoutHomeViews {
    [self.SPY_PlantCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SPYTodayPlantsKnowCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SPYTodayPlantsKnowCell class])];
    [self.SPY_PlantCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SPYPlantsListCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SPYPlantsListCell class])];
    
    [self.SPY_PlantCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SPYPlantsScrollReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SPYPlantsScrollReusableView class])];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SPY_fetchPlantsData) name:SPY_PlantsKnowNoti object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SPY_FetchPlantsCircleData) name:SPY_PlantsCircleNoti object:nil];
    [self SPY_fetchPlantsData];
    [self SPY_FetchPlantsCircleData];
}

- (void)SPY_fetchPlantsData {
    
    self.SPY_PlantsKnowScrollData = [NSMutableArray array];
    self.SPY_PlantsKnowListData = [NSMutableArray array];
    NSMutableArray *plantsKnowData = [SPYPlantsJsonTool SPY_FetchPlantsKnowData];
    
    [plantsKnowData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < 3) {
            [self.SPY_PlantsKnowScrollData addObject:[SPYPlantsKnowModel mj_objectWithKeyValues:obj]];
        }
        [self.SPY_PlantsKnowListData addObject:[SPYPlantsKnowModel mj_objectWithKeyValues:obj]];
    }];
    
    
    [self.SPY_PlantCollectionView reloadData];
}

-  (void)SPY_FetchPlantsCircleData {
    
    NSMutableArray *plantsCircleData = [SPYPlantsJsonTool SPY_FetchPlantsCircleData];
    __block NSInteger count = 0;
    [plantsCircleData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SPYPlantsCircleModel *plantsCircleModel = [SPYPlantsCircleModel  mj_objectWithKeyValues:obj];
        if ([plantsCircleModel.State intValue] == 0 && count < 1) {
            self.SPY_HotPlantsCircleModel = plantsCircleModel;
            count++;
        }
    }];
    [self.SPY_PlantCollectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self showADComplete:^{
        if (indexPath.section == 0) {
            SPY_PlantsCircleSayListViewController *hotCircleVC = [SPY_PlantsCircleSayListViewController new];
            hotCircleVC.plantsModel = self.SPY_HotPlantsCircleModel;
            [self.navigationController pushViewController:hotCircleVC animated:YES];
        }else {
            SPYPlantsKnowFeatureViewController *plants_featureVC = [SPYPlantsKnowFeatureViewController new];
            plants_featureVC.plantsKnowModel = self.SPY_PlantsKnowListData[indexPath.item];
            [self.navigationController pushViewController:plants_featureVC animated:YES];
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return self.SPY_PlantsKnowListData.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SPYTodayPlantsKnowCell *todayPlantsCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SPYTodayPlantsKnowCell class]) forIndexPath:indexPath];
        todayPlantsCell.plantsCircleModel = self.SPY_HotPlantsCircleModel;
        return todayPlantsCell;
    }else {
        SPYPlantsListCell *plantsListCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SPYPlantsListCell class]) forIndexPath:indexPath];
        plantsListCell.plantsKnowModel = self.SPY_PlantsKnowListData[indexPath.item];
        return plantsListCell;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 5, 5, 5);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake((SPYScreenWidth  - 10), 230);
    }else {
        return CGSizeMake((SPYScreenWidth - 20)/2, 150);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SPYPlantsScrollReusableView *plantsScrollView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SPYPlantsScrollReusableView class]) forIndexPath:indexPath];
        plantsScrollView.SPYPlantsKnowListData = self.SPY_PlantsKnowScrollData;
        return plantsScrollView;
    }else {
        return [UICollectionReusableView new];
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SPYScreenWidth, 168);
    }
    return CGSizeMake(0, 0);
}


@end
