//
//  ProgressHUD.m
//  DemoTest
//
//  Created by 宋飞龙 on 16/3/29.
//  Copyright © 2016年 宋飞龙. All rights reserved.
//

#import "ProgressHUD.h"
#define kWidth [[UIScreen mainScreen] bounds].size.width
#define kHeight [[UIScreen mainScreen] bounds].size.height
#define AUTOLAYTOU(a) ((a)*(kWidth/320))
#define WARN_WIDTH 60

@implementation ProgressHUD

+ (ProgressHUD *)progressHUD:(UIView *)view{
    static ProgressHUD * progressHUD;
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        progressHUD = [[ProgressHUD alloc] initWithFrame:view.bounds];
    });
    return progressHUD;
}

+ (void)showHUDToView:(UIView *)view {
    [[self progressHUD:view] showHUDToView:view];
}

- (void)showHUDToView:(UIView *)view {
    //加载背景
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    //加载视图
    UIImageView * loadingImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    loadingImg.image = [UIImage imageNamed:@"icon_loading"];
    
    loadingImg.layer.masksToBounds = YES;
    loadingImg.layer.cornerRadius = 50;
    //旋转动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0;
    rotationAnimation.speed = 0.3;
    rotationAnimation.cumulative = YES;
    //后台进前台动画重启
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.repeatCount = MAXFLOAT;
    [loadingImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    //背景图片
    UIImageView * centerImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    centerImg.image = [UIImage imageNamed:@"icon_lionhead"];
    //设置视图属性
    [bgView addSubview:loadingImg];
    loadingImg.center = bgView.center;
    [bgView addSubview:centerImg];
    centerImg.center = bgView.center;
    //放在当前视图上 最后设置bgView的位置
    bgView.center = self.center;
    [self addSubview:bgView];
    //将当前视图放在需要的视图上
    [view addSubview:self];
}

+ (void)showRemindCancleToView:(UIView *)view remindText:(NSString *)remindText {
    [[self progressHUD:view] showRemindCancleToView:view remindText:remindText];
}

- (void)showRemindCancleToView:(UIView *)view remindText:(NSString *)remindText {
    [self addSubview:[RemindImgAndBtnView remindBtnText:view remindText:remindText]];
    [view addSubview:self];
}

+ (void)showProgressToView:(UIView *)view remindText:(NSString *)remindText{
    [[self progressHUD:view] showProgressToView:view remindText:remindText];
}

- (void)showProgressToView:(UIView *)view remindText:(NSString *)remindText{
//    //加载背景
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    bgView.center = self.center;
    [self addSubview:bgView];
    
    UIView * bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    bgView1.backgroundColor = [UIColor clearColor];
    bgView1.layer.masksToBounds = YES;
    bgView1.layer.cornerRadius = 5;
    
    UIActivityIndicatorView *loadView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    loadView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    loadView.center =CGPointMake(bgView1.center.x, bgView1.frame.size.height-loadView.frame.size.height);
    [loadView startAnimating];
    bgView1.center = self.center;
    [bgView1 addSubview:loadView];
    [self addSubview:bgView1];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
    label.text = remindText;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [bgView1 addSubview:label];
    
    [view addSubview:self];
}

+ (void)showTextToView:(UIView *)view remindText:(NSString *)remindText{
    [[self progressHUD:view] showTextToView:view remindText:remindText];
}

- (void)showTextToView:(UIView *)view remindText:(NSString *)remindText{
    [RemindTextLabel remindTextLabel:view remindText:remindText].alpha = 0;
    [UIView animateWithDuration:2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [RemindTextLabel remindTextLabel:view remindText:remindText].alpha = 1;
                         [self addSubview:[RemindTextLabel remindTextLabel:view remindText:remindText]];
                         [view addSubview:self];
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              [RemindTextLabel remindTextLabel:view remindText:remindText].alpha = 0;
                                          } completion:^(BOOL finished) {
                                              [ProgressHUD hiddenHUD:view];
                                          }];
    }];
}

