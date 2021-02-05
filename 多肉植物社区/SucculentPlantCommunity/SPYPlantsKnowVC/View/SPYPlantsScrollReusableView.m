//
//  SPYPlantsScrollReusableView.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsScrollReusableView.h"
#import "SPYPlantsKnowFeatureViewController.h"
@interface SPYPlantsScrollReusableView () <SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *SPY_PlantsScrollView;


@end

@implementation SPYPlantsScrollReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.SPY_PlantsScrollView.delegate = self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    SPYPlantsKnowFeatureViewController *plants_featureVC = [SPYPlantsKnowFeatureViewController new];
    plants_featureVC.plantsKnowModel = self.SPYPlantsKnowListData[index];
    [[SPY_PlantsTopViewController SPY_FetchTopVC].navigationController pushViewController:plants_featureVC animated:YES];
}

- (void)setSPYPlantsKnowListData:(NSArray<SPYPlantsKnowModel *> *)SPYPlantsKnowListData {
    _SPYPlantsKnowListData = SPYPlantsKnowListData;
    self.SPY_PlantsScrollView.imageURLStringsGroup =[SPYPlantsKnowListData valueForKey:@"plantsImageUrl"];
    self.SPY_PlantsScrollView.titlesGroup = [SPYPlantsKnowListData valueForKey:@"plantsKnowTitle"];
}




@end
