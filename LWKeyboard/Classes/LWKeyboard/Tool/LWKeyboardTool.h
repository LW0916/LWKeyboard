//
//  LWKeyboardTool.h
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/26.
//  Copyright © 2019年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/// 快速色值转换
#define LWColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define LWScreen_Size [UIScreen mainScreen].bounds.size

@class LWKeyButton;

typedef enum : NSUInteger {
    LWKeyboardTypeLetter, // 字母
    LWKeyboardTypeNumber, // 数字
    LWKeyboardTypeSymbol  // 字符
} LWKeyboardType;

typedef enum : NSUInteger {
    LWKeyButtonTypeNormal,  // 按键类型：通用
    LWKeyButtonTypeDel,     // 按键类型：删除
    LWKeyButtonTypeDone,    // 按键类型：完成
    LWKeyButtonTypeSpace,   // 按键类型：空格
    LWKeyButtonTypeLetter,   // 按键类型：字母切换
    LWKeyButtonTypeNumber,   // 按键类型：数字切换
    LWKeyButtonTypeSymbol,   // 按键类型：字符切换
    LWKeyButtonTypeOther    // 按键类型：其他
} LWKeyButtonType;

@interface LWKeyboardTool : NSObject
#pragma mark - 添加基础按钮
+ (LWKeyButton *)setupBasicButtonsWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage;

#pragma mark - 添加功能按钮
+ (LWKeyButton *)setupFunctionButtonWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage;

@end
