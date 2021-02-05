//
//  SPY_PlantsLogVC.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPY_PlantsLogVC.h"
#import "SPY_AddPlantsAccountVC.h"
@interface SPY_PlantsLogVC ()

@property (weak, nonatomic) IBOutlet UITextField *SPY_PlantsNametextField;

@property (weak, nonatomic) IBOutlet UITextField *SPY_PlantsPWDtextField;

@end

@implementation SPY_PlantsLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)SPY_ClosePlantsLog:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SPY_PlantsLogHandle:(UIButton *)sender {
    if (self.SPY_PlantsNametextField.text.length < 1 || self.SPY_PlantsPWDtextField.text.length < 1) {
        
        [SVProgressHUD SPY_ShowPlantsErrortext:@"请填写完整的用户名和密码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"登录中..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if ([self.SPY_PlantsNametextField.text isEqual:SPY_AccountName] && [self.SPY_PlantsPWDtextField.text isEqual:SPY_AccountPWD]) {
            
            [SPYPlantsJsonTool SPY_ModiifyPlantUserName:self.SPY_PlantsNametextField.text];
            [[NSNotificationCenter defaultCenter] postNotificationName:SPY_PlantsUserLoginNotification object:nil];
            [SVProgressHUD SPY_ShowPlantsTruertext:@"登录成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            NSMutableArray *SPY_UserListData = [SPYPlantsJsonTool SPY_FetchPlantsUsers];
            
            __block BOOL isExistPlantsUser = NO;
            [SPY_UserListData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SPYPlantUserModel *userModel = [SPYPlantUserModel mj_objectWithKeyValues:obj];
                if ([userModel.SPYName isEqual:self.SPY_PlantsNametextField.text] && [self.SPY_PlantsPWDtextField.text isEqual:userModel.SPYPWD]) {
                    isExistPlantsUser = YES;
                    *stop = YES;
                }
            }];
            if (isExistPlantsUser) {
                [SPYPlantsJsonTool SPY_ModiifyPlantUserName:self.SPY_PlantsNametextField.text];
                [[NSNotificationCenter defaultCenter] postNotificationName:SPY_PlantsUserLoginNotification object:nil];
                [SVProgressHUD SPY_ShowPlantsTruertext:@"登录成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else {
                [SVProgressHUD SPY_ShowPlantsErrortext:@"无此用户!"];
            }
        }
        
    });
}


- (IBAction)SPY_ResignPlantsUser:(id)sender {
    
    SPY_AddPlantsAccountVC *plantsUserVC = [SPY_AddPlantsAccountVC new];
    
    [self presentViewController:plantsUserVC animated:YES completion:nil];
}

@end
