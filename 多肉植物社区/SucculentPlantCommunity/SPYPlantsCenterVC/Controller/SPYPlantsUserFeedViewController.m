//
//  SPYPlantsUserFeedViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsUserFeedViewController.h"

@interface SPYPlantsUserFeedViewController ()


@property (weak, nonatomic) IBOutlet SPY_TextView *SPYFeedPlants_TextView;

@end

@implementation SPYPlantsUserFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.SPYFeedPlants_TextView SPY_PlantsCornerWidth:4 andBorderWith:1 andBorderColor:SPYNavgationColor];
    self.SPYFeedPlants_TextView.placeholder = @"请输入你想反馈的意见...";
    self.navigationItem.title =  @"反馈";
}



- (IBAction)SPY_FeedPlantshandle:(id)sender {
    if (self.SPYFeedPlants_TextView.text.length < 1){
        [SVProgressHUD SPY_ShowPlantsErrortext:@"请输入您的意见反馈!"];
        return;
    }
    [SVProgressHUD showWithStatus:@"提交中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [SVProgressHUD SPY_ShowPlantsTruertext:@"反馈意见成功"];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
