//
//  SPYPlantsTabbarViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsTabbarViewController.h"
#import "SPYPlantsNavViewController.h"
#import "SPYPlantsKnowViewController.h"
#import "SPYPlantsCircleViewController.h"
#import "SPYPlantsLikeViewController.h"
#import "SPYPlantsCenterViewController.h"
@interface SPYPlantsTabbarViewController () <UITabBarControllerDelegate>

@end

@implementation SPYPlantsTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self SPYAddSubTabVC];
}

- (void)SPYAddSubTabVC {
    

    SPYPlantsKnowViewController *plantsKnowVC = [[SPYPlantsKnowViewController alloc]init];
    [self SPYAddtabbarVC:plantsKnowVC title:@"首页" image:@"SPY_PlantMainImage"];

    SPYPlantsCircleViewController *plantCircle_VC = [SPYPlantsCircleViewController new];
    [self SPYAddtabbarVC:plantCircle_VC title:@"多肉圈" image:@"SPY_PlantsCircle_Image"];


    SPYPlantsLikeViewController *plantsLike_VC = [SPYPlantsLikeViewController new];
    [self SPYAddtabbarVC:plantsLike_VC title:@"关注" image:@"SPY_PlantsLike_Image"];


    SPYPlantsCenterViewController *plantCenter_VC = [[SPYPlantsCenterViewController alloc] init];
    [self SPYAddtabbarVC:plantCenter_VC title:@"我的" image:@"SPY_plants_MineImage"];
    
}

-(void)SPYAddtabbarVC:(UIViewController *)childViewController  title:(NSString *)tabtitle image:(NSString *)image{
    static NSInteger index = 0;
    childViewController.tabBarItem.title = tabtitle;
    childViewController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    childViewController.tabBarItem.tag = index;
    index++;
    SPYPlantsNavViewController *plantsNav = [[SPYPlantsNavViewController  alloc] initWithRootViewController:childViewController];
    
    [self addChildViewController:plantsNav];
}

+ (void)initialize
{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = SPYNavgationColor ;
    
    if (@available(iOS 13.0, *)) {
        [[UITabBar appearance] setUnselectedItemTintColor:[UIColor grayColor]];
        [[UITabBar appearance] setTintColor: SPYNavgationColor];
    } else{
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    }
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0) {
    
    if ([[viewController.childViewControllers objectAtIndex:0] isKindOfClass:[SPYPlantsCenterViewController class]] || [[viewController.childViewControllers objectAtIndex:0] isKindOfClass:[SPYPlantsLikeViewController class]]){
        
        if (![SPYPlantsJsonTool SPY_CurrentFlag]) {
            
            SPY_PlantsLogVC *attendvC = [SPY_PlantsLogVC new];
            
            [self presentViewController:attendvC animated:YES completion:nil];
            
            return NO;
            
        }else {
            
            return YES;
        }
    }
    
    return YES;
}

@end
