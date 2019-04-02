//
//  LWEmotionPopView.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/30.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "LWEmotionPopView.h"
#import "UIView+LWExtension.h"
#import "UIImage+LWKeyboardBundle.h"

@interface LWEmotionPopView ()

@property(nonatomic, strong)UILabel *textLabel;

@end

@implementation LWEmotionPopView


+ (instancetype)popView{
    LWEmotionPopView *popView = [[LWEmotionPopView alloc]init];
    [popView setImage:[UIImage imageMyBundleNamed:@"popView_bg"] forState:(UIControlStateNormal)];
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = [UIColor blackColor];
    textLabel.font = [UIFont systemFontOfSize:30];
    textLabel.textAlignment = NSTextAlignmentCenter;
    popView.textLabel = textLabel;
    [popView addSubview:textLabel];
    return popView;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(0, 0, self.width, self.height/2);
}
- (void)showFrom:(UIButton *)button{
    if (button == nil) return;
    // 取得最上面的window
    self.textLabel.text = button.titleLabel.text;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMaxY(btnFrame) - self.height; 
    self.centerX = CGRectGetMidX(btnFrame);
}

@end
