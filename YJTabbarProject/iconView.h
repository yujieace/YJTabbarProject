//
//  iconView.h
//  TabBar图标
//
//  Created by YuJie on 16/6/13.
//  Copyright © 2016年 YuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

typedef void(^tapBlock)(NSInteger tag);
@interface iconView : UIView
{
    tapBlock cellTapedBlock;
    UITapGestureRecognizer *tap;
}
/**
 *  标题Label
 */
@property (nonatomic,strong) UILabel *title;

/**
 *  图标ImageView
 */
@property (nonatomic,strong) UIImageView *icon;


@property BOOL enableTapAnimation;
/**
 *  初始化
 *
 *  @param frame CGRect
 *
 *  @return instancetype
 */
-(instancetype)initWithFrame:(CGRect)frame;

/**
 *  设置点击后的Block回调
 *
 *  @param block tapBlock
 */
-(void)setTapedBlock:(tapBlock)block;

/**
 *  设置图标文字颜色
 *
 *  @param color UIColor
 */
-(void)setTitleColor:(UIColor *)color;
@end
