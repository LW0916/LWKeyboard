//
//  LWBasicKeyboard.h
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/26.
//  Copyright © 2019年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWKeyButton.h"
#import "UIView+LWExtension.h"
#import "UIImage+LWKeyboardBundle.h"
#import "LWKeyboardTool.h"

@class LWBasicKeyboard;
@protocol LWCustomKeyboardDelegate <NSObject>

@optional

- (void)keyboard:(LWBasicKeyboard *)keyboard didClickButton:(LWKeyButton *)button;

@end

@interface LWBasicKeyboard : UIView
@property (nonatomic, assign) BOOL showAnimation;
/**  删除按钮 */
@property (nonatomic, strong) LWKeyButton *deleteBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) LWKeyboardType type;
@property (nonatomic, weak) id<LWCustomKeyboardDelegate> delegate;

- (void)functionBtnClick:(LWKeyButton *)button;

-(void)deleteBtnLong:(UILongPressGestureRecognizer *)gestureRecognizer;

@end
