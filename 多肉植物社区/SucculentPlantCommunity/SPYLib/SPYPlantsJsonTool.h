//
//  SPYPlantsJsonTool.h
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPYPlantUserModel.h"
#import "SPYPlantsCircleModel.h"
#import "SPYPlantsKnowModel.h"

#define SPY_AccountName    @"18176765344"
#define SPY_AccountPWD    @"12345678"

#define SPYPlantsKnowName @"SPYPlantsKnowName"
#define SPY_PlantsCircleName  @"SPY_PlantsCircleName"

#define SPY_PlantsUserLoginNotification  @"SPY_PlantsUserLoginNotification"
#define SPY_PlantsCircleNoti  @"SPY_PlantsCircleNoti"
#define SPY_PlantsKnowNoti  @"SPY_PlantsKnowNoti"
NS_ASSUME_NONNULL_BEGIN

@interface SPYPlantsJsonTool : NSObject

+(NSString *)SPY_FtechPlantUserName;

+(void)SPY_ModiifyPlantUserName:(NSString *)userName;

+ (void)SPY_DeletePlantUserName;

+ (NSMutableArray *)SPY_FetchPlantsUsers;

+ (void)SPY_ResignPlantUser:(SPYPlantUserModel *)userModel;

+ (NSMutableArray *)SPY_FetchPlantsKnowData;

+ (void)SPY_LikePlantsKnowData:(SPYPlantsKnowModel *)plantsKnowModel;

+ (NSMutableArray *)SPY_FetchPlantsCircleData;

+ (void)SPY_ModifyPlantCircleData:(SPYPlantsCircleModel *)plantsCircleMoel;

+ (void)SPY_RelasePlantCircleData:(SPYPlantsCircleModel *)plantsCircleMoel;

+ (NSString *)SPY_FetchNowadaysStr;

+ (BOOL)SPY_CurrentFlag;

+ (void)SPY_SetPlantsData;

+ (NSMutableArray *)SPY_fetchPlantsBlackData;

+ (void)SPY_AddPlantsBlackData:(NSString *)blackdata;


@end

NS_ASSUME_NONNULL_END
