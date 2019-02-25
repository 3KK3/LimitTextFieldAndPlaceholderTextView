//
//  NSString+Count.h
//  COCTextViewAndFieldDemo
//
//  Created by YZY on 2019/2/25.
//  Copyright © 2019 Cocfish. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Count)

- (NSInteger)getStringLenthOfBytes;

- (NSString *)subBytesOfStringToIndex:(NSInteger)index;
//检测中文或者中文符号
- (BOOL)validateChineseChar;
//检测中文
- (BOOL)validateChinese;

- (BOOL)isMatchesRegularExp:(NSString *)regex;

@end

NS_ASSUME_NONNULL_END
