//
//  LWKeyboard.h
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/26.
//  Copyright © 2019年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWKeyButton.h"

@class LWKeyboard;

@protocol LWKeyboardDelegate <NSObject>

@optional

/**
 *  字符改变
 */
- (void)changeStringkeyboard:(LWKeyboard *)keyboard didClickButton:(LWKeyButton *)deleteBtn string:(NSString *)text;
/**
 *  点击键盘确定键
 */
- (void)didClickLoginButton:(LWKeyButton *)LoginBtn;

@end

@interface LWKeyboard : UIView

@property (nonatomic, weak) id<LWKeyboardDelegate> delegate;

- (void)p_configKeyboardIconImage:(UIImage *)image titile:(NSString *)text;
- (void)p_resetKeyboard;

@end
