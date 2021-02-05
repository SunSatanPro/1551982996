//
//  AppDelegate+SPY.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "AppDelegate.h"
#import "SPYPlantsTabbarViewController.h"

@implementation AppDelegate (SPY)

- (void)SPY_IninPlantsWindow {
    [SPYPlantsJsonTool SPY_SetPlantsData];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    SPYPlantsTabbarViewController *SPTPlantsTabbarVC = [[SPYPlantsTabbarViewController alloc]init];
    self.window.rootViewController = SPTPlantsTabbarVC;
    [self.window makeKeyAndVisible];
}

@end
