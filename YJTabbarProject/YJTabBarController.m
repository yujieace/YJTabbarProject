//
//  YJTabBarController.m

//  Created by YuJie on 16/6/13.
//  Copyright © 2016年 YuJie. All rights reserved.
//

#import "YJTabBarController.h"
#import <Masonry.h>
#import "iconView.h"
#import <POPBasicAnimation.h>
#import <POPSpringAnimation.h>
@implementation YJTabBarController
-(instancetype)init
{
    self=[super init];
    isHide=false;
    _enableTapAnimation=YES;
    _adjustTintColor=YES;
    _selectedImages=[[NSMutableArray alloc] init];
    _normalImages=[[NSMutableArray alloc] init];
    return self;
}
-(void)viewDidLoad
{
    currentIndex=0;
    [self initUI];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HIDETAB" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOWTAB" object:nil];
}
-(void)hide
{
    
    if(!isHide)
    {
        isHide=true;
        if([self.deleagte respondsToSelector:@selector(tabBarwillHide)])
        {
            [self.deleagte tabBarwillHide];
        }
        POPBasicAnimation *pop=[POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        pop.toValue=[NSValue valueWithCGPoint:CGPointMake(center.x, -center.y)];//[NSValue valueWithCGPoint:CGPointMake(_tabBar.center.x, _tabBar.center.y+_tabBar.bounds.size.height)];
        pop.duration=0.2;
        [_tabBar pop_addAnimation:pop forKey:@"pop"];
        [self switchToViewControllAtIndex:currentIndex];
        
        currentView.frame=self.view.bounds;
        [self.view insertSubview:currentView belowSubview:_tabBar];
        if([self.deleagte respondsToSelector:@selector(tabBarDidHide)])
        {
            [self.deleagte tabBarDidHide];
        }
    }
    
    
}

-(void)show
{
    if(isHide)
    {
        isHide=false;
        if([self.deleagte respondsToSelector:@selector(tabbarWillShow)])
        {
            [self.deleagte tabbarWillShow];
        }
        POPBasicAnimation *pop=[POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        pop.toValue=[NSValue valueWithCGPoint:center];//[NSValue valueWithCGPoint:CGPointMake(_tabBar.center.x,_tabBar.center.y-_tabBar.bounds.size.height)];
        pop.duration=0.2;
        [_tabBar pop_addAnimation:pop forKey:@"pop1"];
        currentView.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-_tabBar.bounds.size.height);
        [self.view insertSubview:currentView belowSubview:_tabBar];
        
        if ([self.deleagte respondsToSelector:@selector(tabbarDidShow)]) {
            [self.deleagte tabbarDidShow];
        }
    }
    
}

/**
 *  初始化内部控件
 */
-(void)initUI
{
    _tabBar=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-50-_bumpHeigh, self.view.bounds.size.width, 50+_bumpHeigh)];
    _tabBar.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tabBar];
    center=_tabBar.center;
    scrollBar=[[UIScrollView alloc] init];
    scrollBar.backgroundColor=_backGroundColor==nil?[UIColor whiteColor]:_backGroundColor;
    scrollBar.scrollEnabled=YES;
    scrollBar.pagingEnabled=YES;
    scrollBar.showsHorizontalScrollIndicator=NO;
    [_tabBar addSubview:scrollBar];
    [scrollBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_tabBar);
        make.bottom.equalTo(_tabBar);
        make.centerX.equalTo(_tabBar);
        make.height.equalTo([NSNumber numberWithFloat:_tabHeight>50?_tabHeight:50]);
    }];
    
    if(_centerButton==nil)
    {
        _centerButton=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        _centerButton.center=_tabBar.center;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCenterTap:)];
        [_centerButton addGestureRecognizer:tap];
        [_tabBar addSubview:_centerButton];
        _centerButton.layer.contents=(__bridge id _Nullable)(_CenterImage.CGImage);
        [_centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(scrollBar.mas_height).offset(0);
            make.height.equalTo(scrollBar.mas_height).offset(0);
            make.centerX.equalTo(scrollBar);
            make.centerY.equalTo(scrollBar).offset(_bumpHeigh>0?-_bumpHeigh:0);
            
        }];
    }
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [self reloadViewControllers];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide) name:@"HIDETAB" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show) name:@"SHOWTAB" object:nil];
}

/**
 *  加载并布局tabBar内容
 */
