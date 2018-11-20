//
//  ViewController.m
//  TextFieldCategoryDemo
//
//  Created by wangwayhome on 2018/11/19.
//  Copyright © 2018 wangwayhome. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+MMC.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *ucarTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_ucarTextField setLeftMargin:50];//设置文本框左边空白部分的大小
    [_ucarTextField setPlaceholder:@"这是一个UITextField 类别的Demo"];
    [_ucarTextField setCustomPlaceholderColor:[UIColor redColor]];
    [_ucarTextField changeCussorColor:[UIColor blueColor]];
    [_ucarTextField limitTextLength:5];//限制字数
    [_ucarTextField limitTextEmoji:YES];
    
}


@end
