//
//  LWTextField.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/28.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "LWTextField.h"
#import "LWKeyboard.h"

@interface LWTextField ()<LWKeyboardDelegate>

@property (strong, nonatomic) LWKeyboard *keyboard;

@end

@implementation LWTextField

- (LWKeyboard *)keyboard{
    if (_keyboard == nil) {
        _keyboard = [[LWKeyboard alloc] init];
        _keyboard.delegate = self;
    }
    return _keyboard;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self p_setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setUpUI];
    }
    return self;
}

- (void)p_setUpUI{
    self.inputView = self.keyboard;
}
- (void)p_configKeyboardIconImage:(UIImage *)image titile:(NSString *)text{
    [self.keyboard p_configKeyboardIconImage:image titile:text];
}

- (void)resetKeyboard{
    [self.keyboard p_resetKeyboard];
}
#pragma mark -- overwrite
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event{
    BOOL beginTouch;
    beginTouch = [super beginTrackingWithTouch:touch withEvent:event];
    [self resetKeyboard];
    return beginTouch;
}
#pragma mark -- LWKeyboardDelegate
- (void)changeStringkeyboard:(LWKeyboard *)keyboard didClickButton:(LWKeyButton *)deleteBtn string:(NSString *)text{
    [self changetext:text];
}

- (void)didClickLoginButton:(LWKeyButton *)LoginBtn{
    if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        [self.delegate textFieldShouldReturn:self];
    }
}


/**
 *  修改textField中的文字
 */
- (void)changetext:(NSString *)text {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = self.selectedTextRange.start;
    UITextPosition *end = self.selectedTextRange.end;
    NSInteger startIndex = [self offsetFromPosition:beginning toPosition:start];
    NSInteger endIndex = [self offsetFromPosition:beginning toPosition:end];
    
    // 将输入框中的文字分成两部分，生成新字符串，判断新字符串是否满足要求
    NSString *originText = self.text;
    NSString *part1 = [originText substringToIndex:startIndex];
    NSString *part2 = [originText substringFromIndex:endIndex];
    
    NSInteger offset;
    
    if (![text isEqualToString:@""]) {
        offset = text.length;
    } else {
        if (startIndex == endIndex) { // 只删除一个字符
            if (startIndex == 0) {
                return;
            }
            offset = -1;
            part1 = [part1 substringToIndex:(part1.length - 1)];
        } else {
            offset = 0;
        }
    }
    
    NSString *newText = [NSString stringWithFormat:@"%@%@%@", part1, text, part2];
    self.text = newText;
    // 重置光标位置
    UITextPosition *now = [self positionFromPosition:start offset:offset];
    UITextRange *range = [self textRangeFromPosition:now toPosition:now];
    self.selectedTextRange = range;
}
@end
