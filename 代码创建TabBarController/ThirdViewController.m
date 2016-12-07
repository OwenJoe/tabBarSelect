//
//  ThirdViewController.m
//  代码创建TabBarController
//
//  Created by imac on 16/8/15.
//  Copyright © 2016年 imac. All rights reserved.
//

#import "ThirdViewController.h"
#import "WBTabBarController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"二级子页面";
    self.view.backgroundColor = [UIColor yellowColor];
    
    //设置代理
    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
    //启用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, self.view.frame.size.height/2, 150, 50)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"我要跳到个人中心" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClickMethod) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark -- 点击跳转
-(void)btnClickMethod{
    
    //跳到TabBar的另一个item页面-->父级控制器
    //偷懒了,使用通知,大家可以使用代理或者block都可以
    [[NSNotificationCenter defaultCenter]postNotificationName:@"jumpItem" object:nil];
    
    //跳转同时,耗时异步操作,返回到自己的父级控制器,否则待会点击本身父级控制器,显示的依旧是子级页面,就糗大大
    //已经通过内存泄漏测试,完好,没有问题
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        dispatch_async(dispatch_get_main_queue(), ^{
            // 返回父级页面
            [self.navigationController popViewControllerAnimated:YES];
        });
    });

}

@end
