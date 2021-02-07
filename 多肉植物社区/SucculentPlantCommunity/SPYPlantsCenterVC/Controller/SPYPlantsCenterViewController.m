//
//  SPYPlantsCenterViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsCenterViewController.h"
#import "SPYInfoPlantsListCell.h"
#import "SPYPlantsCircleViewController.h"
#import "SPY_SatisfyPlantsKnowViewController.h"
#import "SPYPlantsUserFeedViewController.h"
#import "SPYPlantsNoSatisfyViewController.h"
@interface SPYPlantsCenterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *SPY_PlantsImageVIew;

@property (weak, nonatomic) IBOutlet UILabel *SPY_Plantsuser_Label;

@property (weak, nonatomic) IBOutlet UITableView *SPY_PlantsListtableView;

@property (nonatomic , strong) NSArray *SPYPlantsListData;
@end

@implementation SPYPlantsCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStyleDone target:self action:@selector(SPY_PlantsUserOuthandle)];
    [self.SPY_PlantsListtableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPYInfoPlantsListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SPYInfoPlantsListCell class])];
    [self.SPY_PlantsImageVIew SPY_PlantsCornerWidth:72];
    self.navigationItem.title = @"个人中心";
    self.SPY_Plantsuser_Label.text = [SPYPlantsJsonTool SPY_FtechPlantUserName];
   
    self.SPYPlantsListData =  @[@"关注的帖子",@"收藏的种植技术",@"黑名单列表",@"反馈意见",@"联系我们",@"清除缓存"];
}



-  (void)SPY_PlantsUserOuthandle {
    [self.tabBarController setSelectedIndex:0];
    [SPYPlantsJsonTool SPY_DeletePlantUserName];
}

-  (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showADComplete:^{
        if (indexPath.row == 0) {
            SPYPlantsCircleViewController *plantsUsersCircleVC = [SPYPlantsCircleViewController new];
            plantsUsersCircleVC.SPY_MineLikeCirlce = @"我的关注";
            [self.navigationController pushViewController:plantsUsersCircleVC animated:YES];
        }else if (indexPath.row == 1) {
            [self.navigationController pushViewController:[SPY_SatisfyPlantsKnowViewController new] animated:YES];
        }else if (indexPath.row ==  2) {
            [self.navigationController pushViewController:[SPYPlantsNoSatisfyViewController new] animated:YES];
        }else if (indexPath.row == 3) {
            [self.navigationController pushViewController:[SPYPlantsUserFeedViewController new] animated:YES];
        }else if (indexPath.row == 4) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:syf19770512@icloud.com"] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
                    if (success) {

                    }else {
                        [SVProgressHUD SPY_ShowPlantsErrortext:@"打开邮件失败"];
                    }
                }];
            }
        }
        else {
            [SVProgressHUD SPY_ShowPlantsTruertext:@"清除成功"];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.SPYPlantsListData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPYInfoPlantsListCell *PlantsList_Cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SPYInfoPlantsListCell class])];
    [PlantsList_Cell.SPYPlantBtn setTitle:self.SPYPlantsListData[indexPath.row] forState:UIControlStateNormal];
    return PlantsList_Cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66.f;
}


@end
