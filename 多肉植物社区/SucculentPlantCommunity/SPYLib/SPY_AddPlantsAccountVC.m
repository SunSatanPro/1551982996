//
//  SPY_AddPlantsAccountVC.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPY_AddPlantsAccountVC.h"
#import "SPY_PlantsAgreeVC.h"
@interface SPY_AddPlantsAccountVC ()


@property (weak, nonatomic) IBOutlet UITextField *SPY_PlantsNametextField;

@property (weak, nonatomic) IBOutlet UITextField *SPY_PlantsPassWord1;

@property (weak, nonatomic) IBOutlet UITextField *SPY_PlantsPassWord2;

@end

@implementation SPY_AddPlantsAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)SPY_PlantsuserCheck:(id)sender {
    [self presentViewController:[SPY_PlantsAgreeVC new] animated:YES completion:nil];
}


- (IBAction)SPY_ResignPlantsUser:(id)sender {
    
    if (self.SPY_PlantsNametextField.text.length < 1) {
        [SVProgressHUD SPY_ShowPlantsErrortext:@"请输入用户名"];
        return;
    }
    
    if (self.SPY_PlantsPassWord1.text.length < 6) {
        [SVProgressHUD SPY_ShowPlantsErrortext:@"请输入至少6位数密码"];
        return;
    }
    
    if (self.SPY_PlantsPassWord2.text.length < 6) {
        [SVProgressHUD SPY_ShowPlantsErrortext:@"请输入至少6位数密码"];
        return;
    }
    
    if (![self.SPY_PlantsPassWord1.text isEqualToString:self.SPY_PlantsPassWord2.text]){
        [SVProgressHUD SPY_ShowPlantsErrortext:@"两次输入的密码不一致"];
        return;
    }
    
    
    [SVProgressHUD showWithStatus:@"注册中..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        SPYPlantUserModel *plantsModel = [SPYPlantUserModel new];
        plantsModel.SPYName = self.SPY_PlantsNametextField.text;
        plantsModel.SPYPWD = self.SPY_PlantsPassWord1.text;
        [SPYPlantsJsonTool SPY_ResignPlantUser:plantsModel];
        [SVProgressHUD SPY_ShowPlantsTruertext:@"注册成功!"];
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}


- (IBAction)SPY_DisappearResignVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
