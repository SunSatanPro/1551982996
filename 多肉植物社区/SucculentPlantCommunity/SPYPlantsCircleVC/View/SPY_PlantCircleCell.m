//
//  SPY_PlantCircleCell.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPY_PlantCircleCell.h"

@interface SPY_PlantCircleCell ()


@property (weak, nonatomic) IBOutlet UILabel *SPY_PlantsCircle_Titl_FirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *SPYPlantsCircle_Name_Label;

@property (weak, nonatomic) IBOutlet UIButton *SPY_isGuanZhuPlantsCircle;

@property (weak, nonatomic) IBOutlet UILabel *SPY_PlantsCircle_Theme_Label;

@property (weak, nonatomic) IBOutlet UIImageView *SPY_PlantsCircle_ImageView;

@property (weak, nonatomic) IBOutlet UILabel *SPY_PlantsCircle_DetailText_Label;

@property (weak, nonatomic) IBOutlet UIButton *SPY_PlantsPraiseBtn;
@end

@implementation SPY_PlantCircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.SPY_PlantsCircle_ImageView SPY_PlantsCornerWidth:4];
    [self.SPY_PlantsCircle_Titl_FirstLabel SPY_PlantsCornerWidth:16];
    self.SPY_PlantsCircle_Theme_Label.preferredMaxLayoutWidth = SPYScreenWidth - 40;
    self.SPY_PlantsCircle_DetailText_Label.preferredMaxLayoutWidth = SPYScreenWidth - 40;
    [self.SPY_PlantsCircle_ImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SPY_PlantsBigZoom)]];
}

- (void)SPY_PlantsBigZoom {
    [SPY_PlantsImageTools SPY_CheckPlantsBigImage:self.plantsModel.plantsIMGUrl AndImageData:self.plantsModel.plantsIMGData];
}

- (void)setPlantsModel:(SPYPlantsCircleModel *)plantsModel {
    
    _plantsModel = plantsModel;
    self.SPY_PlantsCircle_Titl_FirstLabel.text = [plantsModel.fabuRen substringToIndex:1];
    self.SPYPlantsCircle_Name_Label.text = plantsModel.fabuRen;
    
    self.SPY_isGuanZhuPlantsCircle.selected = [plantsModel.SPYIsLike isEqualToString:@"0"] ? NO : YES;
    self.SPY_PlantsCircle_Theme_Label.text = plantsModel.plantsTitle;
    if (plantsModel.plantsIMGUrl.length > 0) {
        [self.SPY_PlantsCircle_ImageView sd_setImageWithURL:[NSURL URLWithString:plantsModel.plantsIMGUrl]];
    }else {
        self.SPY_PlantsCircle_ImageView.image = [UIImage imageWithData:plantsModel.plantsIMGData];
    }
    self.SPY_PlantsCircle_DetailText_Label.text = plantsModel.plantsBody;
    self.SPY_PlantsCircle_DetailText_Label.numberOfLines = self.SPY_PlantsFeature ? 0 : 4;
    if ([plantsModel.isZan isEqualToString:@"0"]) {
        [self.SPY_PlantsPraiseBtn setTitle:[NSString stringWithFormat:@"点赞 %@",plantsModel.zanCount] forState:UIControlStateNormal];
    }else {
        [self.SPY_PlantsPraiseBtn setTitle:[NSString stringWithFormat:@"已赞 %@",plantsModel.zanCount] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)SPY_GuanZhuPlants:(UIButton *)sender {
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
        int guanzhuIndex = [self.plantsModel.SPYIsLike intValue];
        self.plantsModel.SPYIsLike = guanzhuIndex == 0 ? @"1" : @"0";
        [SPYPlantsJsonTool SPY_ModifyPlantCircleData:self.plantsModel];
    }
}

- (IBAction)SPY_PlantsCircle_Balck:(id)sender {
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
        [SPY_ReportPlantsHandle SPY_ReportPlants];
    }
}

- (IBAction)SPY_Plants_PushBlack:(id)sender {
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
       
        [SPYPlantsJsonTool SPY_AddPlantsBlackData:[NSString stringWithFormat:@"《圈子黑名单》%@",self.plantsModel.plantsTitle]];
        self.plantsModel.State = @"1";
        [SPYPlantsJsonTool SPY_ModifyPlantCircleData:self.plantsModel];
        
        [SVProgressHUD SPY_ShowPlantsTruertext:@"拉黑成功！"];
        if (self.SPY_PlantsFeature){
            [[SPY_PlantsTopViewController SPY_FetchTopVC].navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)SPY_PlantsCirclePraise:(UIButton *)sender {
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
        int likeIndex = [self.plantsModel.isZan intValue];
        if (likeIndex == 0) {
            self.plantsModel.isZan = @"1";
            self.plantsModel.zanCount = [NSString stringWithFormat:@"%d",[self.plantsModel.zanCount intValue] + 1];
            [self.SPY_PlantsPraiseBtn setTitle:[NSString stringWithFormat:@"已赞 %@",self.plantsModel.zanCount] forState:UIControlStateNormal];
        }else {
            self.plantsModel.isZan = @"0";
            self.plantsModel.zanCount = [NSString stringWithFormat:@"%d",[self.plantsModel.zanCount intValue] - 1];
            [self.SPY_PlantsPraiseBtn setTitle:[NSString stringWithFormat:@"赞 %@",self.plantsModel.zanCount] forState:UIControlStateNormal];
        }
        [SPYPlantsJsonTool SPY_ModifyPlantCircleData:self.plantsModel];
    }
}

@end
