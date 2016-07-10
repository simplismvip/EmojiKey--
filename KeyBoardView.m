//
//  ListView.m
//  EmojiKey-自定义键盘
//
//  Created by ZhaoJM on 15/12/28.
//  Copyright © 2016年 ZhaoJM. All rights reserved.
//

#import "KeyBoardView.h"
#import "UIView+Extension.h"
#import "TabBar.h"
#import "ListView.h"
#import "Model.h"
#import "MJExtension.h"
#import "PageView.h"

@interface KeyBoardView ()<TabBarDelegate>
@property (nonatomic, strong) UIView *tabBarView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) ListView *resectView;
@property (nonatomic, strong) ListView *defaultView;
@property (nonatomic, strong) ListView *emojiView;
@property (nonatomic, strong) ListView *lxhView;
@end

@implementation KeyBoardView

- (ListView *)resectView
{
    if (_resectView == nil) {
        self.resectView = [[ListView alloc] init];
        self.resectView.emojis = [self recentltForEmoji];
    }
    return _resectView;
}

- (ListView *)defaultView
{
    if (_defaultView == nil) {
        self.defaultView = [[ListView alloc] init];
        self.defaultView.emojis = [self setupEmojiWithName:@"default.plist"];
        
    }
    return _defaultView;
}

- (ListView *)emojiView
{
    if (_emojiView == nil) {
        self.emojiView = [[ListView alloc] init];
        self.emojiView.emojis = [self setupEmojiWithName:@"emoji.plist"];
       
    }
    return _emojiView;
}

- (ListView *)lxhView
{
    if (_lxhView == nil) {
        self.lxhView = [[ListView alloc] init];
        self.lxhView.emojis = [self setupEmojiWithName:@"lxh.plist"];
        
    }
    return _lxhView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 底部放按钮View
        TabBar *tabBarView   = [[TabBar alloc] init];
        tabBarView.delegate  = self;
        self.tabBarView      = tabBarView;
        [self addSubview:self.tabBarView];
    }
    return self;
}


#pragma mark -- TabBarDelegate 代理方法实现
- (void)emojitabBar:(KeyBoardView *)tabBar didSelectBtn:(KeyBoardViewType)type
{
    // 首先移除上一个view
    [self.showView removeFromSuperview];
    
    switch (type) {
        case KeyBoardViewTypeRecent:
            
            // self.resectView = [[ListView alloc] init];
            self.resectView.emojis = [self recentltForEmoji];
            [self addSubview:self.resectView];
            break;
            
        case KeyBoardViewTypeEmoji:
            [self addSubview:self.emojiView];
            
            break;
            
        case KeyBoardViewTypeDefault:
            [self addSubview:self.defaultView];
            
            break;
            
        case KeyBoardViewTypeLxh:
            [self addSubview:self.lxhView];
            
            break;
            
        default:
            break;
    }
    
    
    // 最后一个就是正在展示的view赋值给showView
    self.showView = [self.subviews lastObject];
    
    // 会在恰当的时刻自动调用Layout方法重新计算子控件尺寸
    [self setNeedsLayout];
}

- (NSArray *)recentltForEmoji
{
    NSString *path       = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fielnaem    = [path stringByAppendingPathComponent:@"recent.plist"];
    return [Model mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:fielnaem]];
}


// 返回emoji数组
- (NSArray *)setupEmojiWithName:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    return [Model mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
}

- (void)layoutSubviews
{
    _tabBarView.x              = 0;
    _tabBarView.y              = self.height - 44;
    _tabBarView.width          = self.width;
    _tabBarView.height         = 44;
    
    // 放置表情的View
    self.showView.x      = self.y = 0;
    self.showView.width  = self.width;
    self.showView.height = _tabBarView.y;
    
}


@end
