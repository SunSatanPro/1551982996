//
//  SPYPlantsJsonTool.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsJsonTool.h"

@implementation SPYPlantsJsonTool

+ (NSString *)SPY_FtechPlantUserName {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    
}

+(void)SPY_ModiifyPlantUserName:(NSString *)userName {
    
    NSUserDefaults *defaultToken = [NSUserDefaults standardUserDefaults];
    
    [defaultToken setObject:userName forKey:@"userName"];
    
    [defaultToken synchronize];
}

+ (void)SPY_DeletePlantUserName {
    
    NSUserDefaults *defaultToken = [NSUserDefaults standardUserDefaults];
    
    [defaultToken removeObjectForKey:@"userName"];
    
    [defaultToken synchronize];
}

+ (NSMutableArray *)SPY_FetchPlantsUsers {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"SPY_UserListDataName"] ?: [NSMutableArray array];
}

+ (void)SPY_ResignPlantUser:(SPYPlantUserModel *)userModel {
    NSMutableArray *userListArray = [[self SPY_FetchPlantsUsers] mutableCopy];
   [userListArray addObject:userModel.mj_keyValues];
   NSUserDefaults *saveuserStander = [NSUserDefaults standardUserDefaults];
   [saveuserStander setObject:userListArray forKey:@"SPY_UserListDataName"];
   [saveuserStander synchronize];
}


+ (NSString *)SPY_FetchNowadaysStr {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter stringFromDate:date];
}


+ (NSMutableArray *)SPY_FetchPlantsKnowData {
    return [[NSUserDefaults standardUserDefaults] objectForKey:SPYPlantsKnowName];
}

+ (void)SPY_LikePlantsKnowData:(SPYPlantsKnowModel *)plantsKnowModel {
    NSMutableArray *plantsKnowData = [self SPY_FetchPlantsKnowData];
    
    NSMutableArray *plantsKnowModalData = [SPYPlantsKnowModel mj_objectArrayWithKeyValuesArray:plantsKnowData];
    
    __block NSInteger updateIndex;
    [plantsKnowModalData enumerateObjectsUsingBlock:^(SPYPlantsKnowModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.plantsKnowTitle isEqualToString:plantsKnowModel.plantsKnowTitle]){
            updateIndex = idx;
            *stop = YES;
        }
    }];
    
    [plantsKnowModalData replaceObjectAtIndex:updateIndex withObject:plantsKnowModel];
    
    //重新存
    NSMutableArray *updateArray = [NSMutableArray array];
    [plantsKnowModalData enumerateObjectsUsingBlock:^(SPYPlantsKnowModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [updateArray addObject:obj.mj_keyValues];
    }];
    
    NSUserDefaults *saveuserStander = [NSUserDefaults standardUserDefaults];
    [saveuserStander setObject:updateArray forKey:SPYPlantsKnowName];
    [saveuserStander synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:SPY_PlantsKnowNoti object:nil];
}

+ (NSMutableArray *)SPY_FetchPlantsCircleData {
    return [[NSUserDefaults standardUserDefaults] objectForKey:SPY_PlantsCircleName];
}


+ (void)SPY_ModifyPlantCircleData:(SPYPlantsCircleModel *)plantsCircleMoel {
    NSMutableArray *massArray = [self SPY_FetchPlantsCircleData];
    
    NSMutableArray *plantsCircleMoelArray = [SPYPlantsCircleModel mj_objectArrayWithKeyValuesArray:massArray];
    
    __block NSInteger updateIndex;
    [plantsCircleMoelArray enumerateObjectsUsingBlock:^(SPYPlantsCircleModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.plantsTitle isEqualToString:plantsCircleMoel.plantsTitle]){
            updateIndex = idx;
            *stop = YES;
        }
    }];
    
    [plantsCircleMoelArray replaceObjectAtIndex:updateIndex withObject:plantsCircleMoel];
    

    NSMutableArray *updateArray = [NSMutableArray array];
    [plantsCircleMoelArray enumerateObjectsUsingBlock:^(SPYPlantsCircleModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [updateArray addObject:obj.mj_keyValues];
    }];
    
    NSUserDefaults *saveuserStander = [NSUserDefaults standardUserDefaults];
    [saveuserStander setObject:updateArray forKey:SPY_PlantsCircleName];
    [saveuserStander synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:SPY_PlantsCircleNoti object:nil];
}

+ (void)SPY_RelasePlantCircleData:(SPYPlantsCircleModel *)plantsCircleMoel;{
    NSMutableArray *newsArray = [[self SPY_FetchPlantsCircleData] mutableCopy];
   
   [newsArray addObject:plantsCircleMoel.mj_keyValues];
   
   NSUserDefaults *saveuserStander = [NSUserDefaults standardUserDefaults];
   [saveuserStander setObject:newsArray forKey:SPY_PlantsCircleName];
   [saveuserStander synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:SPY_PlantsCircleNoti object:nil];
}

+ (BOOL)SPY_CurrentFlag {
    if (![self SPY_FtechPlantUserName]){
        [[SPY_PlantsTopViewController SPY_FetchTopVC] presentViewController:[SPY_PlantsLogVC new] animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}

+ (void)SPY_SetPlantsData {

    if (![self SPY_FetchPlantsKnowData]){
        NSUserDefaults *coureseList = [NSUserDefaults standardUserDefaults];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SPYPlantsZhiShi" ofType:@"json"];
        NSMutableArray *dicArray = [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:path]
                                                                   options:kNilOptions
                                                                     error:nil];
        [coureseList setObject:dicArray forKey:SPYPlantsKnowName];
        [coureseList synchronize];
    }
    
    if (![self SPY_FetchPlantsCircleData]){
        NSUserDefaults *tieziStander = [NSUserDefaults standardUserDefaults];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SPYPlantsMass" ofType:@"json"];
        NSMutableArray *dicArray = [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:path]
                                                                   options:kNilOptions
                                                                     error:nil];
        [tieziStander setObject:dicArray forKey:SPY_PlantsCircleName];
        [tieziStander synchronize];
    }
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"关闭";
    [IQKeyboardManager sharedManager].toolbarTintColor = [UIColor blackColor];
}

+ (NSMutableArray *)SPY_fetchPlantsBlackData {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"BlackListName"] ?: [NSMutableArray array];
}

+ (void)SPY_AddPlantsBlackData:(NSString *)blackdata {
   NSMutableArray *blackListData = [[self SPY_fetchPlantsBlackData] mutableCopy];
   [blackListData addObject:blackdata];
   NSUserDefaults *saveuserStander = [NSUserDefaults standardUserDefaults];
   [saveuserStander setObject:blackListData forKey:@"BlackListName"];
   [saveuserStander synchronize];
}

@end
