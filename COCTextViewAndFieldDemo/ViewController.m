//
//  ViewController.m
//  COCTextViewAndFieldDemo
//
//  Created by YZY on 2019/2/25.
//  Copyright © 2019 Cocfish. All rights reserved.
//

#import "ViewController.h"
#import "COC/CocLimitTextLengthTextField.h"
#import "COC/UITextView+Placeholder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    CocLimitTextLengthTextField *textField = [[CocLimitTextLengthTextField alloc] initWithFrame: CGRectMake(100, 100, 200, 100)];
    textField.limitLength = 10;
    [self.view addSubview: textField];
    textField.backgroundColor = [UIColor redColor];
    
    UITextView *textView = [[UITextView alloc] initWithFrame: CGRectMake(100, 400, 100, 100)];
    textView.placeHolder = @"这是placeholder";
    [self.view addSubview: textView];
    textView.backgroundColor = [UIColor greenColor];

}


@end
