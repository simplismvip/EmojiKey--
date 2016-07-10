//
//  ViewController.m
//  EmojiKey-自定义键盘
//
//  Created by ZhaoJM on 15/12/28.
//  Copyright © 2016年 ZhaoJM. All rights reserved.
//
// 颜色


#import "ViewController.h"
#import "KeyBoardView.h"
#import "UIView+Extension.h"
#import "TextInputView.h"
#import "InputImageView.h"

@interface ViewController ()<TextInputViewDelegate>
@property (nonatomic, weak) TextInputView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
//    InputImageView *image = [[InputImageView alloc] initWithFrame:CGRectMake(0, 80, self.view.width, 216)];
//   
//    image.backgroundColor = [UIColor redColor];
//    [self.view addSubview:image];
    
    TextInputView *textView = [TextInputView initWithKeyBoardViewAndAddDelegate:self];
    [self.view addSubview:textView];
    self.textView = textView;
}

- (IBAction)switchKey:(id)sender {

    
}

#pragma mark -- TextInputViewDelegate
- (void)textInputFinished:(NSString *)string
{
    NSLog(@"%@", string);
}


@end
