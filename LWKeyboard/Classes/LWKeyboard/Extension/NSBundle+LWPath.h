//
//  NSBundle+LWPath.h
//  CustomKeyboardDemo
//
//  Created by lwmini on 2019/4/1.
//  Copyright © 2019年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (LWPath)
+ (NSString *)myPathForResource:(NSString *)name ofType:(NSString *)ext;
@end
