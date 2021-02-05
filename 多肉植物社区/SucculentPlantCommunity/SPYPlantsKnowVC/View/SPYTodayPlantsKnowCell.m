//
//  SPYTodayPlantsKnowCell.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYTodayPlantsKnowCell.h"

@interface SPYTodayPlantsKnowCell ()


@property (weak, nonatomic) IBOutlet UILabel *SPY_PlantKnow_Title_label;

@property (weak, nonatomic) IBOutlet UILabel *SPY_TodayPlantsKnow_Body_Label;

@property (weak, nonatomic) IBOutlet UIImageView *SPY_PlantsKnow_ImageView;

@end

@implementation SPYTodayPlantsKnowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPlantsCircleModel:(SPYPlantsCircleModel *)plantsCircleModel {
    _plantsCircleModel = plantsCircleModel;
    self.SPY_PlantKnow_Title_label.text = plantsCircleModel.plantsTitle;
    self.SPY_TodayPlantsKnow_Body_Label.text = plantsCircleModel.plantsBody;
    if (plantsCircleModel.plantsIMGUrl.length > 0) {
        [self.SPY_PlantsKnow_ImageView sd_setImageWithURL:[NSURL URLWithString:plantsCircleModel.plantsIMGUrl]];
    }else {
        self.SPY_PlantsKnow_ImageView.image = [UIImage imageWithData:plantsCircleModel.plantsIMGData];
    }
    
    
}
@end
