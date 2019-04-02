//
//  UIImage+LWKeyboardBundle.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/3/28.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "UIImage+LWKeyboardBundle.h"

@implementation UIImage (LWKeyboardBundle)
+(UIImage *)imageMyBundleNamed:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:[@"LWKeyboard.bundle" stringByAppendingPathComponent:imageName]];
    if (image) {
        return image;
    } else {
        image = [UIImage imageNamed:[@"Frameworks/LWKeyboard.framework/LWKeyboard.bundle" stringByAppendingPathComponent:imageName]];
        if (!image) {
            image = [UIImage imageNamed:imageName];
        }
        return image;
    }
}
@end
