//
//  TabBar.m
//  EmojiKey-自定义键盘
//
//  Created by ZhaoJM on 15/12/28.
//  Copyright © 2016年 ZhaoJM. All rights reserved.
//

#import "TabBar.h"
#import "UIView+Extension.h"
#import "tabBarButton.h"

@interface TabBar ()
@property (nonatomic, strong) tabBarButton *selectBtn;
@end


@implementation TabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTitle:@"最近" type:KeyBoardViewTypeRecent];
        [self setupTitle:@"Emoji" type:KeyBoardViewTypeEmoji];
        [self setupTitle:@"浪小花" type:KeyBoardViewTypeLxh];
    }
    return self;
}

// 设置底部的View上的文字
- (tabBarButton *)setupTitle:(NSString *)title type:(KeyBoardViewType)type
{
    NSString *image       = @"compose_emotion_table_mid_normal";
    NSString *selecImage   = @"compose_emotion_table_mid_selected";
    
    tabBarButton *btn     = [[tabBarButton alloc] init];
    btn.tag           = type;
    
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    if (self.subviews.count == 1) {
        image      = @"compose_emotion_table_left_normal";
        selecImage = @"compose_emotion_table_left_selected";
    }else if (self.subviews.count == 4){
    
        image      = @"compose_emotion_table_right_normal";
        selecImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage imageNamed:selecImage] forState:(UIControlStateDisabled)];
    [self addSubview:btn];
    
    return btn;
}

- (void)btnClick:(tabBarButton *)sender
{
    /**
     * 设置上一个取消选中
     * 设置现在选中
     * 当前这个赋值给当前属性
     */
    self.selectBtn.enabled = YES;
    sender.enabled         = NO;
    self.selectBtn         = sender;
    
    if ([self.delegate respondsToSelector:@selector(emojitabBar:didSelectBtn:)]) {
        
        [self.delegate emojitabBar:self didSelectBtn:(KeyBoardViewType)sender.tag];
    }
}

- (void)setDelegate:(id<TabBarDelegate>)delegate
{
    _delegate = delegate;
    [self btnClick: [self setupTitle:@"默认" type:KeyBoardViewTypeDefault]];
}


- (void)layoutSubviews
{
    NSInteger btncount = self.subviews.count;
    CGFloat btnw       = self.width / btncount;
    CGFloat btnH       = self.height;
    
    for (int i = 0; i < btncount; i ++) {
        
        tabBarButton *btn = self.subviews[i];
        if (i == 0) {btn.x = i * btnw;}
        if (i > 0 && i < 3) {btn.x = (i+1) * btnw;}
        if (i == btncount-1) {btn.x = btnw;}
        btn.y    = 0;
        btn.width  = btnw;
        btn.height  = btnH;
    }
}

@end
