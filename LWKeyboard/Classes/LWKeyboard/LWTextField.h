//
//  LWTextField.h
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/28.
//  Copyright © 2019年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWTextField : UITextField

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)p_configKeyboardIconImage:(UIImage *)image titile:(NSString *)text;

@end
