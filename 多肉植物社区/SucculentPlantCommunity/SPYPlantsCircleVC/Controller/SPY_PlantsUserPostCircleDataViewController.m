//
//  SPY_PlantsUserPostCircleDataViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPY_PlantsUserPostCircleDataViewController.h"

@interface SPY_PlantsUserPostCircleDataViewController ()

@property (weak, nonatomic) IBOutlet UITextField *SPY_PlantsCricle_Theme_textField;

@property (weak, nonatomic) IBOutlet SPY_TextView *SPY_PlantsCircle_ContenttextView;

@property (weak, nonatomic) IBOutlet UIImageView *SPY_Plants_ImageView;

@property (nonatomic , strong) UIImage *GTMconversationImage;

@end

@implementation SPY_PlantsUserPostCircleDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.GTMconversationImage = nil;
    self.navigationItem.title = @"发布多肉帖子";
    self.SPY_PlantsCircle_ContenttextView.placeholder = @"请输入帖子内容";
    [self.SPY_PlantsCircle_ContenttextView SPY_PlantsCornerWidth:3 andBorderWith:2 andBorderColor:SPYNavgationColor];
    UITapGestureRecognizer *plantsCircleImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SPY_choosePlantsCircleImage)];
    [self.SPY_Plants_ImageView addGestureRecognizer:plantsCircleImageTap];
   
    [SPY_PresentPlantsAgreeVC SPY_PresentAgreeVC];
}


- (IBAction)SPY_PostPlantsCircleHandleClick:(id)sender {
    [self showADComplete:^{
        if ([SPYPlantsJsonTool SPY_CurrentFlag]) {
        
            if (self.SPY_PlantsCricle_Theme_textField.text.length < 1) {
                [SVProgressHUD SPY_ShowPlantsErrortext:@"请输入帖子的标题"];
                return;
            }
            
            if (self.SPY_PlantsCircle_ContenttextView.text.length < 1) {
                [SVProgressHUD SPY_ShowPlantsErrortext:@"请输入帖子的内容"];
                return;
            }
            
            if (!self.GTMconversationImage) {
                [SVProgressHUD SPY_ShowPlantsErrortext:@"请选择要发布的图片"];
                return;
            }
            
            
            SPYPlantsCircleModel *plantsCircleModel = [SPYPlantsCircleModel new];
           
          
            plantsCircleModel.plantsCommentArray = [NSArray array];
            plantsCircleModel.fabuRen = [SPYPlantsJsonTool SPY_FtechPlantUserName];
            plantsCircleModel.isZan = @"0";
            plantsCircleModel.zanCount = @"0";
            plantsCircleModel.State = @"0";
            plantsCircleModel.fabuTime = [SPYPlantsJsonTool SPY_FetchNowadaysStr];
            plantsCircleModel.plantsTitle = self.SPY_PlantsCricle_Theme_textField.text;
            plantsCircleModel.plantsBody = self.SPY_PlantsCircle_ContenttextView.text;
            plantsCircleModel.SPYIsLike = @"0";
            plantsCircleModel.plantsIMGData = UIImagePNGRepresentation(self.SPY_Plants_ImageView.image);

           
          
            weakSelfBlock(weakSelf);
            [SVProgressHUD showWithStatus:@"发布中..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [SPYPlantsJsonTool SPY_RelasePlantCircleData:plantsCircleModel];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD SPY_ShowPlantsTruertext:@"社区帖子发布成功"];
            });
        }
    }];
}

- (void)SPY_choosePlantsCircleImage{
    weakSelfBlock(weakSelf);
    [SPY_PlantsImageTools selectImageWithVC:self selectedImage:^(UIImage * _Nonnull image) {
        
        weakSelf.SPY_Plants_ImageView.image  = image;
        weakSelf.GTMconversationImage = image;
        weakSelf.SPY_Plants_ImageView.contentMode = UIViewContentModeScaleToFill;
    }];
}


@end