-(void)reloadViewControllers
{
    if(indexButton==nil)
    {
        indexButton=[[NSMutableArray alloc] init];
    }
    else
    {
        for (UIView *temp in indexButton) {
            [temp removeFromSuperview];
        }
        [indexButton removeAllObjects];
    }
    NSInteger count=_viewControllers.count<=4?_viewControllers.count:4;
    CGFloat width=(scrollBar.bounds.size.width-_centerButton.bounds.size.width)/count;
    CGFloat height=scrollBar.bounds.size.height;
    CGFloat lastWidth=0;
    scrollBar.contentSize=CGSizeMake(_tabBar.bounds.size.width*((_viewControllers.count%4==0?(_viewControllers.count/4):(_viewControllers.count/4+1))), height);
    
    for (int i=0; i<_viewControllers.count/4+1; i++) {
        for (int j=0;j<4; j++) {
            
            if((4*i+j)>_viewControllers.count-1)
                break;
            iconView *icon;
            if(j==2)
            {
                lastWidth+=_centerButton.bounds.size.width;
                icon=[[iconView alloc] initWithFrame:CGRectMake(lastWidth, 0, width, height)];
                lastWidth+=width;
            }
            else
            {
                
                icon=[[iconView alloc] initWithFrame:CGRectMake(lastWidth, 0, width, height)];
                lastWidth+=width;
            }
            icon.enableTapAnimation=_enableTapAnimation;
            icon.tag=4*i+j;
            UIViewController *dest=[_viewControllers objectAtIndex:(4*i+j)];
            icon.title.text=dest.title.length>0?dest.title:@"默认标题";
            icon.title.textColor=[UIColor grayColor];
            UIImage *iconImage=_normalImages.count==_viewControllers.count?[_normalImages objectAtIndex:4*i+j]:_defaultIcon;
            if(_adjustTintColor)
            {
                icon.tintAdjustmentMode=UIViewTintAdjustmentModeDimmed;
                iconImage=[iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }
            icon.icon.image=iconImage;
            [scrollBar addSubview:icon];
            [indexButton addObject:icon];
            __weak __typeof(&*self)weakSelf = self;
            [icon setTapedBlock:^(NSInteger tag) {
                [weakSelf switchToViewControllAtIndex:tag];
            }];
        }
    }
    [self switchToViewControllAtIndex:currentIndex];
}

-(void)switchToViewControllAtIndex:(NSInteger)index
{
    if([self.deleagte respondsToSelector:@selector(tabbarWillShowViewControllerFrom:toIndex:)])
    {
        [self.deleagte tabbarWillShowViewControllerFrom:currentIndex toIndex:index];
    }
    iconView *icon=[indexButton objectAtIndex:currentIndex];
    icon.title.textColor=[UIColor grayColor];
    
    
    iconView *currentIcon=[indexButton objectAtIndex:index];
    currentIcon.title.textColor=self.view.tintColor;
    
    if(_normalImages.count<1||_normalImages.count<=index)
    {
        icon.icon.image=nil;
    }
    else
    {
        icon.icon.image=[_normalImages objectAtIndex:currentIndex];
    }
    
    if(_selectedImages.count<1||_selectedImages.count<=index)
    {
        currentIcon.icon.image=nil;
    }
    else
    {
        currentIcon.icon.image=[_selectedImages objectAtIndex:currentIndex];
    }
    
    if(_adjustTintColor)
    {
        icon.tintAdjustmentMode=UIViewTintAdjustmentModeDimmed;
        icon.icon.image=[icon.icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        currentIcon.tintAdjustmentMode=UIViewTintAdjustmentModeNormal;
        currentIcon.icon.image=[currentIcon.icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    UIViewController *dest=[_viewControllers objectAtIndex:index];
    UIView *view=dest.view;
    view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-_tabBar.bounds.size.height+_bumpHeigh);
    [currentView removeFromSuperview];
    currentView=view;
    [self.view insertSubview:view belowSubview:_tabBar];
    if([self.deleagte respondsToSelector:@selector(tabBarDidShowViewControllFrom:toIndex:)])
    {
        [self.deleagte tabBarDidShowViewControllFrom:currentIndex toIndex:index];
    }
    currentIndex=index;
}

/**
 *  此处写入中心按钮按下时应该进行的处理，若内部放入自定义的按钮，可不必在这里操作
 *
 *  @param sender
 */
-(void)handleCenterTap:(UITapGestureRecognizer *)sender
{
    if(_enableTapAnimation)
    {
        POPSpringAnimation *rotate=[POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
        rotate.springBounciness=15;
        CGRect rect=_centerButton.frame;
        rotate.fromValue=[NSValue valueWithCGSize:CGSizeMake(rect.size.width*0.8, rect.size.height*0.8)];
        rotate.toValue=[NSValue valueWithCGSize:rect.size];
        rotate.animationDidReachToValueBlock=^(POPAnimation *ani)
        {
            if([self.deleagte respondsToSelector:@selector(tabBarCenterButtonTaped)])
            {
                [self.deleagte tabBarCenterButtonTaped];
            }
        };
        [_centerButton pop_addAnimation:rotate forKey:@"pop"];
    }
    else
    {
        if([self.deleagte respondsToSelector:@selector(tabBarCenterButtonTaped)])
        {
            [self.deleagte tabBarCenterButtonTaped];
        }
    }
    
    
    
}


@end
