//
//  HXTagAttribute.m
//  HXTagsView https://github.com/huangxuan518/HXTagsView
//  博客地址 http://blog.libuqing.com/
//  Created by Love on 16/6/30.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXTagAttribute.h"

@implementation HXTagAttribute

- (instancetype)init
{
    self = [super init];
    if (self) {
        int r = arc4random() % 255;
        int g = arc4random() % 255;
        int b = arc4random() % 255;
        
        UIColor *normalBackgroundColor = [UIColor colorWithRed:(b+20)/255.0 green:(r+20)/255.0 blue:(g+20)/255.0 alpha:1.0];
        UIColor *selectedBackgroundColor = MainColor;
        
        _borderWidth = 0;
        _cornerRadius = 17.5;
        _normalBackgroundColor = normalBackgroundColor;
        _selectedBackgroundColor = MainColor;
        _titleSize = 15;
        _textColor = [UIColor blackColor];
        _keyColor = [UIColor redColor];
        _tagSpace = 20;
    }
    return self;
}

@end
