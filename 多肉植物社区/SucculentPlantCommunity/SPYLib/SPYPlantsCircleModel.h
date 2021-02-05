//
//  SPYPlantsCircleModel.h
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPYPlantsCircleModel : NSObject

@property (nonatomic , copy) NSString *plantsTitle;

@property (nonatomic , copy) NSString *plantsBody;

@property (nonatomic , copy) NSString *fabuTime;

@property (nonatomic , copy) NSString *plantsIMGUrl;

@property (nonatomic , strong) NSData *plantsIMGData;

@property (nonatomic , copy) NSString *zanCount;

@property (nonatomic , copy) NSString *isZan;

@property (nonatomic , copy) NSString *State;

@property (nonatomic , strong) NSArray *plantsCommentArray;

@property (nonatomic , copy) NSString *fabuRen;

@property (nonatomic , copy) NSString *SPYIsLike;

@end

@interface SPYPlantsCircleSayModel : NSObject

@property (nonatomic , copy) NSString *plantsCMText;

@property (nonatomic , copy) NSString *plantsCMfabuRen;

@property (nonatomic , copy) NSString *commentTime;

@property (nonatomic , copy) NSString *State;

@property (nonatomic , copy) NSString *isZan;

@end

NS_ASSUME_NONNULL_END
