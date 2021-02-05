//
//  SPY_PlantImage_ViewController.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPY_PlantImage_ViewController.h"

@interface SPY_PlantImage_ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *SPYPlantImageView;

@end

@implementation SPY_PlantImage_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SPYPlantImageUI];
    
    
}

-  (void)SPYPlantImageUI {
    if (self.SPY_PlantsData) {
        self.SPYPlantImageView.image = [UIImage imageWithData:self.SPY_PlantsData];
    }else {
        if ([self.SPY_PlantsUrl hasPrefix:@"http"]){
            [self.SPYPlantImageView sd_setImageWithURL:[NSURL URLWithString:self.SPY_PlantsUrl]];
        }else {
            self.SPYPlantImageView.image = [UIImage imageNamed:self.SPY_PlantsUrl];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
