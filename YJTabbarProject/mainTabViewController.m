//
//  mainTabViewController.m
//  YJTabbarProject
//
//  Created by hnzc on 16/6/21.
//  Copyright © 2016年 YuJay. All rights reserved.
//

#import "mainTabViewController.h"

@interface mainTabViewController ()

@end

@implementation mainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tintColor=[UIColor redColor];
    self.adjustTintColor=YES;
    self.deleagte=self;
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.centerButton.layer.cornerRadius=self.centerButton.bounds.size.height/2;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tabBarDidShowViewControllFrom:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    NSLog(@"TabBar已经从%ld 切换到了 %ld",fromIndex,toIndex);
}
-(void)tabBarCenterButtonTaped
{
    NSLog(@"CenterButton");
}
@end
