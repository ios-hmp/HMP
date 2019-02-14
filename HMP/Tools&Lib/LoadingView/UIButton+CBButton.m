//
//  UIButton+CBButton.m
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIButton+CBButton.h"

@implementation UIButton (CBButton)


- (void)setTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

-(NSString *)title{
    return self.currentTitle;
}

@end
