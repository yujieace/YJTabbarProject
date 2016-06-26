<h1>自定义的不规则TabViewController</h1></br>

<a href="http://i1.piimg.com/4851/a164f31dab2dd803.png" title="点击显示原始图片"><img src="http://i1.piimg.com/4851/a164f31dab2dd803t.jpg"></a>
<a href="http://i1.piimg.com/4851/c80c297f6c30dcaf.png" title="点击显示原始图片"><img src="http://i1.piimg.com/4851/c80c297f6c30dcaft.jpg"></a>

<h2>目标和原因</h2>
帮助用户定义属于自己的TabViewController。起因是自己的项目中需要用到一个异形的按钮，凸起在TabBar之上，</br>
比如闲鱼之类的APP的TabBar栏</br>
<img src="http://img7.qiyipic.com/image/appstore/20151221/7d/a7/201377220_89_1_1450703699402_16x9.jpg" width="200" height ="355"></br>
找了一圈找不到合适的框架，于是只能自己造轮子了。</br>

<h2>已经实现的功能</h2>
1. 添加多个viewController，并设置相应的图标
2. 自动设置图标的高亮色，设置TabBar的TintColor即可实现，默认为系统的蓝色
3. 可自定义取消高亮色，实现全彩色图标显示。
4. 隐藏和显示TabBar(使用方法见下方说明)
5. 点击产生动画效果。可自行修改代码进行自定义
6. 自定义突起的高度，便于实现更多效果
7. 可通过代码切换viewController，通过实现protocol可以实现更多自定义效果。

<h2>依赖</h2></br>
布局依赖Masonry</br>
动画依赖Pop</br>
使用Cocoapods管理依赖，所以，需要在podfile中添加：</br>
```
pod 'Masonry'
pod 'pop'
```

<h2>以下是非常接地气的文档</2>
<h3>Tips</h3>
1.该Controller的生命周期和UIViewcontroller一致，所以继承后可以使用viewDidLoad或者viewDidAppear等方法。</br>
2.adjustTintColor属性默认为YES，实际效果为官方TabBarController的效果，设置view的TintColor属性即可改变选中时的高亮色，设置为NO以后可以直接用全彩的icon图标</br>
3.bumpHeigh属性为中心的UIView凸起的高度，根据需求设置，默认为0，不凸起。</br>
4.enableTapAnimation属性决定是否启用点击时的动画，默认为启用。</br>
5.如需要对图标进行进一步的DIY，请移步iconView类中，可以自行定义相关的组件和动画。</br>
6.隐藏和显示TabBar, 为达到官方在Push时可以实现隐藏TabBar的效果，你可以在需要隐藏TabBar的时候，通过发送HIDETAB通知来实现.如下</br>
7.在显示时，原viewController的frame的大小会被重设以适应当前的显示效果，建议使用AutoLayout以便适应不同分辨率</br>


```Objective-C
//显示
[[NSNotificationCenter defaultCenter] postNotificationName:@"SHOWTAB" object:nil];

//隐藏
[[NSNotificationCenter defaultCenter] postNotificationName:@"HIDETAB" object:nil];
```

<h3>头文件和详细使用说明</h3>

```Objective-C
//
//  YJTabBarController.h
//  可自定义TabBar和中心的按钮,实现不规则的中心按钮
//  TabBar的viewController数量最少4个或者更多，可以实现较为美观的布局。如低于4个需自己实现相关的布局。

//  Created by YuJie on 16/6/13.
//  Copyright © 2016年 YuJie. All rights reserved.


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


/**
 *  YJTabBarDelegate代理对象
 */
@property (nonatomic,weak) id<YJTabBarDelegate> deleagte;

/**
 *  tabBar高度，实际为内部的scrollView的高度，也就是图标包括文字的的高度
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
 *  viewController数组，可用addObject方法添加VC或者直接赋值的方式
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
 *  重新加载tabBar内所有子视图,在viewDidAppear中执行（默认已经调用，无需自行调用）
 */
-(void)reloadViewControllers;


/**
 *  切换到指定index的ViewController
 *
 *  @param index index 从0开始
 */
-(void)switchToViewControllAtIndex:(NSInteger)index;

```
