//
//  LWKeyboardIAView.h
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/27.
//  Copyright © 2019年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWKeyboardTool.h"
#import "LWKeyButton.h"

@protocol LWKeyboardIAViewDelegate <NSObject>
@optional

- (void)iaViewTypeChanged:(LWKeyboardType)type;

- (void)iaViewChangeShowAnimation:(BOOL)animation;

@end

@interface LWKeyboardIAView : UIView

@property(nonatomic,weak) id<LWKeyboardIAViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *kIconImageView;
@property (nonatomic, strong) UILabel *kTitleLbale;
/**  是否开启密码保护显示开关*/
@property (nonatomic, strong) LWKeyButton *kShowSwitchBtn;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)p_resetButton;
@end
