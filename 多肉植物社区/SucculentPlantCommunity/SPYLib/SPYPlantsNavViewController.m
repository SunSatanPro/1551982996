//
//  SPYPlantsNavViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsNavViewController.h"

@interface SPYPlantsNavViewController ()

@end

@implementation SPYPlantsNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = nil;
    
}


+ (void)initialize {
    
    [[UINavigationBar appearance] setBarTintColor:SPYNavgationColor];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    
    [[UINavigationBar appearance] setTintColor:UIColor.whiteColor];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:UIColor.whiteColor}];
    
    UIBarButtonItem *item= [UIBarButtonItem appearance];
    
    NSMutableDictionary *textArr = [NSMutableDictionary dictionary];
    textArr[NSForegroundColorAttributeName] = UIColor.whiteColor;
    textArr[NSFontAttributeName] = [UIFont systemFontOfSize:19];
    [item setTitleTextAttributes:textArr forState:UIControlStateNormal];
    
    NSMutableDictionary *disableTextArr = [NSMutableDictionary dictionary];
    disableTextArr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableTextArr[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [item setTitleTextAttributes:disableTextArr forState:UIControlStateDisabled];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"SPY_PlantBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(SPYPlantsBackClick)];
    }
    [super pushViewController:viewController animated:animated];
    
}


- (void)SPYPlantsBackClick {
    [self popViewControllerAnimated:YES];
}

@end
