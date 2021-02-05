//
//  SPYPlantsTool.h
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TZImagePickerController.h>
#import <SVProgressHUD.h>
NS_ASSUME_NONNULL_BEGIN

@interface SPY_PlantsTopViewController : NSObject

+ (UIViewController*)SPY_FetchTopVC;

@end

@interface SPY_TextView : UITextView

@property (nonatomic, copy) NSString * placeholder;

@property (nonatomic, strong) UIFont * placeholderFont;

@property (nonatomic, strong) UIColor * placeholderColor;

@end

@interface SVProgressHUD (SPY)

+ (void)SPY_ShowPlantsErrortext:(NSString *)Message;

+ (void)SPY_ShowPlantsTruertext:(NSString *)Message;


@end

@interface UIView (SPYMaskToBouns)

- (void)SPY_PlantsCornerWidth:(CGFloat)cornerRadius;

- (void)SPY_PlantsCornerWidth:(CGFloat)cornerRadius andBorderWith:(CGFloat)Borderwidth andBorderColor:(UIColor *)borderColor;

@end

@interface SPY_ReportPlantsHandle : NSObject

+ (void)SPY_ReportPlants;

@end

typedef void(^user_select_Image_block)(UIImage *image);

@interface SPY_PlantsImageTools : NSObject <TZImagePickerControllerDelegate>

+ (void)selectImageWithVC:(UIViewController *)viewcontroller selectedImage:(user_select_Image_block)selectImage;

+ (void)SPY_CheckPlantsBigImage:(NSString *)imageUrl AndImageData:(NSData *)imageData;
@end


@interface SPY_PresentPlantsAgreeVC : NSObject

+ (void)SPY_PresentAgreeVC;

@end

NS_ASSUME_NONNULL_END
