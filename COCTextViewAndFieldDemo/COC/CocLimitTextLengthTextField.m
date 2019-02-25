//
//  CocLimitTextLengthTextField.m
//  COCTextViewAndFieldDemo
//
//  Created by YZY on 2019/2/25.
//  Copyright © 2019 Cocfish. All rights reserved.
//

#import "CocLimitTextLengthTextField.h"
#import <ReactiveObjC.h>
#import "NSString+Count.h"

@implementation CocLimitTextLengthTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        [self loadBaseCocoa];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder: aDecoder]) {
        [self loadBaseCocoa];
    }
    return self;
}

- (void)loadBaseCocoa {
    self.limitLength = MAXFLOAT;
    @weakify(self)
    [self.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        [self textFiledDidChange];
    }];
}

- (void)textFiledDidChange  {
    if (self.limitLength == 0) return;
    
    NSString *toBeString = self.text;
    
    NSString *lang = [[self textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        
        //判断markedTextRange是不是为Nil，如果为Nil的话就说明你现在没有未选中的字符，
        //可以计算文字长度。否则此时计算出来的字符长度可能不正确
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分(感觉输入中文的时候才有)
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            //中文和字符一起检测  中文是两个字符
            if ([toBeString getStringLenthOfBytes] > self.limitLength) {
                self.text = [toBeString subBytesOfStringToIndex: self.limitLength];
            }
        }
    }
    else {
        if ([toBeString getStringLenthOfBytes] > self.limitLength)
        {
            self.text = [toBeString subBytesOfStringToIndex: self.limitLength];
        }
    }
}


@end
