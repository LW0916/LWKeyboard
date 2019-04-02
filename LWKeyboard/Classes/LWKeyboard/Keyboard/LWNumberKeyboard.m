//
//  LWNumberKeyboard.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/26.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "LWNumberKeyboard.h"

@interface LWNumberKeyboard ()
/** 其他按钮 完成 */
@property (nonatomic, strong) LWKeyButton *loginBtn;
/** 数字按钮 */
@property (nonatomic, strong) NSMutableArray *numBtnsArrM;
@end

@implementation LWNumberKeyboard
@synthesize showAnimation = _showAnimation;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = LWKeyboardTypeNumber;
        UIImage *image = [UIImage imageMyBundleNamed:@"number_keyboardNumButton"];
        UIImage *highImage = _showAnimation ? [UIImage imageMyBundleNamed:@"number_keyboardNumButtonSel"] : [UIImage imageMyBundleNamed:@"number_keyboardNumButton"];
    
        [self setupNumberButtonsWithImage:image highImage:highImage];
        [self setupBottomButtonsWithImage:highImage highImage:image];
    }
    return self;
}

- (void)setShowAnimation:(BOOL)showAnimation{
    if (_showAnimation != showAnimation) {
        _showAnimation = showAnimation;
        [self setupNumberButtonHighlighted:showAnimation];
    }
}
- (void)setupNumberButtonHighlighted:(BOOL)highlighted{
    UIImage *highImage = highlighted ? [UIImage imageMyBundleNamed:@"number_keyboardNumButtonSel"] : [UIImage imageMyBundleNamed:@"number_keyboardNumButton"];
    for (LWKeyButton *btn in self.numBtnsArrM) {
        [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    }
}

#pragma mark - 数字按钮
- (void)setupNumberButtonsWithImage:(UIImage *)image highImage:(UIImage *)highImage {
    
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM removeAllObjects];
    _numBtnsArrM =  [NSMutableArray array];
    [_numBtnsArrM removeAllObjects];
    for (int i = 0 ; i < 10; i++) {
        int j = arc4random_uniform(10);
        NSNumber *number = [[NSNumber alloc] initWithInt:j];
        if ([arrM containsObject:number]) {
            i--;
            continue;
        }
        [arrM addObject:number];
    }
    
    for (int i = 0; i < 10; i++) {
        
        NSNumber *number = arrM[i];
        NSString *title = number.stringValue;
        
        LWKeyButton *numBtn = [LWKeyboardTool setupBasicButtonsWithTitle:title image:image highImage:highImage];
        numBtn.type = LWKeyButtonTypeNormal;
        [numBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_numBtnsArrM addObject:numBtn];
        [self addSubview:numBtn];
    }
}


#pragma mark - 删除按钮 登录按钮 可以点击
- (void)setupBottomButtonsWithImage:(UIImage *)image highImage:(UIImage *)highImage {
    self.deleteBtn = [LWKeyboardTool setupFunctionButtonWithTitle:nil image:[UIImage imageMyBundleNamed:@"number_keyboardDeleteButton"] highImage:[UIImage imageMyBundleNamed:@"number_keyboardDeleteButtonSel"]];
    self.deleteBtn.type = LWKeyButtonTypeDel;
    
    self.loginBtn = [LWKeyboardTool setupFunctionButtonWithTitle:@"确定" image:[UIImage imageMyBundleNamed:@"number_keyboardLoginButton"] highImage:[UIImage imageMyBundleNamed:@"number_keyboardNumButtonSel"]];
    self.loginBtn.type = LWKeyButtonTypeDone;
    
    [self.deleteBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnLong:)];
    longPress.minimumPressDuration = 0.5;
    [self.deleteBtn addGestureRecognizer:longPress];
    
    [self addSubview:self.deleteBtn];
    [self addSubview:self.loginBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat topMargin = 15;
    CGFloat bottomMargin = 3;
    CGFloat leftMargin = 3;
    CGFloat colMargin = 3;
    CGFloat rowMargin = 3;
    
    CGFloat topBtnW = (self.width - 2 * leftMargin - 2 * colMargin) / 3;
    CGFloat topBtnH = (self.height - topMargin - bottomMargin - 3 * rowMargin) / 4;
    
    NSUInteger count = self.subviews.count;
    // 布局数字按钮
    for (NSUInteger i = 0; i < count; i++) {
        if (i == 0 ) { // 0
            UIButton *buttonZero = self.subviews[i];
            buttonZero.height = topBtnH;
            buttonZero.width = topBtnW;
            buttonZero.centerX = self.centerX;
            buttonZero.centerY = self.height - bottomMargin - buttonZero.height * 0.5;
            // 确定及删除按钮的位置
            self.loginBtn.x = CGRectGetMaxX(buttonZero.frame) + colMargin;
            self.loginBtn.y = buttonZero.y;
            self.loginBtn.width = buttonZero.width;
            self.loginBtn.height = buttonZero.height;
            
            self.deleteBtn.x = CGRectGetMaxX(buttonZero.frame) + colMargin;
            self.deleteBtn.y = buttonZero.y - colMargin - buttonZero.height;
            self.deleteBtn.width = buttonZero.width;
            self.deleteBtn.height = buttonZero.height;
        }
        if (i > 0 && i < 10) { // 1 ~ 9

            UIButton *topButton = self.subviews[i];
            if (i ==9) {
                i++;
            }
            CGFloat row = (i - 1) / 3;
            CGFloat col = (i - 1) % 3;
            
            topButton.x = leftMargin + col * (topBtnW + colMargin);
            topButton.y = topMargin + row * (topBtnH + rowMargin);
            topButton.width = topBtnW;
            topButton.height = topBtnH;
        }
    }
}

@end
