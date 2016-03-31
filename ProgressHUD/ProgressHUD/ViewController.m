//
//  ViewController.m
//  ProgressHUD
//
//  Created by 宋飞龙 on 16/3/30.
//  Copyright © 2016年 宋飞龙. All rights reserved.
//

#import "ViewController.h"
#import "ProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)show:(id)sender {
    [ProgressHUD showHUDToView:self.view];
    [self performSelector:@selector(removeHUD) withObject:nil afterDelay:3];
}

- (void)removeHUD {
    [ProgressHUD hiddenHUD:self.view];
}

- (IBAction)success:(id)sender {
    //[ProgressHUD showSuccessHUDToView:self.view SuccessText:@"大龙哥"];
    [ProgressHUD showTextToView:self.view remindText:@"大龙哥"];    
}

- (IBAction)failure:(id)sender {
    [ProgressHUD showFailureHUDToView:self.view failureText:@"大龙哥"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
