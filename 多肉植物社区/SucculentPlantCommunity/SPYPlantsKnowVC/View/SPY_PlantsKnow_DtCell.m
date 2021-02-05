//
//  SPY_PlantsKnow_DtCell.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPY_PlantsKnow_DtCell.h"

@interface SPY_PlantsKnow_DtCell ()

@property (weak, nonatomic) IBOutlet UILabel *SPY_plantsKnow_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *SPY_RelasePlantsTime_Label;

@property (weak, nonatomic) IBOutlet UIImageView *SPY_PlantsImageView;

@property (weak, nonatomic) IBOutlet UILabel *SPY_PlantsKnow_Body_Label;

@property (weak, nonatomic) IBOutlet UIButton *SPY_CollectionPlantsBtn;
@end

@implementation SPY_PlantsKnow_DtCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.SPY_plantsKnow_titleLabel.preferredMaxLayoutWidth = SPYScreenWidth - 40;
    self.SPY_PlantsKnow_Body_Label.preferredMaxLayoutWidth = SPYScreenWidth - 40;
    [self.SPY_PlantsImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SPY_Plants_KnowClick)]];
}

- (void)SPY_Plants_KnowClick {
    [SPY_PlantsImageTools SPY_CheckPlantsBigImage:self.plantsKnowModel.plantsImageUrl AndImageData:nil];
}

- (void)setPlantsKnowModel:(SPYPlantsKnowModel *)plantsKnowModel {
    _plantsKnowModel = plantsKnowModel;
    self.SPY_plantsKnow_titleLabel.text = plantsKnowModel.plantsKnowTitle;
    self.SPY_RelasePlantsTime_Label.text = plantsKnowModel.postDateTime;
    [self.SPY_PlantsImageView sd_setImageWithURL:[NSURL URLWithString:plantsKnowModel.plantsImageUrl]];
   
    self.SPY_PlantsKnow_Body_Label.text = plantsKnowModel.plantsKnowBody;
    NSString *SPYBtnText = [plantsKnowModel.SPYIsLike isEqualToString:@"1"] ? @"已收藏" : @"收藏";
    [self.SPY_CollectionPlantsBtn setTitle:SPYBtnText forState:UIControlStateNormal];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}




- (IBAction)SPY_LikePlantsKnow:(UIButton *)sender {
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
        self.plantsKnowModel.SPYIsLike = [self.plantsKnowModel.SPYIsLike intValue] == 0 ? @"1" : @"0";
        [SPYPlantsJsonTool SPY_LikePlantsKnowData:self.plantsKnowModel];
        if ([self.plantsKnowModel.SPYIsLike intValue] == 0) {
            [self.SPY_CollectionPlantsBtn setTitle:@"收藏" forState:UIControlStateNormal];
            [SVProgressHUD SPY_ShowPlantsTruertext:@"取消收藏成功!"];
           
        }else {
            [self.SPY_CollectionPlantsBtn setTitle:@"已收藏" forState:UIControlStateNormal];
            [SVProgressHUD SPY_ShowPlantsTruertext:@"收藏成功!"];
        }
    }
}

- (IBAction)SPY_NoGoodPlants:(id)sender {
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
        [SPY_ReportPlantsHandle SPY_ReportPlants];
    }
}

@end
