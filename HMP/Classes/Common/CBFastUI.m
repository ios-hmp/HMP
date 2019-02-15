//
//  CBFastUI.m
//  HMP
//
//  Created by hcb on 2019/1/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBFastUI.h"
#import <UIKit/UIKit.h>

@implementation CBFastUI


+(void)addShadow:(UIView *)view color:(UIColor *)color{
    view.layer.shadowOffset = CGSizeMake(0, 4);
    view.layer.shadowRadius = 5;
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = 0.4;
}

+ (void)addGradintBg:(UIButton *)btn{
    btn.backgroundColor = MainColor;
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = btn.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.cornerRadius = btn.height*0.5;
    [gradientLayer setColors:@[(id)[RGBA(253, 115, 179, 1.0) CGColor],(id)[MainColor CGColor]]];//渐变数组
    [btn.layer insertSublayer:gradientLayer atIndex:0];
    [self addShadow:btn color:[MainColor colorWithAlphaComponent:1]];
}

+ (void)addRoundCornerAnBorder:(UIButton *)btn{
    btn.layer.borderColor = btn.currentTitleColor.CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = btn.height*0.5;
    btn.layer.masksToBounds = YES;
}

+ (UIButton *)cornerBtnWithTitle:(NSString *)title frame:(CGRect)frame bgColor:(UIColor *)bgColor imgName:(NSString *)imageName{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = Font(15);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = frame;
    if (bgColor) {
        btn.backgroundColor = bgColor;
    }
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@" %@",title] forState:UIControlStateNormal];
    }
    
    return btn;
}


+ (void)showAlert:(NSString *)title content:(nonnull NSString *)content btns:(nonnull NSArray *)btns callBack:(nonnull AlertCallback)callBack{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    int i = 0;
    for (NSString *tit in btns) {
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:tit style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            callBack(action.title);
        }];
        [alertVc addAction:act1];
        @try {
            if (i==0) {
                [act1 setValue:[UIColor grayColor] forKey:@"titleTextColor"];
            }else{
                [act1 setValue:MainColor forKey:@"titleTextColor"];
            }
        } @catch (NSException *exception) {
            [LoadingView showAMessage:@"系统错误：100"];
        } @finally {
            
        }
        
        i+=1;
    }

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
}
@end
