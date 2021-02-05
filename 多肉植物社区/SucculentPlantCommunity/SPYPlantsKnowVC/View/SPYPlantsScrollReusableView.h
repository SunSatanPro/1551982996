//
//  SPYPlantsScrollReusableView.h
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPYPlantsScrollReusableView : UICollectionReusableView

@property (nonatomic ,strong) NSArray <SPYPlantsKnowModel *> *SPYPlantsKnowListData;

@end

NS_ASSUME_NONNULL_END
