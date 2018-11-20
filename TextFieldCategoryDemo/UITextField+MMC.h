//
//  UITextField+MMC.h
//  TextFieldCategoryDemo
//
//  Created by wangwayhome on 2018/11/19.
//  Copyright © 2018 wangwayhome. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (MMC)

//设置左边文本框空白的区域大小
- (void)setLeftMargin:(CGFloat)margin;

//设置Placeholder文字颜色
- (void)setCustomPlaceholderColor:(UIColor *)color;

//隐藏光标
- (void)hideCursor;

//改变光标颜色
- (void)changeCussorColor:(UIColor *)color;

//限制字数
- (void)limitTextLength:(NSInteger)length;

//禁止表情符号
- (void)limitTextEmoji:(BOOL)isEmoji;


@end

NS_ASSUME_NONNULL_END
