//
//  NSBundle+LWPath.m
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/4/1.
//  Copyright © 2019年 lw. All rights reserved.
//

#import "NSBundle+LWPath.h"

@implementation NSBundle (LWPath)

+ (NSString *)myPathForResource:(NSString *)name ofType:(NSString *)ext{
    NSString *path;
    path = [[NSBundle mainBundle]pathForResource:name ofType:ext inDirectory:@"LWKeyboard.bundle"];
    if (path.length == 0) {
        path = [[NSBundle mainBundle]pathForResource:name ofType:ext inDirectory:@"Frameworks/LWKeyboard.framework/LWKeyboard.bundle"];
        if (path.length == 0) {
            path = ext.length == 0?name:[NSString stringWithFormat:@"%@.%@",name,ext];
        }
    }
    return path;
}

@end
