//
//  LWBasicKeyboard.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/26.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "LWBasicKeyboard.h"

@implementation LWBasicKeyboard
#pragma mark - 长按删除处理
-(void)deleteBtnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self beginDelete];
    }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
        [self endDelete];
    }
}
- (void)beginDelete{
    UIImage *image;
    switch (self.type) {
        case LWKeyboardTypeLetter:
            image = [UIImage imageMyBundleNamed:@"letter_keyboardDeleteButtonSel"];
            break;
        case LWKeyboardTypeNumber:
            image = [UIImage imageMyBundleNamed:@"number_keyboardDeleteButtonSel"];
            break;
        case LWKeyboardTypeSymbol:
            image = [UIImage imageMyBundleNamed:@"symbol_keyboardDeleteButtonSel"];
            break;
        default:
            break;
    }
    [self.deleteBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(delete:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)endDelete{
    UIImage *image;
    switch (self.type) {
        case LWKeyboardTypeLetter:
            image = [UIImage imageMyBundleNamed:@"letter_keyboardDeleteButton"];
            break;
        case LWKeyboardTypeNumber:
            image = [UIImage imageMyBundleNamed:@"number_keyboardDeleteButton"];
            break;
        case LWKeyboardTypeSymbol:
            image = [UIImage imageMyBundleNamed:@"symbol_keyboardDeleteButton"];
            break;
        default:
            break;
    }
    [self.deleteBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.timer invalidate];
    self.timer = nil;
}
- (void)delete:(NSTimer*)timer {
    [self functionBtnClick:self.deleteBtn];
}
// 点击事件
- (void)functionBtnClick:(LWKeyButton *)button {
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickButton:)]) {
        [self.delegate keyboard:self didClickButton:button];
    }
}
@end
