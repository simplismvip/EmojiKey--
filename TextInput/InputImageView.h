//
//  InputImageView.h
//  EmojiKey-自定义键盘
//
//  Created by JM Zhao on 16/7/6.
//  Copyright © 2016年 ZhaoJM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputImageViewDelegate <NSObject>

- (void)imageCallBack;
- (void)camareCallBack;

@end

@interface InputImageView : UIScrollView
@property (nonatomic, weak) id<InputImageViewDelegate>Inputdelegate;
@end
