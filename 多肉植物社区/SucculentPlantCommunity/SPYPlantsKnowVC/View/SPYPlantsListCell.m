//
//  SPYPlantsListCell.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsListCell.h"

@interface SPYPlantsListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *SPY_Plants_ImageView;

@property (weak, nonatomic) IBOutlet UILabel *SPY_plants_Name_Label;

@property (weak, nonatomic) IBOutlet UILabel *SPY_Plants_Body_label;

@property (weak, nonatomic) IBOutlet UIButton *SPY_Plants_LikeButton;

@end

@implementation SPYPlantsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setPlantsKnowModel:(SPYPlantsKnowModel *)plantsKnowModel {
    _plantsKnowModel = plantsKnowModel;
    [self.SPY_Plants_ImageView sd_setImageWithURL:[NSURL URLWithString:plantsKnowModel.plantsImageUrl]];
    self.SPY_plants_Name_Label.text = plantsKnowModel.plantsKnowTitle;
    self.SPY_Plants_Body_label.text = plantsKnowModel.plantsKnowBody;
    self.SPY_Plants_LikeButton.selected = [plantsKnowModel.SPYIsLike isEqualToString:@"1"] ? YES : NO;
}

- (IBAction)SPY_Like_PlantsClick:(UIButton *)sender {
    
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
        self.plantsKnowModel.SPYIsLike = [self.plantsKnowModel.SPYIsLike intValue] == 0 ? @"1" : @"0";
        [SPYPlantsJsonTool SPY_LikePlantsKnowData:self.plantsKnowModel];
        if ([self.plantsKnowModel.SPYIsLike intValue] == 0) {
            [SVProgressHUD SPY_ShowPlantsTruertext:@"取消收藏成功!"];
           
        }else {
            [SVProgressHUD SPY_ShowPlantsTruertext:@"收藏成功!"];
        }
    }
}



@end