+ (void)showFailureHUDToView:(UIView *)view failureText:(NSString *)text {
    [[self progressHUD:view] showFailureHUDToView:view failureText:text];
    [ProgressHUD performSelector:@selector(hiddenHUD:) withObject:nil afterDelay:3];
}

- (void)showFailureHUDToView:(UIView *)view failureText:(NSString *)text {
    [self addSubview:[RemindView showFailureView:text toView:view]];
    [view addSubview:self];
}

+ (void)showSuccessHUDToView:(UIView *)view SuccessText:(NSString *)text {
    [[self progressHUD:view] showSuccessHUDToView:view SuccessText:text];
    [ProgressHUD performSelector:@selector(hiddenHUD:) withObject:nil afterDelay:3];
}

- (void)showSuccessHUDToView:(UIView *)view SuccessText:(NSString *)text {
    [self addSubview:[RemindView showSuccessView:text toView:view]];
    [view addSubview:self];
}

+ (void)hiddenHUD:(UIView *)view {
    for (UIView * bgview in [self progressHUD:view].subviews) {
        [bgview removeFromSuperview];
    }
    [[self progressHUD:view] removeFromSuperview];
}

@end

@interface RemindView () {
    CAShapeLayer *lineLayer;
}

@end

@implementation RemindView

+ (RemindView *)remindView:(UIView *)view {
    static RemindView * remindView;
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        remindView = [[RemindView alloc] initWithFrame:CGRectMake((view.frame.size.width-120)/2, (view.frame.size.height-120)/2, 120, 120)];
        remindView.layer.masksToBounds = YES;
        remindView.layer.cornerRadius = 5;
        remindView.backgroundColor = [UIColor blackColor];
    });
    return remindView;
}

+ (RemindView *)showFailureView:(NSString *)text toView:(UIView *)view{
    [[self remindView:view] drawFailureView];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self remindView:view].frame.size.height-25, [self remindView:view].frame.size.width, 20)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    [[self remindView:view] addSubview:label];
    return [self remindView:view];
}

+ (RemindView *)showSuccessView:(NSString *)text toView:(UIView *)view{
    [[self remindView:view] drawSuccessView];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self remindView:view].frame.size.height-25, [self remindView:view].frame.size.width, 20)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    [[self remindView:view] addSubview:label];
    return [self remindView:view];
}

- (void)drawFailureView {
    [self drawFailureView:[RemindView remindView:self]];
    [self setPopAnimation];
}

- (void)drawSuccessView {
    [self drawSuccessView:[RemindView remindView:self]];
    [self setPopAnimation];
}

- (void)drawFailureView:(UIView *)view{
    lineLayer.path = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((self.frame.size.width-WARN_WIDTH)/2, 15, WARN_WIDTH, WARN_WIDTH) cornerRadius:WARN_WIDTH/2];
    [path moveToPoint:CGPointMake((self.frame.size.width-WARN_WIDTH)/2+AUTOLAYTOU(20)-2, AUTOLAYTOU(25)+7)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2.0 + WARN_WIDTH/2-AUTOLAYTOU(20)+2, WARN_WIDTH-AUTOLAYTOU(15)+AUTOLAYTOU(3)+7)];
    [path moveToPoint:CGPointMake(self.frame.size.width/2.0 + WARN_WIDTH/2-AUTOLAYTOU(20)+2, AUTOLAYTOU(25)+7)];
    [path addLineToPoint:CGPointMake((self.frame.size.width-WARN_WIDTH)/2+AUTOLAYTOU(20)-2, WARN_WIDTH-AUTOLAYTOU(15)+AUTOLAYTOU(3)+7)];
    [self setDrawAnimationWithPath:path StrokeColor:[UIColor redColor]toView:view];
}

- (void)drawSuccessView:(UIView *)view{
    lineLayer.path = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((self.frame.size.width-WARN_WIDTH)/2, 15, WARN_WIDTH, WARN_WIDTH) cornerRadius:WARN_WIDTH/2];
    [path moveToPoint:CGPointMake((self.frame.size.width-WARN_WIDTH)/2+14, WARN_WIDTH/2+15)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2.0-5, WARN_WIDTH-5)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2.0 + WARN_WIDTH/2-16, 32)];
    [self setDrawAnimationWithPath:path StrokeColor:[UIColor greenColor] toView:view];
}

