//
//  SPYPlantsLikeViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsLikeViewController.h"
#import "SPY_SatisfyPlantsKnowViewController.h"
#import "SPYPlantsCircleViewController.h"
@interface SPYPlantsLikeViewController ()


@property (nonatomic , strong) NSMutableArray <UIViewController *> *SPY_PlantsGuanZhuVCArray;


@end

@implementation SPYPlantsLikeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.menuItemWidth = 128;
        self.titleFontName = @".SFUI-Medium";
        self.titleSizeNormal = 17;
        self.titleSizeSelected = 20;
        [self setCachePolicy:WMPageControllerCachePolicyBalanced];
        self.showOnNavigationBar = NO;
        self.menuViewStyle = WMMenuViewStyleLine;
       
        self.titleColorNormal = UIColor.whiteColor;
        self.titleColorSelected = UIColor.whiteColor;
        self.progressColor = UIColor.redColor;
        self.progressHeight = 3;
        self.titles = @[@"收藏的技术",@"关注的帖子"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"我的关注";
    [self reloadData];
}

- (NSMutableArray <UIViewController *> *)SPY_PlantsGuanZhuVCArray {
    if (!_SPY_PlantsGuanZhuVCArray) {
        _SPY_PlantsGuanZhuVCArray =  [NSMutableArray array];
        SPY_SatisfyPlantsKnowViewController *satisfyPlantsKnowVC = [SPY_SatisfyPlantsKnowViewController new];
        [_SPY_PlantsGuanZhuVCArray addObject:satisfyPlantsKnowVC];
        SPYPlantsCircleViewController *plantsCircleVC = [SPYPlantsCircleViewController new];
        plantsCircleVC.SPY_MineLikeCirlce = @"我的关注";
        [_SPY_PlantsGuanZhuVCArray addObject:plantsCircleVC];
    }
    return _SPY_PlantsGuanZhuVCArray;
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}


- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    return self.SPY_PlantsGuanZhuVCArray[index];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}


- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    menuView.backgroundColor = SPYNavgationColor;
    return CGRectMake(0, 0, SPYScreenWidth, 40);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return CGRectMake(0, 44, SPYScreenWidth, SPYScreenHeight - SPYtopheight - 44 -  SPYTabbarHeight);
}


@end
