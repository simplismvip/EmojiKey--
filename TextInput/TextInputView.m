//
//  KeyBoardView.m
//  CustomKeyBoard-自定义键盘输入框
//
//  Created by Mac on 16/6/15.
//  Copyright © 2016年 yijia. All rights reserved.
//

#import "TextInputView.h"
#import "KeyBoardView.h"
#import "UIView+Extension.h"
#import "InputImageView.h"
#define JMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface TextInputView ()<UITextFieldDelegate>
@property (nonatomic, weak) UIButton *send;
@property (nonatomic, weak) UIButton *emoji;
@property (nonatomic, weak) UIButton *voice;
@property (nonatomic, weak) UITextField *textFied;
@property (nonatomic, assign) BOOL keyBoardStatus;
@end

@implementation TextInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.keyBoardStatus = NO;
        self.backgroundColor = JMColor(232, 233, 235);
        
        // voice按钮
        UIButton *voice = [UIButton buttonWithType:(UIButtonTypeSystem)];
        UIImage *bacImage = [UIImage imageNamed:@"voice"];
        [voice setImage:[bacImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:(UIControlStateNormal)];
        [voice addTarget:self action:@selector(voiceAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:voice];
        self.voice = voice;
        
        // 输入框
        UITextField *textFied = [[UITextField alloc] init];
        textFied.borderStyle = UITextBorderStyleRoundedRect;
        textFied.delegate = self;
        [textFied becomeFirstResponder];
        textFied.backgroundColor = JMColor(242, 243, 245);
        [self addSubview:textFied];
        self.textFied = textFied;
        
        // voice按钮
        UIButton *emoji = [UIButton buttonWithType:(UIButtonTypeSystem)];
        UIImage *emojiImage = [UIImage imageNamed:@"emoji"];
//        emoji.backgroundColor = [UIColor redColor];
        [emoji setImage:[emojiImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:(UIControlStateNormal)];
        [emoji addTarget:self action:@selector(emojiAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:emoji];
        self.emoji = emoji;
        
        // send按钮
        UIButton *send = [UIButton buttonWithType:(UIButtonTypeSystem)];
        UIImage *sendImage = [UIImage imageNamed:@"add"];
//        send.backgroundColor = [UIColor redColor];
        [send setImage:[sendImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:(UIControlStateNormal)];
        [send addTarget:self action:@selector(sendAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:send];
        self.send = send;
        
        // 注册键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
        
        // 注册键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

// 表情键盘
- (void)emojiAction:(UIButton *)emoji
{
    // 切换自定义键盘
    if (self.textFied.inputView == nil) {
        
        KeyBoardView *keyView = [[KeyBoardView alloc] init];
        keyView.height = 216;
        keyView.width = self.width;
        self.textFied.inputView = keyView;
        
        // 切换系统键盘
    }else {
        
        self.textFied.inputView = nil;
    }
    
    [self.textFied endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.textFied becomeFirstResponder];
    });

}

// 录音
- (void)voiceAction:(UIButton *)voice
{
    
}

// 点击发送响应方法
- (void)sendAction:(UIButton *)send
{
    
    // 切换自定义键盘
    if (self.textFied.inputView == nil) {
        
        InputImageView *image = [[InputImageView alloc] initWithFrame:CGRectMake(0, 80, self.width, 216)];
        
        image.height = 216;
        image.width = self.width;
        self.textFied.inputView = image;
        
        // 切换系统键盘
    }else {
        
        self.textFied.inputView = nil;
    }
    
    [self.textFied endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.textFied becomeFirstResponder];
    });

    
//    self.textFied.inputView = image;
//    
//    if ([self.delegate respondsToSelector:@selector(textInputFinished:)]) {
//        
//        [self.delegate textInputFinished:self.textFied.text];
//    }
}

#pragma mark -- UITextFieldDelegate
// 开始textField是调用
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    self.keyBoardStatus = YES;
}

// 结束textField时调用
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.textFied = textField;
    if ([self.delegate respondsToSelector:@selector(textInputFinished:)]) {
        
        [self.delegate textInputFinished:textField.text];
    }

}

// 点击return时调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textInputFinished:)]) {
        [self.delegate textInputFinished:self.textFied.text];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@", string);
    
    return YES;
}

- (BOOL)switchKeyBoard
{
    BOOL isSucess;
    if (self.keyBoardStatus) {
        
        isSucess = [self.textFied resignFirstResponder];
        self.keyBoardStatus = !self.keyBoardStatus;
    }else{
        isSucess = [self.textFied becomeFirstResponder];
    }
    return isSucess;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat edge = 3.0;
    
    self.voice.frame = CGRectMake(edge, edge, 40, 40);
    self.textFied.frame = CGRectMake(CGRectGetMaxX(self.voice.frame)+edge, edge, self.bounds.size.width-126, self.bounds.size.height-10);
    self.emoji.frame = CGRectMake(CGRectGetMaxX(self.textFied.frame), edge, 40, 40);
    self.send.frame = CGRectMake(CGRectGetMaxX(self.emoji.frame), edge, 40, 40);
}

// 弹出键盘
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // 键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSInteger height = keyBoardFrame.origin.y;
    CGRect rect = CGRectMake(self.frame.origin.x, height-44, self.frame.size.width, self.frame.size.height);
    self.frame = rect;

}

// 隐藏键盘
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    // 键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSInteger height = keyBoardFrame.origin.y;
    CGRect rect = CGRectMake(self.frame.origin.x, height-44, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    // [self removeFromSuperview];
}

// 移除通知中心
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (TextInputView *)initWithKeyBoardViewAndAddDelegate:(id)delegate
{
    if ([delegate isKindOfClass:[UIViewController class]]) {
        
        UIViewController *vc = (UIViewController *)delegate;
        TextInputView *key = [[TextInputView alloc] initWithFrame:CGRectMake(0, vc.view.bounds.size.height - 44, vc.view.bounds.size.width, 44)];
        key.delegate = delegate;
        
        return key;
    }
    return nil;
}

@end
