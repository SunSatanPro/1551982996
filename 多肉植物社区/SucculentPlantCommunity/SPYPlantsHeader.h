//
//  SPYPlantsHeader.h
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#ifndef SPYPlantsHeader_h
#define SPYPlantsHeader_h

#import <UIKit/UIKit.h>

static inline BOOL SPY_isIPhoneX() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = nil;
        if (@available(iOS 13.0, *)) {
            mainWindow = [UIApplication sharedApplication].windows[0];
        } else {
            mainWindow = [UIApplication sharedApplication].delegate.window;
        }
           if (mainWindow.safeAreaInsets.bottom > 0.0 || [[UIApplication sharedApplication] statusBarFrame].size.height == 44) {
               iPhoneXSeries = YES;
           }
       }
    return iPhoneXSeries;
}

#define  weakSelfBlock(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define  SPYRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define  SPYNavgationColor  SPYRGB(119,144,112)

#define  SPYStatusBarHeight      (SPY_isIPhoneX() ? 44.f : 20.f)

#define  SPYNavigationBarHeight  44.f

#define  SPYTabbarHeight         (SPY_isIPhoneX()  ? (49.f+34.f) : 49.f)

#define  SPYbottomSafeArea         (SPY_isIPhoneX()  ? (34.f) : 0.0f)

#define  SPYtopheight (SPYStatusBarHeight + SPYNavigationBarHeight)

#define  SPYScreenWidth                             [UIScreen mainScreen].bounds.size.width

#define  SPYScreenHeight                            [UIScreen mainScreen].bounds.size.height



#import <MJExtension.h>
#import <Masonry.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>

#import "SPYPlantsJsonTool.h"
#import "SPYPlantsTool.h"
#import "SPY_PlantsLogVC.h"
#import "SPY_PlantImage_ViewController.h"

#import <IQKeyboardManager.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import <SDCycleScrollView.h>



#endif /* SPYPlantsHeader_h */
