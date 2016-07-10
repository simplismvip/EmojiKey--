//
//  TabBar.h
//  EmojiKey-自定义键盘
//
//  Created by ZhaoJM on 15/12/28.
//  Copyright © 2016年 ZhaoJM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    KeyBoardViewTypeDefault,
    KeyBoardViewTypeRecent,
    KeyBoardViewTypeEmoji,
    KeyBoardViewTypeLxh
    
} KeyBoardViewType;

@class TabBar;
@protocol TabBarDelegate <NSObject>
- (void)emojitabBar:(TabBar *)tabBar didSelectBtn:(KeyBoardViewType)type;
@end

@interface TabBar : UIView
@property (nonatomic, assign) id <TabBarDelegate> delegate;
@end
