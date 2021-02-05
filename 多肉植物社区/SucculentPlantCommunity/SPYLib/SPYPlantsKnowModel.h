//
//  SPYPlantsKnowModel.h
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPYPlantsKnowModel : NSObject

@property (nonatomic , copy) NSString *plantsKnowTitle;

@property (nonatomic , copy) NSString *postDateTime;

@property (nonatomic , copy) NSString *plantsImageUrl;

@property (nonatomic , copy) NSString *plantsKnowBody;

@property (nonatomic , copy) NSString *SPYIsLike;

@end

NS_ASSUME_NONNULL_END
