//
//  LWLetterKeyboard.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/26.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "LWLetterKeyboard.h"
#import "LWEmotionPopView.h"

@interface LWLetterKeyboard ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *lettersArr;

@property (nonatomic, strong) NSArray *uppersArr;

@property (nonatomic, strong) NSArray *numsArr;
/** 数字按钮 */
@property (nonatomic, strong) NSMutableArray *numBtnsArrM;
/** 小写字母按钮 */
@property (nonatomic, strong) NSMutableArray *charBtnsArrM;
/** 其他按钮 */
@property (nonatomic, strong) NSMutableArray *tempArrM;
/** 其他按钮 切换大小写 */
@property (nonatomic, strong) LWKeyButton *shiftBtn;
/** 其他按钮 完成 */
@property (nonatomic, strong) LWKeyButton *loginBtn;

@property (nonatomic, assign) BOOL isUpper;
/** 点击按钮后弹出的放大镜 */
@property (nonatomic, strong) LWEmotionPopView *popView;
/// 长按手势时所在的按钮
@property (nonatomic, weak) LWKeyButton *currentPressBtn;
/// 长按手势
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@end

@implementation LWLetterKeyboard
@synthesize showAnimation = _showAnimation;

- (UILongPressGestureRecognizer *)longPress{
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressContentView:)];
        _longPress.minimumPressDuration = 0.01;
        _longPress.delegate = self;
    }
    return _longPress;
}
- (LWEmotionPopView *)popView{
    if (!_popView) {
        _popView = [LWEmotionPopView popView];
    }
    return _popView;
}

- (NSArray *)numsArr{
    if (!_numsArr) {
        _numsArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    }
    return _numsArr;
}
- (NSArray *)lettersArr {
    if (!_lettersArr) {
        _lettersArr = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    }
    return _lettersArr;
}

- (NSArray *)uppersArr {
    if (!_uppersArr) {
        _uppersArr = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
    }
    return _uppersArr;
}

- (NSMutableArray *)charBtnsArrM {
    if (!_charBtnsArrM) {
        _charBtnsArrM = [NSMutableArray array];
    }
    return _charBtnsArrM;
}

- (NSMutableArray *)numBtnsArrM{
    if (!_numBtnsArrM) {
        _numBtnsArrM = [NSMutableArray array];
    }
    return _numBtnsArrM;
}

