//
//  ProgressHUD.h
//  DemoTest
//
//  Created by 宋飞龙 on 16/3/29.
//  Copyright © 2016年 宋飞龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RemindView;

@interface ProgressHUD : UIView

/**
 *  将HUD放在所需的视图上
 *
 */
+ (void)showHUDToView:(UIView *)view;

/**
 *  失败提示框
 *
 *  @param view 目标视图
 *  @param text 提示文字
 */
+ (void)showFailureHUDToView:(UIView *)view failureText:(NSString *)text;

/**
 *  成功提示框
 *
 *  @param view 目标视图
 *  @param text 提示文字
 */
+ (void)showSuccessHUDToView:(UIView *)view SuccessText:(NSString *)text;

/**
 *  去除HUD从当前视图
 */
+ (void)hiddenHUD:(UIView *)view;
@end

@interface RemindView : UIView

+ (RemindView *)remindView:(UIView *)view;

+ (RemindView *)showFailureView:(NSString *)text toView:(UIView *)view;

+ (RemindView *)showSuccessView:(NSString *)text toView:(UIView *)view;

@end