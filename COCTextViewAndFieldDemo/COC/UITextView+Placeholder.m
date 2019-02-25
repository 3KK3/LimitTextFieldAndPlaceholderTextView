//
//  UITextView+Placeholder.m
//  COCTextViewAndFieldDemo
//
//  Created by YZY on 2019/2/25.
//  Copyright © 2019 Cocfish. All rights reserved.
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

static const void *textView_key = @"placeHolder";

static NSInteger const TextViewPLTag = 1008611111;

@implementation UITextView (Placeholder)

- (void)setPlaceHolder:(NSString *)placeHolder {
    
    if (placeHolder != self.placeHolder) {
        
        objc_setAssociatedObject(self, textView_key, placeHolder, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        UILabel *placeHolderLb = [self viewWithTag: TextViewPLTag];
        
        if (!placeHolderLb) {
            placeHolderLb = [[UILabel alloc] initWithFrame:CGRectMake(2, 7,200, 21)];
            placeHolderLb.tag = TextViewPLTag;
            placeHolderLb.contentMode = UIViewContentModeTop;
            placeHolderLb.numberOfLines = 0;
            placeHolderLb.textColor = [UIColor lightGrayColor];
            placeHolderLb.font = [UIFont systemFontOfSize: 15];
            placeHolderLb.alpha = 1;
            [self addSubview:placeHolderLb];
        }
        placeHolderLb.text = placeHolder;
        
        //之所以使用通知形式是为了不影响textView的delegate方法，否则别的地方- (void)textViewDidChange:(UITextView *)textView这个代理不会再执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (NSString *)placeHolder {
    return objc_getAssociatedObject(self, textView_key);
}

- (void)textViewChanged:(NSNotification *)noti {
    
    UILabel *label = [self viewWithTag: TextViewPLTag];
    [UIView animateWithDuration: 0.15 animations:^{
        if (self.text.length == 0) {
            label.alpha = 1;
        } else {
            label.alpha = 0;
        }
    }];
}

@end
