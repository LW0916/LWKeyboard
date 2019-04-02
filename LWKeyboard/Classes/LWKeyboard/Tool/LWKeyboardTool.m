//
//  LWKeyboardTool.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/26.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "LWKeyboardTool.h"
#import "LWKeyButton.h"

@implementation LWKeyboardTool
#pragma mark - 添加基础按钮
+ (LWKeyButton *)setupBasicButtonsWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage {
    
    LWKeyButton *button = [LWKeyButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    return button;
}

#pragma mark - 添加功能按钮
+ (LWKeyButton *)setupFunctionButtonWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage {
    
    LWKeyButton *otherBtn = [LWKeyButton buttonWithType:UIButtonTypeCustom];
    otherBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [otherBtn setTitle:title forState:UIControlStateNormal];
    [otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [otherBtn setBackgroundImage:image forState:UIControlStateNormal];
    [otherBtn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    return otherBtn;
}
@end
