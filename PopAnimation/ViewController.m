//
//  ViewController.m
//  PopAnimation
//
//  Created by HQK on 2017/9/11.
//  Copyright © 2017年 ultrarich. All rights reserved.
//

#import "ViewController.h"

#define kScreenBounds ([UIScreen mainScreen].bounds)

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface ViewController ()

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIButton *suspendBtn;

@property (nonatomic, strong) UIImageView *passengerPublishImageView;

@property (nonatomic, strong) UIImageView *driverPublishImageView;

@end

static BOOL suspendBtnIsSelected = YES;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSuspendBtn];
    
}

#pragma mark - 创建浮动按钮
- (void)createSuspendBtn
{
    self.coverView = [[UIView alloc] initWithFrame:kScreenBounds];
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0.4f;
    UITapGestureRecognizer *coverViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePublishBtn)];
    [self.coverView addGestureRecognizer:coverViewTap];
    [self.view addSubview:self.coverView];
    self.coverView.hidden = YES;
    self.passengerPublishImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 73, kScreenHeight - 286, 73, 73)];
    self.passengerPublishImageView.layer.cornerRadius = 36.5f;
    self.passengerPublishImageView.layer.masksToBounds = YES;
    [self.view addSubview:self.passengerPublishImageView];
    self.driverPublishImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 73, kScreenHeight - 286, 73, 73)];
    self.driverPublishImageView.layer.cornerRadius = 36.5f;
    self.driverPublishImageView.layer.masksToBounds = YES;
    [self.view addSubview:self.driverPublishImageView];
    self.suspendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.suspendBtn.frame = CGRectMake(kScreenWidth - 73, kScreenHeight - 286, 73, 73);
    self.suspendBtn.layer.cornerRadius = 36.5f;
    self.suspendBtn.layer.masksToBounds = YES;
    [self.suspendBtn setBackgroundImage:[UIImage imageNamed:@"publish_add_normal"] forState:UIControlStateNormal];
    [self.suspendBtn addTarget:self action:@selector(showPublishImageView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.suspendBtn];
}

#pragma mark - 隐藏视图动画
- (void)hidePublishBtn
{
    self.coverView.hidden = YES;
    [UIView animateWithDuration:0.3f animations:^{
        self.coverView.hidden = YES;
        self.driverPublishImageView.frame = CGRectMake(kScreenWidth - 73, kScreenHeight - 286, 73, 73);
        self.passengerPublishImageView.frame = CGRectMake(kScreenWidth - 73, kScreenHeight - 286, 73, 73);
        
        CGAffineTransform transform = CGAffineTransformMakeRotation(0);
        [self.suspendBtn setTransform:transform];
    } completion:^(BOOL finished) {
        self.passengerPublishImageView.image = [UIImage imageNamed:@""];
        self.driverPublishImageView.image = [UIImage imageNamed:@""];
        suspendBtnIsSelected = YES;
    }];
}

#pragma mark - 展示视图动画
- (void)showPublishImageView
{
    if (suspendBtnIsSelected) {
        [UIView animateWithDuration:0.3f animations:^{
            self.coverView.hidden = NO;
            self.passengerPublishImageView.frame = CGRectMake(kScreenWidth - 180, kScreenHeight - 360, 104, 104);
            self.passengerPublishImageView.image = [UIImage imageNamed:@"passengerpublish_icon"];
            self.driverPublishImageView.frame = CGRectMake(kScreenWidth - 180, kScreenHeight - 240, 104, 104);
            self.driverPublishImageView.image = [UIImage imageNamed:@"driverpublish_icon"];
            CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
            [self.suspendBtn setTransform:transform];
        } completion:^(BOOL finished) {
            UITapGestureRecognizer *driverTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushDriverPublish)];
            [self.driverPublishImageView addGestureRecognizer:driverTap];
            UITapGestureRecognizer *passengerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushPassengerPublish)];
            [self.passengerPublishImageView addGestureRecognizer:passengerTap];
            self.driverPublishImageView.userInteractionEnabled = YES;
            self.passengerPublishImageView.userInteractionEnabled = YES;
            suspendBtnIsSelected = NO;
        }];
    }else
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.coverView.hidden = YES;
            self.driverPublishImageView.frame = CGRectMake(kScreenWidth - 73, kScreenHeight - 286, 73, 73);
            self.passengerPublishImageView.frame = CGRectMake(kScreenWidth - 73, kScreenHeight - 286, 73, 73);
            
            CGAffineTransform transform = CGAffineTransformMakeRotation(0);
            [self.suspendBtn setTransform:transform];
        } completion:^(BOOL finished) {
            self.passengerPublishImageView.image = [UIImage imageNamed:@""];
            self.driverPublishImageView.image = [UIImage imageNamed:@""];
            suspendBtnIsSelected = YES;
        }];
    }
}

- (void)pushDriverPublish
{
    NSLog(@"发布空座位");
}

- (void)pushPassengerPublish
{
    NSLog(@"我要约车");
}

@end
