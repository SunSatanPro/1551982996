//
//  SPYPlantsCircleSayCell.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsCircleSayCell.h"

@interface SPYPlantsCircleSayCell ()

@property (weak, nonatomic) IBOutlet UILabel *SPYPlantsSay_Nick_Label;

@property (weak, nonatomic) IBOutlet UILabel *SPYPlantsSay_name_Label;

@property (weak, nonatomic) IBOutlet UIButton *SPY_PlantsSay_SatisfdBtn;

@property (weak, nonatomic) IBOutlet UILabel *SPY_plantsSayText;
@end

@implementation SPYPlantsCircleSayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.SPYPlantsSay_Nick_Label SPY_PlantsCornerWidth:16];
    self.SPY_plantsSayText.adjustsFontSizeToFitWidth = SPYScreenWidth - 40;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)SPY_PlantsSayPrase:(UIButton *)sender {
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
        NSMutableArray *plantSayData = [NSMutableArray arrayWithArray:self.plantModel.plantsCommentArray];
        __block NSInteger index = -1;
        [plantSayData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[plantSayData[idx] valueForKey:@"plantsCMText"] isEqual:self.plantSayModel.plantsCMText]) {
                index =  idx;
                *stop = YES;
            }
        }];
        
        if (index >= 0) {
            self.plantSayModel.isZan = [self.plantSayModel.isZan isEqualToString:@"0"] ? @"1" : @"0";
            [plantSayData replaceObjectAtIndex:index withObject:self.plantSayModel.mj_keyValues];
            self.plantModel.plantsCommentArray = plantSayData;
            [SPYPlantsJsonTool SPY_ModifyPlantCircleData:self.plantModel];
        }
    }
}


- (void)setPlantSayModel:(SPYPlantsCircleSayModel *)plantSayModel {
    _plantSayModel = plantSayModel;
    self.SPYPlantsSay_Nick_Label.text =  [plantSayModel.plantsCMfabuRen substringToIndex:1];
    self.SPYPlantsSay_name_Label.text = plantSayModel.plantsCMfabuRen;
    self.SPY_PlantsSay_SatisfdBtn.selected = [plantSayModel.isZan isEqualToString:@"0"] ? NO : YES;
    self.SPY_plantsSayText.text = plantSayModel.plantsCMText;
}

- (IBAction)SPY_PlantsSay_Baogao:(id)sender {
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
        [SPY_ReportPlantsHandle SPY_ReportPlants];
    }
}

- (IBAction)SPY_PlantsSay_Deletehandle:(id)sender {
    if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
    NSMutableArray *plantsSayData = [NSMutableArray arrayWithArray:self.plantModel.plantsCommentArray];
    __block NSInteger indexflag = -1;
    [plantsSayData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[plantsSayData[idx] valueForKey:@"plantsCMText"] isEqual:self.plantSayModel.plantsCMText]) {
            indexflag =  idx;
            *stop = YES;
        }
    }];
    
    if (indexflag >= 0) {
        [SPYPlantsJsonTool SPY_AddPlantsBlackData:[NSString stringWithFormat:@"《评论黑名单》%@",self.plantSayModel.plantsCMText]];
        self.plantSayModel.State = @"1";
        [plantsSayData replaceObjectAtIndex:indexflag withObject:self.plantSayModel.mj_keyValues];
        self.plantModel.plantsCommentArray = plantsSayData;
        [SPYPlantsJsonTool SPY_ModifyPlantCircleData:self.plantModel];
        [SVProgressHUD SPY_ShowPlantsTruertext:@"拉黑成功！"];
    }
    }
}

@end
