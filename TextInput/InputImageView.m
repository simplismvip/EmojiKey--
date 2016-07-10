//
//  InputImageView.m
//  EmojiKey-自定义键盘
//
//  Created by JM Zhao on 16/7/6.
//  Copyright © 2016年 ZhaoJM. All rights reserved.
//

#import "InputImageView.h"
#import "UIView+Extension.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface InputImageView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageContorl;
@property (nonatomic, assign) NSInteger pageNum;
@end

@implementation InputImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configurePageControl];
        
        NSArray *names = @[@"image", @"camera", @"lettleVideo", @"video", @"collect"];
        for (int i = 0; i < names.count; i ++) {
            
            UIButton *btnAction = [UIButton buttonWithType:(UIButtonTypeSystem)];
            btnAction.tag = i;
            btnAction.backgroundColor = [UIColor blueColor];
            UIImage *image = [UIImage imageNamed:names[i]];
            image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
            [btnAction setImage:image forState:(UIControlStateNormal)];
            [btnAction addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:btnAction];
        }
    }
    return self;
}

- (void)btnAction:(UIButton *)sender
{

}

- (void)configurePageControl{
    
    self.pageContorl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight - 40, kScreenWidth, 30)];
    _pageContorl.numberOfPages = 2;
    _pageContorl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageContorl.pageIndicatorTintColor = [UIColor greenColor];
    [_pageContorl addTarget:self action:@selector(handlePageControl:) forControlEvents:(UIControlEventValueChanged)];
    [self addSubview:_pageContorl];
}

- (void)handlePageControl:(UIPageControl *)sender{
    
    // 取出当前分页
    NSInteger number = sender.currentPage;
    
    // 通过分页控制scrollview的偏移量
    self.contentOffset = CGPointMake(number * kScreenWidth, 0);
}

#pragma UISlider使用方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 结束减速时的偏移量
    CGPoint offSet = scrollView.contentOffset;
    CGFloat number = offSet.x / kScreenWidth;
    self.pageNum = (NSInteger)number;
    _pageContorl.currentPage = _pageNum;
    
}

#pragma mark --- 代理方法
- (void)changeValue:(NSInteger)page
{
    _pageContorl.currentPage = page-1;
    [UIView animateWithDuration:0.5 animations:^{
        
        self.contentOffset = CGPointMake((page)*kScreenWidth, 0);
    }];

}

+ (instancetype)initWithInputImageView:(CGRect)rect delegate:(id)delegate
{
    InputImageView *inputView = [[InputImageView alloc] initWithFrame:rect];
    inputView.backgroundColor = [UIColor yellowColor];
    inputView.pagingEnabled = YES;
    inputView.bounces = NO;
    inputView.contentSize = CGSizeMake(2 * kScreenWidth, 0);
    
    // 设置代理
    inputView.Inputdelegate = delegate;
    return inputView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat edgeW = 0;
    CGFloat edgeH = 0;
    CGFloat w = self.width/4;
    CGFloat h = self.height/2;
    
    int i = 0;
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            if (i < 4) {
                
                view.frame = CGRectMake(edgeW+i*w, edgeH, w, h);
            }else{
                view.frame = CGRectMake(edgeW+(i-4)*w, edgeH+h, w, h);
            }
            
            i++;
        
            NSLog(@"%d", i);
        }
    }
}

@end
