//
//  KeyBoardView.h
//  CustomKeyBoard-自定义键盘输入框
//
//  Created by Mac on 16/6/15.
//  Copyright © 2016年 yijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextInputViewDelegate <NSObject>

// 把输入的字符串传出去
- (void)textInputFinished:(NSString *)string;

@end

@interface TextInputView : UIView

@property (nonatomic, weak) id <TextInputViewDelegate>delegate;

/**
 *  切换键盘
 *
 *  @return 返回切换是否成功
 */
- (BOOL)switchKeyBoard;

+ (TextInputView *)initWithKeyBoardViewAndAddDelegate:(id)delegate;
@end
