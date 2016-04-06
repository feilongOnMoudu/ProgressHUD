//
//  ProgressHUD.h
//  DemoTest
//
//  Created by 宋飞龙 on 16/3/29.
//  Copyright © 2016年 宋飞龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RemindView;
@class RemindTextLabel;
@class RemindImgAndBtnView;

@interface ProgressHUD : UIView

/**
 *  将HUD放在所需的视图上 自定义图片
 *
 */
+ (void)showHUDToView:(UIView *)view;

/**
 *  加转菊花HUD放在所需视图上
 *
 */
+ (void)showProgressToView:(UIView *)view remindText:(NSString *)remindText;

/**
 *  带关闭效果的HUD
 *
 */
+ (void)showRemindCancleToView:(UIView *)view remindText:(NSString *)remindText;

/**
 *  将提示文字放在所需的视图上
 *
 */
+ (void)showTextToView:(UIView *)view remindText:(NSString *)remindText;

/**
 *  失败提示框
 *
 */
+ (void)showFailureHUDToView:(UIView *)view failureText:(NSString *)text;

/**
 *  成功提示框
 *
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

@interface RemindTextLabel : UILabel

+ (RemindTextLabel *)remindTextLabel:(UIView *)view remindText:(NSString *)remindText;

@end


@interface RemindImgAndBtnView : UIView

+ (RemindImgAndBtnView *)remindBtnText:(UIView *)view remindText:(NSString *)remindText;
@end