- (NSMutableArray *)tempArrM {
    if (!_tempArrM) {
        _tempArrM = [NSMutableArray array];
    }
    return _tempArrM;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = LWKeyboardTypeLetter;
        self.isUpper = YES;
        [self setupControls];
        
    }
    return self;
}
- (void)setShowAnimation:(BOOL)showAnimation{
    if (_showAnimation != showAnimation) {
        _showAnimation = showAnimation;
        if (_showAnimation) {
            [self addGestureRecognizer:self.longPress];
        }else{
            [self removeGestureRecognizer:self.longPress];
        }
    }
}
- (void)setupControls {
    // 给 self.musicBtnContentView 添加长按手势
    if (self.showAnimation) {
        [self addGestureRecognizer:self.longPress];
    }else{
        [self removeGestureRecognizer:self.longPress];
    }
    // 添加26个字母按钮
    UIImage *image = [UIImage imageMyBundleNamed:@"letter_keyboardCharButton"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    UIImage *highImage = [UIImage imageMyBundleNamed:@"letter_keyboardCharButtonSel"];
    highImage = [highImage stretchableImageWithLeftCapWidth:highImage.size.width * 0.5 topCapHeight:highImage.size.height * 0.5];
    
    NSUInteger count = self.lettersArr.count;
    for (NSUInteger i = 0 ; i < count; i++) {
        LWKeyButton *charBtn = [LWKeyboardTool setupBasicButtonsWithTitle:nil image:image highImage:image];
        charBtn.type = LWKeyButtonTypeNormal;
        [charBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:charBtn];
        [self.charBtnsArrM addObject:charBtn];
    }
    //添加10个数字
    NSUInteger numCount = self.numsArr.count;
    NSMutableArray *tempNumbers = [NSMutableArray arrayWithArray:self.numsArr];
    for (NSUInteger i = 0 ; i < numCount; i++) {
        LWKeyButton *numBtn = [LWKeyboardTool setupBasicButtonsWithTitle:nil image:image highImage:image];
        numBtn.type = LWKeyButtonTypeNormal;
        int index = arc4random() % tempNumbers.count;
        [numBtn setTitle:tempNumbers[index] forState:UIControlStateNormal];
        [tempNumbers removeObjectAtIndex:index];
        [numBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:numBtn];
        [self.numBtnsArrM addObject:numBtn];
    }
    // 添加其他按钮 切换大小写、删除回退、确定
    self.shiftBtn = [LWKeyboardTool setupFunctionButtonWithTitle:nil image:[UIImage imageMyBundleNamed:@"letter_KeyboardShiftButton"] highImage:nil];
    [self.shiftBtn setBackgroundImage:[UIImage imageMyBundleNamed:@"letter_KeyboardShiftButtonSel"] forState:UIControlStateSelected];
    self.shiftBtn.type = LWKeyButtonTypeOther;
    
    self.deleteBtn = [LWKeyboardTool setupFunctionButtonWithTitle:nil image:[UIImage imageMyBundleNamed:@"letter_keyboardDeleteButton"] highImage:[UIImage imageMyBundleNamed:@"letter_keyboardDeleteButtonSel"]];
    self.deleteBtn.type = LWKeyButtonTypeDel;

    self.loginBtn = [LWKeyboardTool setupFunctionButtonWithTitle:@"确定" image:[UIImage imageMyBundleNamed:@"letter_keyboardLoginButton"] highImage:highImage];
    self.loginBtn.type = LWKeyButtonTypeDone;
    
    [self.shiftBtn addTarget:self action:@selector(changeCharacteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnLong:)];
    longPress.minimumPressDuration = 0.5;
    [self.deleteBtn addGestureRecognizer:longPress];
    
    [self addSubview:self.shiftBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.loginBtn];
    [self changeCharacteBtnClick:nil];
}

- (void)changeCharacteBtnClick:(LWKeyButton *)shiftBtn {
    [self.tempArrM removeAllObjects];
    NSUInteger count = self.charBtnsArrM.count;
    shiftBtn.selected = !shiftBtn.selected;
    if (self.isUpper) {
        self.tempArrM = [NSMutableArray arrayWithArray:self.lettersArr];
        self.isUpper = NO;
    } else {
        
        self.tempArrM = [NSMutableArray arrayWithArray:self.uppersArr];
        self.isUpper = YES;
    }
    for (int i = 0; i < count; i++) {
        LWKeyButton *charBtn = (LWKeyButton *)self.charBtnsArrM[i];
        NSString *upperTitle = self.tempArrM[i];
        [charBtn setTitle:upperTitle forState:UIControlStateNormal];
        [charBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    for (LWKeyButton *btn in self.charBtnsArrM) {
        if (CGRectContainsPoint(btn.frame, location)) {
            // 已经找到手指所在的按钮了，就没必要再往下遍历
            return btn;
        }
    }
    for (LWKeyButton *btn in self.numBtnsArrM) {
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
    
    // 布局字母按钮
    CGFloat buttonW = (self.width - 2 * leftMargin - 9 * colMargin) / 10;
    CGFloat buttonH = (self.height - topMargin - bottomMargin - 3 * rowMargin) / 4;
    self.popView.width = 2*buttonW;
    self.popView.height = 2*buttonH;
    
    NSUInteger nums = self.numBtnsArrM.count;
    for (NSUInteger i = 0; i < nums; i++) {
        
        LWKeyButton *button = (LWKeyButton *)self.numBtnsArrM[i];
        button.width = buttonW;
        button.height = buttonH;
        // 第一行
        button.x = (colMargin + buttonW) * i + leftMargin;
        button.y = topMargin;
    }

    NSUInteger count = self.charBtnsArrM.count;
    for (NSUInteger i = 0; i < count; i++) {
        LWKeyButton *button = (LWKeyButton *)self.charBtnsArrM[i];
        button.width = buttonW;
        button.height = buttonH;
        if (i < 10) { // 第二行
            button.x = (colMargin + buttonW) * i + leftMargin;
            button.y = topMargin + rowMargin + buttonH;
        } else if (i < 19) { // 第三行
            button.x = (colMargin + buttonW) * (i - 10) + leftMargin ;
            button.y = topMargin + 2 * (rowMargin +buttonH);
        } else if (i < count) {
            button.x = (colMargin + buttonW) * (i - 19) + leftMargin + buttonW + colMargin;
            button.y = topMargin + 3 * (rowMargin + buttonH);
        }
    }

    // 布局其他功能按钮  切换大小写、删除回退、确定（登录）
    CGFloat shiftBtnW =  buttonW;
    CGFloat shiftBtnY = topMargin + 3 * (rowMargin + buttonH);
    self.shiftBtn.frame = CGRectMake(leftMargin, shiftBtnY, shiftBtnW, buttonH);
    
    CGFloat deleteBtnW = buttonW;
    CGFloat deleteBtnY = topMargin + 2 * (rowMargin + buttonH);;
    self.deleteBtn.frame = CGRectMake(self.width - leftMargin - deleteBtnW, deleteBtnY, deleteBtnW, buttonH);
    
    CGFloat loginBtnW = 2 * buttonW + colMargin;
    CGFloat loginBtnY = self.height - bottomMargin - buttonH;
    CGFloat loginBtnX = self.width - leftMargin - loginBtnW;
    self.loginBtn.frame = CGRectMake(loginBtnX, loginBtnY, loginBtnW, buttonH);
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch{
    if ([touch.view isDescendantOfView:self.loginBtn] || [touch.view isDescendantOfView:self.deleteBtn] || [touch.view isDescendantOfView:self.shiftBtn]) {
        return NO;
    }
    return  YES;
}

@end
