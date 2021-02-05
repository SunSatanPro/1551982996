//
//  SPY_PlantCircleCell.h
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPY_PlantCircleCell : UITableViewCell

@property (nonatomic , strong) SPYPlantsCircleModel *plantsModel;


@property (nonatomic , assign)  BOOL SPY_PlantsFeature;

@end

NS_ASSUME_NONNULL_END
