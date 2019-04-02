//
//  LWSymbolKeyboard.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/26.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "LWSymbolKeyboard.h"
#import "LWEmotionPopView.h"
#import "NSBundle+LWPath.h"

@interface LWSymbolKeyboard ()<UIGestureRecognizerDelegate>

@property (nonatomic, copy)  NSString *symbolStr;

@property (nonatomic, strong) NSMutableArray *symbolBtnArrM;
/** 其他按钮 确定 */
@property (nonatomic, strong) LWKeyButton *loginBtn;
/** 其他按钮 空格 */
@property (nonatomic, strong) LWKeyButton *spaceBtn;

/** 点击按钮后弹出的放大镜 */
@property (nonatomic, strong) LWEmotionPopView *popView;
/// 长按手势时所在的按钮
@property (nonatomic, weak) LWKeyButton *currentPressBtn;
/// 长按手势
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@end

@implementation LWSymbolKeyboard
@synthesize showAnimation = _showAnimation;

- (UILongPressGestureRecognizer *)longPress{
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressContentView:)];
        _longPress.delegate = self;
        _longPress.minimumPressDuration = 0.01;
    }
    return _longPress;
}
- (LWEmotionPopView *)popView{
    if (!_popView) {
        _popView = [LWEmotionPopView popView];
    }
    return _popView;
}

- (NSMutableArray *)symbolBtnArrM {
    if (!_symbolBtnArrM) {
        _symbolBtnArrM = [NSMutableArray array];
    }
    return _symbolBtnArrM;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupControls];
    }
    return self;
}

// 添加子控件
- (void)setupControls {
    if (self.showAnimation) {
        [self addGestureRecognizer:self.longPress];
    }else{
        [self removeGestureRecognizer:self.longPress];
    }
    UIImage *image = [UIImage imageMyBundleNamed:@"symbol_keyboardSymbolButton"];
    UIImage *highImage = [UIImage imageMyBundleNamed:@"symbol_keyboardSymbolButtonSel"];
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    highImage = [highImage stretchableImageWithLeftCapWidth:highImage.size.width * 0.5 topCapHeight:highImage.size.height * 0.5];
    
    
    NSString *plistPath = [NSBundle myPathForResource:@"LWKeyboardInfo" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.symbolStr = [dictionary valueForKey:@"CustomeSymbol"]?[dictionary valueForKey:@"CustomeSymbol"]:@"[]{}#%^*+=_-/:;()$&@.,?!'\\|~`<>€£¥\"";
    if (self.symbolStr.length != 35) {
        self.symbolStr = @"[]{}#%^*+=_-/:;()$&@.,?!'\\|~`<>€£¥\"";
    }
    
    NSUInteger length = self.symbolStr.length;
    // 字母按钮
    for (NSUInteger i = 0; i < length; i++) {
        unichar c = [self.symbolStr characterAtIndex:i];
        NSString *text = [NSString stringWithFormat:@"%c", c];
        LWKeyButton *symbolBtn = [LWKeyboardTool setupBasicButtonsWithTitle:text image:image highImage:image];
        symbolBtn.type = LWKeyButtonTypeNormal;
        [self addSubview:symbolBtn];
        
        [symbolBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.symbolBtnArrM addObject:symbolBtn];
    }
    
    // 其他按钮 spaceBtn、delete、login
    self.deleteBtn = [LWKeyboardTool setupFunctionButtonWithTitle:nil image:[UIImage imageMyBundleNamed:@"symbol_keyboardDeleteButton"] highImage:[UIImage imageMyBundleNamed:@"symbol_keyboardDeleteButtonSel"]];
    self.deleteBtn.type = LWKeyButtonTypeDel;
    self.loginBtn = [LWKeyboardTool setupFunctionButtonWithTitle:@"确定" image:[UIImage imageMyBundleNamed:@"symbol_keyboardLoginButton"] highImage:highImage];
    self.loginBtn.type = LWKeyButtonTypeDone;

    self.spaceBtn = [LWKeyboardTool setupFunctionButtonWithTitle:@"" image:[UIImage imageMyBundleNamed:@"symbol_keyboardSpaceButton"] highImage:[UIImage imageMyBundleNamed:@"symbol_keyboardSpaceButtonSel"]];
    self.spaceBtn.type = LWKeyButtonTypeSpace;

    if (self.showAnimation) {
        [self.spaceBtn setBackgroundImage:[UIImage imageMyBundleNamed:@"symbol_keyboardSpaceButtonSel"] forState:(UIControlStateHighlighted)];
    }else{
        [self.spaceBtn setBackgroundImage:[UIImage imageMyBundleNamed:@"symbol_keyboardSpaceButton"] forState:(UIControlStateHighlighted)];
    }

    [self.deleteBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.spaceBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnLong:)];
    longPress.minimumPressDuration = 0.5;
    [self.deleteBtn addGestureRecognizer:longPress];
    
    
    [self addSubview:self.deleteBtn];
    [self addSubview:self.loginBtn];
    [self addSubview:self.spaceBtn];
}
- (void)setShowAnimation:(BOOL)showAnimation{
    if (_showAnimation != showAnimation) {
        _showAnimation = showAnimation;
        if (_showAnimation) {
            [self addGestureRecognizer:self.longPress];
            [self.spaceBtn setBackgroundImage:[UIImage imageMyBundleNamed:@"symbol_keyboardSpaceButtonSel"] forState:(UIControlStateHighlighted)];
        }else{
            [self removeGestureRecognizer:self.longPress];
            [self.spaceBtn setBackgroundImage:[UIImage imageMyBundleNamed:@"symbol_keyboardSpaceButton"] forState:(UIControlStateHighlighted)];

        }
    }
}
/**
 *  在这个方法中处理长按手势
 */
