//
//  YJTabBarController.h
//  可自定义TabBar和中心的按钮,实现不规则的中心按钮
//  TabBar的viewController数量最少4个或者更多，可以实现较为美观的布局。如低于4个需自己实现相关的布局。
//  TabBar可以隐藏，通过发送对应的通知即可
//  显示TabBar: [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOWTAB" object:nil];
//  隐藏TabBar: [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDETAB" object:nil];

//  Created by YuJie on 16/6/13.
//  Copyright © 2016年 YuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SHOWTAB @"SHOWTAB"
#define HIDETAB @"HIDETAB"

/**
 *  该protocol的生命周期和UIViewController一致
 */
@protocol YJTabBarDelegate <NSObject>
@optional


/**
 *  中心按钮被点击时
 */
-(void)tabBarCenterButtonTaped;

/**
 *  即将显示选中的viewcontroller
 *
 *  @param fromIndex 当前index值
 *  @param toIndex   即将跳转的index值
 */
-(void)tabbarWillShowViewControllerFrom:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

/**
 *  已经显示对应的viewController
 *
 *  @param fromIndex 原来的index值
 *  @param toIndex   现在的index值
 */
-(void)tabBarDidShowViewControllFrom:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

/**
 *  tabBar即将隐藏
 */
-(void)tabBarwillHide;

/**
 *  tabBar已经隐藏
 */
-(void)tabBarDidHide;

/**
 *  tabBar即将显示
 */
-(void)tabbarWillShow;

/**
 *  tabBar已经显示
 */
-(void)tabbarDidShow;
@end

@interface YJTabBarController : UIViewController
{
    NSMutableArray *indexButton;
    NSInteger currentIndex;
    UIView *currentView;
    UIScrollView *scrollBar;
    CGPoint center;
    BOOL isHide;
}

/**
 *  YJTabBarDelegate代理对象
 */
@property (nonatomic,weak) id<YJTabBarDelegate> deleagte;

/**
 *  tabBar高度，实际为内部的scrollView的高度
 */
@property CGFloat tabHeight;
/**
 *  默认的图标，若与normalImages都未设置则图标为空
 */
@property (nonatomic,strong) UIImage *defaultIcon;
/**
 *  中心按钮背景图片
 */
@property (nonatomic,strong) UIImage *CenterImage;

/**
 *  tabBar背景色
 */
@property (nonatomic,strong) UIColor *backGroundColor;
/**
 *  viewController数组
 */
@property (nonatomic,strong) NSMutableArray *viewControllers;

/**
 *  未选中时的图标(UIImage)，若无则默认为defaultIcon
 */
@property (nonatomic,strong) NSMutableArray *normalImages;

/**
 *  选中时的图标形态(UIImage)，adjustTintColor为NO时必须设置
 */
@property (nonatomic,strong) NSMutableArray *selectedImages;

/**
 *  tabBar,可修改添加自定义控件
 */
@property (nonatomic,strong,readonly) UIView *tabBar;

/**
 *  中心按钮，UIView,可自定义内容
 */
@property (nonatomic,strong) UIView *centerButton;

/**
 *  中心按钮凸起高度,若不凸起则不用设置获设置为0
 */
@property CGFloat bumpHeigh;

/**
 *  是否启用自适应TintColorl样式，默认为YES启用，设置为NO则需要设置selectedImages
 */
@property BOOL adjustTintColor;

/**
 *  启用点击动画，默认为YES
 */
@property BOOL enableTapAnimation;

/**
 *  默认初始化
 *
 *  @return ADTabBarController
 */
-(instancetype)init;

/**
 *  重新加载tabBar内所有子视图,在viewDidAppear中执行
 */
-(void)reloadViewControllers;


/**
 *  切换到指定index的ViewController
 *
 *  @param index index 从0开始
 */
-(void)switchToViewControllAtIndex:(NSInteger)index;


@end


