# UITextField Category Demo

In order to solve the project often used UITextFieldDelegate  annoyance.

Runtime and Category is used to solve this problem.

It's very simple to use：

1.#import "UITextField+MMC.h"

2.Use  `- (void)limitTextLength:(NSInteger)length;`  to limit word count

3.Ban  `limitTextEmoji`    with Emoji



For example：

```objective-c
    [_ucarTextField setLeftMargin:50];

    [_ucarTextField setPlaceholder:@"UITextField Category Demo"];

    [_ucarTextField setCustomPlaceholderColor:[UIColor redColor]];

    [_ucarTextField changeCussorColor:[UIColor blueColor]];

    [_ucarTextField limitTextLength:5];

    [_ucarTextField limitTextEmoji:YES];
```





Good Luck！