- (void)longPressContentView:(UILongPressGestureRecognizer *)recognizer{
    CGPoint location = [recognizer locationInView:recognizer.view];
    // 获得手指所在的位置\所在的按钮
    LWKeyButton *btn = [self emotionButtonWithLocation:location];
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: // 手指已经不再触摸
            // 移除popView
            [self.popView removeFromSuperview];
            // 如果手指还在按钮上
            if (btn) {
                [self functionBtnClick:btn];
            }
            break;
            
        case UIGestureRecognizerStateBegan: // 手势开始（刚检测到长按）
        case UIGestureRecognizerStateChanged: { // 手势改变（手指的位置改变）
            {
                if (btn) {
                    [self.popView showFrom:btn];
                    if (btn == self.currentPressBtn) { // 在同一个按钮中移动
                        return;
                    }
                    self.currentPressBtn = btn;
                }else{
                    // 移除popView
                    [self.popView removeFromSuperview];
                    // 如果手指还在按钮上
                    if (btn) {
                        NSLog(@"手指已经不再触摸");
                    }
                }
            }
            break;
        }
            
        default:
            break;
    }
}

/**
 *  根据手指位置所在的按钮
 */
- (LWKeyButton *)emotionButtonWithLocation:(CGPoint)location{
    for (LWKeyButton *btn in self.symbolBtnArrM) {
        if (CGRectContainsPoint(btn.frame, location)) {
            // 已经找到手指所在的按钮了，就没必要再往下遍历
            return btn;
        }
    }
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat topMargin = 15;
    CGFloat bottomMargin = 3;
    CGFloat leftMargin = 3;
    CGFloat colMargin = 3;
    CGFloat rowMargin = 3;
    
    CGFloat buttonH = (self.height - (topMargin + bottomMargin + 3 * rowMargin)) / 4;
    CGFloat buttonW = (self.width - 9 * colMargin - leftMargin * 2) / 10;
    self.popView.width = 2*buttonW;
    self.popView.height = 2*buttonH;
    
    NSUInteger count = self.symbolBtnArrM.count;
    for (NSUInteger i = 0; i < count; i++) {
        
        UIButton *symbolBtn = (UIButton *)self.symbolBtnArrM[i];
        NSUInteger row = i < 29 ? i / 10 :(i+1) / 10;
        NSUInteger col = i < 29 ? i % 10 :(i+1) % 10;
        
        symbolBtn.x = leftMargin + (buttonW + colMargin) * col;
        symbolBtn.y = topMargin + (buttonH + rowMargin) * row;
        symbolBtn.width = buttonW;
        symbolBtn.height = buttonH;
    }
    CGFloat otherBtnW = 2 * buttonW + colMargin;
    CGFloat otherBtnY = self.height - bottomMargin - buttonH;
    self.loginBtn.frame = CGRectMake(self.width - leftMargin - otherBtnW, otherBtnY, otherBtnW, buttonH);
    self.spaceBtn.frame = CGRectMake(self.width - leftMargin - colMargin - 2 * otherBtnW, otherBtnY, otherBtnW, buttonH);
    self.deleteBtn.frame = CGRectMake(self.width - leftMargin - buttonW, otherBtnY - colMargin - buttonH, buttonW, buttonH);

}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch{
    if ([touch.view isDescendantOfView:self.loginBtn] || [touch.view isDescendantOfView:self.deleteBtn] || [touch.view isDescendantOfView:self.spaceBtn]) {
        return NO;
    }
    return  YES;
}
@end
