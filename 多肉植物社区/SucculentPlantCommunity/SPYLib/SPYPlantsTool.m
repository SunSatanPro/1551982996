//
//  SPYPlantsTool.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPYPlantsTool.h"

@implementation SPY_PlantsTopViewController

+ (UIViewController*)SPY_FetchTopVC
{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

@end

@implementation SPY_TextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self buildingDefaultParamsAndAddObserver];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildingDefaultParamsAndAddObserver];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self buildingDefaultParamsAndAddObserver];
    }
    return self;
}

- (void)buildingDefaultParamsAndAddObserver {
    
    _placeholderFont = [UIFont systemFontOfSize:13];
    
    _placeholderColor = [UIColor grayColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textChange:(NSNotification *)notification {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (self.text.length > 0) { } else {
        NSDictionary *dictionary = @{NSFontAttributeName: _placeholderFont, NSForegroundColorAttributeName: _placeholderColor};
        [self.placeholder drawInRect:CGRectMake(5, 5, self.bounds.size.width, self.bounds.size.height) withAttributes:dictionary];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark - setter methods
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

@end

@implementation SVProgressHUD (SPY)

+ (void)SPY_ShowPlantsErrortext:(NSString *)Message{
    
    [SVProgressHUD showErrorWithStatus:Message];
    
    [SVProgressHUD dismissWithDelay:2.0f];
}


+ (void)SPY_ShowPlantsTruertext:(NSString *)Message{
    
    [SVProgressHUD showSuccessWithStatus:Message];
    
    [SVProgressHUD dismissWithDelay:1.0f];
}

@end


@implementation UIView (SPYMaskToBouns)

- (void)SPY_PlantsCornerWidth:(CGFloat)cornerRadius {
    
    self.layer.cornerRadius = cornerRadius;
    
    self.layer.masksToBounds = YES;
}

- (void)SPY_PlantsCornerWidth:(CGFloat)cornerRadius andBorderWith:(CGFloat)Borderwidth andBorderColor:(UIColor *)borderColor {
    
    self.layer.cornerRadius = cornerRadius;
       
    self.layer.masksToBounds = YES;
    
    self.layer.borderWidth = Borderwidth;
    
    self.layer.borderColor = borderColor.CGColor;
}


@end

@implementation SPY_ReportPlantsHandle

+ (void)SPY_ReportPlants {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"垃圾信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SPY_ModalReportText];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"涉嫌侵权" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SPY_ModalReportText];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"黄赌毒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SPY_ModalReportText];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"违纪违法" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SPY_ModalReportText];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"政治敏感" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SPY_ModalReportText];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"广告" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SPY_ModalReportText];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"令人厌恶" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SPY_ModalReportText];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SPY_ModalReportText];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[SPY_PlantsTopViewController SPY_FetchTopVC] presentViewController:alertVC animated:YES completion:nil];
    }];
    
}


+ (void)SPY_ModalReportText {
    [SVProgressHUD SPY_ShowPlantsTruertext:@"举报成功！我们会尽快处理这条信息"];
}

@end

@implementation SPY_PlantsImageTools

+ (void)selectImageWithVC:(UIViewController *)viewcontroller selectedImage:(user_select_Image_block)selectImage {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
    
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = YES;
    
    
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowCrop = NO;
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count > 0) {
            selectImage(photos[0]);
        }
    }];
    
    [viewcontroller presentViewController:imagePickerVc animated:YES completion:nil];
}

+ (void)SPY_CheckPlantsBigImage:(NSString *)imageUrl AndImageData:(NSData *)imageData {
    SPY_PlantImage_ViewController *plants_ImageVC = [SPY_PlantImage_ViewController new];
    plants_ImageVC.SPY_PlantsUrl = imageUrl;
    plants_ImageVC.SPY_PlantsData = imageData;
    plants_ImageVC.modalPresentationStyle = 0;
    [[SPY_PlantsTopViewController SPY_FetchTopVC] presentViewController:plants_ImageVC animated:YES completion:nil];
}
@end


@implementation SPY_PresentPlantsAgreeVC

+ (void)SPY_PresentAgreeVC {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"在使用《多肉植物社区》发布社区帖子以及发表评论时您必须遵守法律法规，以下是必须遵守的社区规则:\n1.禁止发布和传播破坏社会的违法信息.\n2.不得侵犯他人隐私权。\n3.禁止发布政治敏感内容。\n4.不得发布虚假信息，欺骗他人，不得发布黄赌毒信息.\n5.禁止发布一切 违行为" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [[SPY_PlantsTopViewController SPY_FetchTopVC] presentViewController:alertVC animated:YES completion:nil];
    });
}

@end
