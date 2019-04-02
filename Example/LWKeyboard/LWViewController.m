//
//  LWViewController.m
//  LWKeyboard
//
//  Created by zglinwei_0916@163.com on 04/02/2019.
//  Copyright (c) 2019 zglinwei_0916@163.com. All rights reserved.
//

#import "LWViewController.h"
#import <LWKeyboard/LWTextField.h>

@interface LWViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) LWTextField *textField;

@end

@implementation LWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    _textField = [[LWTextField alloc]initWithFrame:CGRectMake(10, 100, 300, 30)];
    _textField.delegate = self;
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.textAlignment = NSTextAlignmentLeft;
    //    _textField.secureTextEntry = YES;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [_textField p_configKeyboardIconImage:nil titile:@"安全键盘"];
    [self.view addSubview:_textField];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
