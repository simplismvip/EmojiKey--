//
//  ListView.m
//  EmojiKey-自定义键盘
//
//  Created by ZhaoJM on 15/12/28.
//  Copyright © 2016年 ZhaoJM. All rights reserved.
//

#import "ListView.h"
#import "UIView+Extension.h"
#import "PageView.h"

@interface ListView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageController;
@end

@implementation ListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.scrollView  = [[UIScrollView alloc] init];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled   = YES;
        self.scrollView.delegate  = self;
        [self addSubview:self.scrollView];
        
        self.pageController         = [[UIPageControl alloc] init];
        self.pageController.userInteractionEnabled        = NO;
        self.pageController.currentPageIndicatorTintColor = [UIColor yellowColor];
        self.pageController.pageIndicatorTintColor        = [UIColor darkGrayColor];
        self.pageController.backgroundColor   = [UIColor whiteColor];
        [self addSubview:self.pageController];
    }
    return self;
}

// 计算Emoji表情的位置
- (void)setEmojis:(NSArray *)emojis
{
    _emojis    = emojis;
    NSInteger count   = emojis.count / 21 + 1;
    self.pageController.numberOfPages = count;
    
    for (int i = 0; i < count; i ++) {
        
        // 计算每一页个数
        NSRange range;
        range.location = i * 20;
        NSInteger number = emojis.count - range.location;
        
        if (number > 20) {
            
            range.length = 20;
        }else{
            range.length = number;
        }
        
        NSArray *rangeArray           = [emojis subarrayWithRange:range];
        PageView *pageView            = [[PageView alloc] init];
        pageView.emojiPage            = rangeArray;
        [self.scrollView addSubview:pageView];
        
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pageController.x       = 0;
    self.pageController.width   = self.width;
    self.pageController.height  = 28;
    self.pageController.y       = self.height - 28;
    
    self.scrollView.width       = self.width;
    self.scrollView.x           = 0;
    self.scrollView.y           = 0;
    self.scrollView.height      = self.pageController.y;
    
    NSInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i ++) {
        
        UIView *view            = self.scrollView.subviews[i];
        view.height             = self.scrollView.height;
        view.width              = self.scrollView.width;
        view.y                  = 0;
        view.x                  = self.scrollView.width * i;
    }
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page  = scrollView.contentOffset.x / scrollView.width;
    
    self.pageController.currentPage = (int)(page + 0.5);
}


@end
