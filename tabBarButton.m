//
//  tabBarButton.m
//  EmojiKey-自定义键盘
//
//  Created by ZhaoJM on 15/12/28.
//  Copyright © 2016年 ZhaoJM. All rights reserved.
//

#import "tabBarButton.h"

@implementation tabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateDisabled)];
    }
    return self;
}


- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