- (void)setDrawAnimationWithPath:(UIBezierPath *)path StrokeColor:(UIColor *)strokeColor toView:(UIView *)view{
    lineLayer = [CAShapeLayer layer];
    lineLayer. frame = CGRectMake(0, 0, 100, 100);
    lineLayer. fillColor = [UIColor clearColor ]. CGColor ;
    lineLayer. path = path. CGPath ;
    lineLayer. strokeColor = strokeColor. CGColor ;
    lineLayer.lineWidth = 2;
    lineLayer.cornerRadius = 5;
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani. fromValue = @0 ;
    ani. toValue = @1 ;
    ani. duration = 0.5 ;
    [lineLayer addAnimation :ani forKey : NSStringFromSelector ( @selector (strokeEnd))];
    
    [self.layer addSublayer :lineLayer];
}

- (void)setPopAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:
                                      kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];
}

@end

@implementation RemindTextLabel

+(RemindTextLabel *)remindTextLabel:(UIView *)view remindText:(NSString *)remindText{
    static RemindTextLabel * remindLabel;
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        CGFloat NewWidth ;
        CGFloat NewHeight;
        if (remindText.length == 0) {
            NewWidth = 0;
            NewHeight = 0;
        } else {
            NewWidth = kWidth - 100;
            NewHeight = 40;
        }
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGRect frame = [remindText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 40) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:dict context:nil];
        if (frame.size.width > kWidth-100) {
            frame = [remindText boundingRectWithSize:CGSizeMake(kWidth-100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:dict context:nil];
            remindLabel = [[RemindTextLabel alloc] initWithFrame:CGRectMake((view.frame.size.width-NewWidth)/2-10, (view.frame.size.height-25)/2-10, kWidth-100+20, frame.size.height + 20)];
        } else {
            remindLabel = [[RemindTextLabel alloc] initWithFrame:CGRectMake((view.frame.size.width-frame.size.width)/2-25, (view.frame.size.height-25)/2, frame.size.width+50, NewHeight)];
        }
        remindLabel.layer.masksToBounds = YES;
        remindLabel.layer.cornerRadius = 5;
        remindLabel.numberOfLines = 0;
        remindLabel.textAlignment = NSTextAlignmentCenter;
        remindLabel.font = [UIFont systemFontOfSize:15];
        remindLabel.backgroundColor = [UIColor blackColor];
        remindLabel.text = remindText;
        remindLabel.textColor = [UIColor whiteColor];
    });
    return remindLabel;
}

@end

@implementation RemindImgAndBtnView

+ (RemindImgAndBtnView *)remindBtnText:(UIView *)view remindText:(NSString *)remindText {
    static RemindImgAndBtnView * remindImgAndBtn;
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        UIImageView * img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        img1.image = [UIImage imageNamed:@"icon_loading"];
        
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGRect frame = [remindText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 40) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:dict context:nil];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, frame.size.width, 40)];
        label.text = remindText;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
 
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"icon_lionhead"] forState:UIControlStateNormal];
        button.frame = CGRectMake(50+frame.size.width, 10, 20, 20);
        [button addTarget:[ProgressHUD class] action:@selector(hiddenHUD:) forControlEvents:UIControlEventTouchUpInside];
        
        
        remindImgAndBtn = [[RemindImgAndBtnView alloc] initWithFrame:CGRectMake((kWidth-(40+img1.frame.size.width+label.frame.size.width+button.frame.size.width))/2, (kHeight-40)/2,(img1.frame.size.width+label.frame.size.width+button.frame.size.width)+40,40)];
        remindImgAndBtn.layer.masksToBounds = YES;
        remindImgAndBtn.layer.cornerRadius = 5;
        remindImgAndBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [remindImgAndBtn addSubview:img1];
        [remindImgAndBtn addSubview:label];
        [remindImgAndBtn addSubview:button];
        
    });
    return remindImgAndBtn;
}

@end

