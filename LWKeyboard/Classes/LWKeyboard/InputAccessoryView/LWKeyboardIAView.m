//
//  LWKeyboardIAView.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/27.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "LWKeyboardIAView.h"
#import "UIView+LWExtension.h"
#import "UIImage+LWKeyboardBundle.h"

#define   SHOWANIMATION @"LWKEYBOARD_SHOWANIMATION"
@interface LWKeyboardIAView ()

/** 切换按钮左*/
@property (nonatomic, strong) LWKeyButton *kSwitchLeftBtn;
/**  切换按钮右*/
@property (nonatomic, strong) LWKeyButton *kSwitchRightBtn;

/**  默认 键盘显示名称*/
@property (nonatomic, copy) NSString *kKeyboardName;
/**  默认 键盘按钮类型*/
@property (nonatomic, assign) LWKeyButtonType kButtonType;

@end

@implementation LWKeyboardIAView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.kButtonType = LWKeyButtonTypeLetter;
        self.kKeyboardName = @"字母";
        [self setupControls];
    }
    return self;
}

- (UIImageView *)kIconImageView{
    if (_kIconImageView == nil) {
        _kIconImageView = [[UIImageView alloc]init];
    }
    return _kIconImageView;
}
- (UILabel *)kTitleLbale{
    if (_kTitleLbale == nil) {
        _kTitleLbale = [[UILabel alloc]init];
        _kTitleLbale.textColor = LWColorFromRGB(0xC6C2C6);
        _kTitleLbale.font = [UIFont systemFontOfSize:16];
        _kTitleLbale.textAlignment = NSTextAlignmentLeft;
        _kTitleLbale.text = @"";
    }
    return _kTitleLbale;
}

- (LWKeyButton *)kSwitchLeftBtn{
    if (_kSwitchLeftBtn == nil) {
        _kSwitchLeftBtn = [LWKeyButton buttonWithType:UIButtonTypeCustom];
        _kSwitchLeftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _kSwitchLeftBtn.type = LWKeyButtonTypeNumber;
        [_kSwitchLeftBtn setTitle:@"数字" forState:UIControlStateNormal];
        [_kSwitchLeftBtn setTitleColor:LWColorFromRGB(0x7791EE) forState:UIControlStateNormal];
        [_kSwitchLeftBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kSwitchLeftBtn;
}
- (LWKeyButton *)kSwitchRightBtn{
    if (_kSwitchRightBtn == nil) {
        _kSwitchRightBtn = [LWKeyButton buttonWithType:UIButtonTypeCustom];
        _kSwitchRightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _kSwitchRightBtn.type = LWKeyButtonTypeSymbol;
        [_kSwitchRightBtn setTitle:@"符号" forState:UIControlStateNormal];
        [_kSwitchRightBtn setTitleColor:LWColorFromRGB(0x7791EE) forState:UIControlStateNormal];
        [_kSwitchRightBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kSwitchRightBtn;
}
- (LWKeyButton *)kShowSwitchBtn{
    if (_kShowSwitchBtn == nil) {
        _kShowSwitchBtn = [LWKeyButton buttonWithType:UIButtonTypeCustom];
        _kShowSwitchBtn.selected = [[NSUserDefaults standardUserDefaults] boolForKey:SHOWANIMATION];
        _kShowSwitchBtn.type = LWKeyButtonTypeOther;
        [_kShowSwitchBtn setImage:[UIImage imageMyBundleNamed:@"eye_close"] forState:(UIControlStateNormal)];
        [_kShowSwitchBtn setImage:[UIImage imageMyBundleNamed:@"eye_open"] forState:(UIControlStateSelected)];
        [_kShowSwitchBtn addTarget:self action:@selector(showSwitchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kShowSwitchBtn;
}

- (void)setupControls{
    [self addSubview:self.kIconImageView];
    [self addSubview:self.kTitleLbale];
    [self addSubview:self.kSwitchLeftBtn];
    [self addSubview:self.kSwitchRightBtn];
    [self addSubview:self.kShowSwitchBtn];
}

- (void)p_resetButton{
    self.kKeyboardName = @"字母";
    self.kButtonType = LWKeyButtonTypeLetter;
    [self.kSwitchLeftBtn setTitle:@"数字" forState:UIControlStateNormal];
    self.kSwitchLeftBtn.type = LWKeyButtonTypeNumber;
    [self.kSwitchRightBtn setTitle:@"符号" forState:UIControlStateNormal];
    self.kSwitchRightBtn.type = LWKeyButtonTypeSymbol;
}

- (void)showSwitchBtnClick:(LWKeyButton *)switchBtn{
    switchBtn.selected =  !switchBtn.selected;
    [[NSUserDefaults standardUserDefaults] setBool:switchBtn.selected forKey:SHOWANIMATION];
    if ([self.delegate respondsToSelector:@selector(iaViewChangeShowAnimation:)]) {
        [self.delegate iaViewChangeShowAnimation:switchBtn.selected];
    }
}

- (void)functionBtnClick:(LWKeyButton *)switchBtn {
    LWKeyboardType tempKeyboardType = 0;
    NSString *tempName = switchBtn.titleLabel.text;
    LWKeyButtonType tempKeyButtonType = switchBtn.type;
    if (self.kButtonType != switchBtn.type ) {
        switch ([switchBtn type]) {
            case LWKeyButtonTypeLetter:
                tempKeyboardType = LWKeyboardTypeLetter;
                break;
            case LWKeyButtonTypeNumber:
                tempKeyboardType = LWKeyboardTypeNumber;
                break;
            case LWKeyButtonTypeSymbol:
                tempKeyboardType = LWKeyboardTypeSymbol;
                break;
            default:
                break;
        }
        [switchBtn setTitle:self.kKeyboardName forState:UIControlStateNormal];
        switchBtn.type = self.kButtonType;
        self.kKeyboardName = tempName;
        self.kButtonType = tempKeyButtonType;
        
        if ([self.delegate respondsToSelector:@selector(iaViewTypeChanged:)]) {
            [self.delegate iaViewTypeChanged:tempKeyboardType];
        }
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leftMargin = 10;
    CGFloat rightMargin = 5;
    CGFloat topMargin = 3;
    CGFloat bottomMargin = 3;
    CGFloat colMargin = 5;
    CGFloat btnW = 50;
    CGFloat btnH = self.height - topMargin - bottomMargin;
    [self.kShowSwitchBtn setFrame:CGRectMake(self.width - rightMargin - 2*colMargin - 2*btnW -btnH, topMargin, btnH, btnH)];
    [self.kSwitchLeftBtn setFrame:CGRectMake(self.width - rightMargin - colMargin - 2*btnW , topMargin, btnW, btnH)];
    [self.kSwitchRightBtn setFrame:CGRectMake(self.width - rightMargin - btnW , topMargin, btnW, btnH)];    
    if (self.kIconImageView.image) {
        [self.kIconImageView setFrame:CGRectMake(leftMargin, topMargin, btnH, btnH)];
         [self.kTitleLbale setFrame:CGRectMake(leftMargin+self.kIconImageView.width +colMargin, topMargin, self.kShowSwitchBtn.x - leftMargin - self.kIconImageView.width - colMargin, btnH)];
    }else{
        [self.kIconImageView setFrame:CGRectMake(0, 0, 0, 0)];
        [self.kTitleLbale setFrame:CGRectMake(leftMargin, topMargin, self.kShowSwitchBtn.x - leftMargin - colMargin, btnH)];
    }
}
@end
