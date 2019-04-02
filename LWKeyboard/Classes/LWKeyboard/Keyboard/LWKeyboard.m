//
//  LWKeyboard.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/26.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "LWKeyboard.h"
#import "LWLetterKeyboard.h"
#import "LWNumberKeyboard.h"
#import "LWSymbolKeyboard.h"
#import "LWKeyboardTool.h"
#import "LWKeyboardIAView.h"


#define IA_HEIGHT 44
#define KB_HEIGHT 216
@interface LWKeyboard () <LWCustomKeyboardDelegate,LWKeyboardIAViewDelegate>

@property (nonatomic, strong) LWLetterKeyboard *letterKeyboard;
@property (nonatomic, strong) LWSymbolKeyboard *symbolKeyboard;
@property (nonatomic, strong) LWNumberKeyboard *numberKeyboard;
@property (nonatomic, assign) LWKeyboardType keyboardType;
@property (nonatomic, weak)  LWBasicKeyboard *tempKeyboard;
@property (nonatomic, strong) LWKeyboardIAView *iaView;
@property (nonatomic, assign) BOOL showAnimation;

@end

@implementation LWKeyboard
- (LWKeyboardIAView *)iaView{
    if (_iaView == nil) {
        _iaView = [[LWKeyboardIAView alloc]initWithFrame:CGRectMake(0, 0, LWScreen_Size.width, IA_HEIGHT)];
        _iaView.delegate = self;
    }
    return _iaView;
}

- (LWLetterKeyboard *)letterKeyboard {
    if (!_letterKeyboard) {
        _letterKeyboard = [[LWLetterKeyboard alloc] initWithFrame:CGRectMake(0, IA_HEIGHT, self.width, KB_HEIGHT)];
        _letterKeyboard.delegate = self;
        _letterKeyboard.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _letterKeyboard.showAnimation = self.showAnimation;
    }
    return _letterKeyboard;
}

- (LWSymbolKeyboard *)symbolKeyboard {
    if (!_symbolKeyboard) {
        _symbolKeyboard = [[LWSymbolKeyboard alloc] initWithFrame:CGRectMake(0, IA_HEIGHT, self.width, KB_HEIGHT)];
        _symbolKeyboard.delegate = self;
        _symbolKeyboard.showAnimation = self.showAnimation;

    }
    return _symbolKeyboard;
}

- (LWNumberKeyboard *)numberKeyboard {
    if (!_numberKeyboard) {
        _numberKeyboard = [[LWNumberKeyboard alloc] initWithFrame:CGRectMake(0, IA_HEIGHT, self.width, KB_HEIGHT)];
        _numberKeyboard.delegate = self;
        _numberKeyboard.showAnimation = self.showAnimation;

    }
    return _numberKeyboard;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupControls];
    }
    return self;
}
- (void)setupControls{
    self.frame = CGRectMake(0, LWScreen_Size.height - KB_HEIGHT - IA_HEIGHT, LWScreen_Size.width, KB_HEIGHT+IA_HEIGHT);
    self.backgroundColor = LWColorFromRGB(0xEDEDF5);
    self.keyboardType = LWKeyboardTypeLetter;
    self.tempKeyboard = self.letterKeyboard;
    [self addSubview:self.letterKeyboard];
    [self addSubview:self.iaView];
    self.showAnimation = self.iaView.kShowSwitchBtn.selected;
}

- (void)p_resetKeyboard{
    [self.iaView p_resetButton];
    [self.tempKeyboard removeFromSuperview];
    self.letterKeyboard = nil;
    self.numberKeyboard = nil;
    self.symbolKeyboard = nil;
    self.keyboardType = LWKeyboardTypeLetter;
    self.tempKeyboard = self.letterKeyboard;
    [self addSubview:self.letterKeyboard];
}

- (void)p_switchKeyboardWithKeyboardType:(LWKeyboardType )keyboardType{
    if (keyboardType != self.keyboardType) {
        self.keyboardType = keyboardType;
        [self.tempKeyboard removeFromSuperview];
        self.letterKeyboard = nil;
        self.numberKeyboard = nil;
        self.symbolKeyboard = nil;
        if (self.keyboardType == LWKeyboardTypeLetter) {
            self.tempKeyboard = self.letterKeyboard;
            [self addSubview:self.letterKeyboard];
        }else if(self.keyboardType == LWKeyboardTypeNumber){
            [self addSubview:self.numberKeyboard];
            self.tempKeyboard = self.numberKeyboard;
        }else{
            [self addSubview:self.symbolKeyboard];
            self.tempKeyboard = self.symbolKeyboard;
        }
    }
}
- (void)p_configKeyboardIconImage:(UIImage *)image titile:(NSString *)text{
    self.iaView.kTitleLbale.text = text ? text : @"";
    if (image) {
        self.iaView.kIconImageView.image = image;
    }
    [self.iaView setNeedsLayout];
}

#pragma mark -- LWKeyboardIAViewDelegate
- (void)iaViewTypeChanged:(LWKeyboardType)type{
    [self p_switchKeyboardWithKeyboardType:type];
}
- (void)iaViewChangeShowAnimation:(BOOL)animation{
    self.showAnimation = animation;
    self.tempKeyboard.showAnimation = animation;
}

#pragma - mark LWCustomKeyboardDelegate
- (void)keyboard:(LWBasicKeyboard *)keyboard didClickButton:(LWKeyButton *)button {
    NSString *text = @"";
    if (button.type == LWKeyButtonTypeNormal) {
        text = button.currentTitle;
        [self didClickChangeTextButton:button string:text];
    }else if(button.type == LWKeyButtonTypeDel){
        [self didClickChangeTextButton:button string:text];
    }else if(button.type == LWKeyButtonTypeDone){
        if ([self.delegate respondsToSelector:@selector(didClickLoginButton:)]) {
            [self.delegate didClickLoginButton:button];
        }
    }else if(button.type == LWKeyButtonTypeSpace){
        text = @" ";
        [self didClickChangeTextButton:button string:text];
    }else{
        
    }
}

- (void)didClickChangeTextButton:(LWKeyButton *)button string:(NSString *)text{
    if ([self.delegate respondsToSelector:@selector(changeStringkeyboard:didClickButton:string:)]) {
        [self.delegate changeStringkeyboard:self didClickButton:button string:text];
    }
}

@end
