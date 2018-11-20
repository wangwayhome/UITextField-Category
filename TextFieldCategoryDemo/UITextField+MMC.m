//
//  UITextField+MMC.m
//  TextFieldCategoryDemo
//
//  Created by wangwayhome on 2018/11/19.
//  Copyright © 2018 wangwayhome. All rights reserved.
//

#import "UITextField+MMC.h"

#import <objc/objc.h>
#import <objc/runtime.h>

static NSString *kLimitTextLengthKey = @"kLimitTextLengthKey";

static NSString *kLimitTextContentKey = @"kLimitTextContentKey";

static NSString *kLimitTextEmojiContentKey = @"kLimitTextEmojiContentKey";

@implementation UITextField (MMC)

- (void)setLeftMargin:(CGFloat)margin {
    
    UIView *marginView = [[UIView alloc] initWithFrame:CGRectZero];
    CGRect frame = marginView.frame;
    frame.size.width = margin;
    marginView.frame = frame;
    self.leftView = marginView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)setCustomPlaceholderColor:(UIColor *)color {
    if (!self.placeholder.length) {
        self.placeholder = @" ";
    }

    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];

}

- (void)hideCursor
{
    
    [self changeCussorColor:[UIColor clearColor]];
    
}

- (void)changeCussorColor:(UIColor *)color {
    
    if (color== nil) {
        return;
    }

    [[self valueForKey:@"textInputTraits"] setValue:color forKey:@"insertionPointColor"];
  
}

- (void)limitTextLength:(NSInteger)length {
    
    objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey), [NSNumber numberWithInteger:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
    
}


- (void)limitTextEmoji:(BOOL)isEmoji {
    
    if (isEmoji) {
        [self addTarget:self action:@selector(textFieldTextEmojiLimit:) forControlEvents:UIControlEventEditingChanged];
    }
    
}

#pragma mark - Private Method

- (void)textFieldTextLengthLimit:(id)sender {
    NSNumber *lengthNumber = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey));
    int length = [lengthNumber intValue];
    
    if(self.text.length > length)
    {
        self.text = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextContentKey));
    } else {
        objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextContentKey), self.text, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}

- (void)textFieldTextEmojiLimit:(id)sender {
    BOOL isEmoji = [self stringContainEmoji:self.text];
    
    if(isEmoji)
    {
        self.text = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextEmojiContentKey));
    } else {
        objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextEmojiContentKey), self.text, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}

- (BOOL)stringContainEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        const unichar hs = [substring characterAtIndex:0];
        
        if (0xd800) {
            if (0xd800 <= hs && hs<=0xdbff) {
                if (substring.length > 1) {
                    const unichar ls =[substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400)+(ls-0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue = YES;
                    }
                }
            } else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue = YES;
                }
            } else {
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}

@end
