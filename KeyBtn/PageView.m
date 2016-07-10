//
//  PageView.m
//  EmojiKey-自定义键盘
//
//  Created by ZhaoJM on 15/12/28.
//  Copyright © 2016年 ZhaoJM. All rights reserved.
//

#import "PageView.h"
#import "UIView+Extension.h"
#import "Model.h"
#import "NSString+Emoji.h"

@interface PageView ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *arr;
@end

@implementation PageView

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (NSMutableArray *)arr
{
    if (_arr == nil) {
        self.arr = [NSMutableArray array];
    }
    return _arr;
}


- (void)setEmojiPage:(NSArray *)emojiPage
{
    _emojiPage = emojiPage;
    
    for (int i = 0; i < emojiPage.count + 1; i ++) {
        
        if (i == emojiPage.count)
        {
            UIButton *emojiBtn       = [[UIButton alloc] init];
            [emojiBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:(UIControlStateNormal)];
            [emojiBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:(UIControlStateSelected)];
            [emojiBtn addTarget:self action:@selector(btnClickDelete:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:emojiBtn];
            return;
        }
        
        Model *model             = emojiPage[i];
        UIButton *emojiBtn       = [[UIButton alloc] init];
        emojiBtn.tag             = i;
        [emojiBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];

        if (model.png != nil && model.png.length != 0)
        {
            [emojiBtn setImage:[UIImage imageNamed:model.png] forState:(UIControlStateNormal)];
            [emojiBtn setTitle:model.png forState:(UIControlStateNormal)];
            emojiBtn.titleLabel.font = [UIFont systemFontOfSize:0.0];
        }
        else if (model.code)
        {
            [emojiBtn setTitle:[model.code emoji] forState:(UIControlStateNormal)];
            emojiBtn.titleLabel.font = [UIFont systemFontOfSize:32.0];
        }
        [self addSubview:emojiBtn];
    }
}

// 表情按钮
- (void)btnClick:(UIButton *)sender
{
    for (Model *model in _emojiPage) {
        
        if ([model.png isEqualToString:sender.titleLabel.text] || [[model.code emoji] isEqualToString:sender.titleLabel.text]) {
            
            // 归档
            [self archiverByArr:model];
            
            if ([self.delegate respondsToSelector:@selector(model:)]) {
                
                [self.delegate model:model];
            }
        }
    }
}

// 删除按钮
- (void)btnClickDelete:(UIButton *)sender
{
    if (self.dataArray.count == 0) {
        return;
    }
    
    // 删除最后一个元素
    [self.dataArray removeLastObject];
}


// 归档
- (void)archiverByArr:(Model *)model
{
    // 拿到plist文件
    NSString *path       = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fielnaem    = [path stringByAppendingPathComponent:@"recent.plist"];
    NSDictionary *dic     = [NSDictionary dictionary];
    

    
    // 加载plist文件数组
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:fielnaem];
    
    // 如果数组为空创建
    if (array == nil || array.count == 0) {
        
        array = [NSMutableArray array];
    }
    if (model.code == nil) {
        
        dic = @{@"png":model.png, @"chs":model.chs};
    }else
    {
        dic = @{@"code":model.code};
    }
    
    [array addObject:dic];
    
    BOOL isBool = [array writeToFile:fielnaem atomically:YES];
    
    if (isBool) {
        
        NSLog(@"写入成功");
    }
    
    NSLog(@"%@", array);
}


- (void)layoutSubviews
{
    CGFloat insert  = 8;
    CGFloat H       = (self.height - 2 * insert) / 3;
    CGFloat W       = (self.width  - 2 * insert) / 7;
    NSInteger count = self.subviews.count;
    
    for (int i = 0; i < count; i ++) {
        
        UIButton *btn = self.subviews[i];
        
        btn.width   = W;
        btn.height  = H;
        btn.x       = insert + W * (i%7);
        btn.y       = insert + H * (i/7);
    }
}

@end
