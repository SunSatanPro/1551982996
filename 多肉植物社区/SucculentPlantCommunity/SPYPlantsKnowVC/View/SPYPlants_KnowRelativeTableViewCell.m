//
//  SPYPlants_KnowRelativeTableViewCell.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlants_KnowRelativeTableViewCell.h"

@interface SPYPlants_KnowRelativeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *SPY_PlantsKnow_ImageView;

@property (weak, nonatomic) IBOutlet UILabel *SPY_PlantsKnowTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *SPY_PlantsKnow_Body_Label;
@end

@implementation SPYPlants_KnowRelativeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPlantsKnowModel:(SPYPlantsKnowModel *)plantsKnowModel {
    _plantsKnowModel = plantsKnowModel;
    [self.SPY_PlantsKnow_ImageView sd_setImageWithURL:[NSURL URLWithString:plantsKnowModel.plantsImageUrl]];
    self.SPY_PlantsKnowTitleLabel.text = plantsKnowModel.plantsKnowTitle;
    self.SPY_PlantsKnow_Body_Label.text = plantsKnowModel.plantsKnowBody;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
