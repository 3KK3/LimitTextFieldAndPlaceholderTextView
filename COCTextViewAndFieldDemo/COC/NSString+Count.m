//
//  NSString+Count.m
//  COCTextViewAndFieldDemo
//
//  Created by YZY on 2019/2/25.
//  Copyright © 2019 Cocfish. All rights reserved.
//

#import "NSString+Count.h"

@implementation NSString (Count)

- (NSInteger)getStringLenthOfBytes {
    NSInteger length = 0;
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([s validateChineseChar]) {
            length +=2;
        }else{
            length +=1;
        }
    }
    return length;
}

- (NSString *)subBytesOfStringToIndex:(NSInteger)index {
    NSInteger length = 0;
    
    NSInteger chineseNum = 0;
    NSInteger zifuNum = 0;
    
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([s validateChineseChar]) {
            if (length + 2 > index) {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            
            length +=2;
            chineseNum +=1;
        } else {
            if (length +1 >index) {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            length+=1;
            
            zifuNum +=1;
        }
    }
    return [self substringToIndex:index];
}

//检测中文或者中文符号
- (BOOL)validateChineseChar {
    NSString *nameRegEx = @"[\\u0391-\\uFFE5]";
    if (![self isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

//检测中文
- (BOOL)validateChinese {
    NSString *nameRegEx = @"[\u4e00-\u9fa5]";
    if (![self isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

- (BOOL)isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject: self];
}


@end
