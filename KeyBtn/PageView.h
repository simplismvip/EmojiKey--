//
//  PageView.h
//  EmojiKey-自定义键盘
//
//  Created by ZhaoJM on 15/12/28.
//  Copyright © 2016年 ZhaoJM. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^passBtn) (NSMutableArray *array);

@class Model;
@protocol PageViewDelegate <NSObject>
- (void)model:(Model *)model;
@end

@interface PageView : UIView

//- (void)returnBtn:(void(^) (NSMutableArray *array))pass;
@property (nonatomic, weak) id <PageViewDelegate>delegate;
@property (nonatomic, retain) NSArray *emojiPage;
@end
