//
//  iconView.m
//  TabBar图标
//
//  Created by YuJie on 16/6/13.
//  Copyright © 2016年 YuJie. All rights reserved.
//

#import "iconView.h"
#import <POPSpringAnimation.h>
@implementation iconView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    _enableTapAnimation=YES;
    self.backgroundColor=[UIColor clearColor];
    _title=[[UILabel alloc] init];
    _title.text=@"默认标题";
    _title.textAlignment=NSTextAlignmentCenter;
    _title.font=[UIFont systemFontOfSize:12 weight:-0.05];
    [self addSubview:_title];
    [_title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.equalTo(self);
        make.centerX.equalTo(self);
        make.height.equalTo([NSNumber numberWithInt:15]);
    }];
    
    _icon=[[UIImageView alloc] init];
    _icon.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(_title.mas_top).offset(-2);
        make.width.equalTo(_icon.mas_height);
        make.centerX.equalTo(self);
    }];

    tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTaped)];
    [self addGestureRecognizer:tap];
    return self;
}

-(void)setTapedBlock:(tapBlock)block
{
    cellTapedBlock=block;
}

-(void)handleTaped
{
    //点击的动画，可以自行改写，此处用的是POPSpringAnimation，可以自己用CoreAnimation或者其他动画框架
    if(_enableTapAnimation)
    {
        POPSpringAnimation *rotate=[POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
        rotate.springBounciness=15;
        CGRect rect=self.frame;
        rotate.fromValue=[NSValue valueWithCGSize:CGSizeMake(rect.size.width*0.8, rect.size.height*0.8)];
        rotate.toValue=[NSValue valueWithCGSize:rect.size];
        [self pop_addAnimation:rotate forKey:@"pop"];
    }
    
    if(cellTapedBlock!=nil)
    {
        cellTapedBlock(self.tag);
    }
}

-(void)setTitleColor:(UIColor *)color
{
    _title.textColor=color;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
