//
//  SPY_PlantsAgreeVC.m
//  SucculentPlantCommunity
//
//  Created by MacBookPro on 2021/2/3.
//  Copyright © 2021 SucculentPlantCommunity. All rights reserved.
//

#import "SPY_PlantsAgreeVC.h"

@interface SPY_PlantsAgreeVC ()

@property (weak, nonatomic) IBOutlet UITextView *SPY_PactTextView;

@end

@implementation SPY_PlantsAgreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.SPY_PactTextView setEditable:NO];
}


- (IBAction)SPY_ClosePlantsLog:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
