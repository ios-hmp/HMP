//
//  CBFastUI.h
//  HMP
//
//  Created by hcb on 2019/1/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AlertCallback)(NSString *title);
@interface CBFastUI : NSObject

+ (UIButton *)cornerBtnWithTitle:(NSString *)title  frame:(CGRect)frame bgColor:(UIColor *)bgColor imgName:(NSString *)imageName;
+ (void)addShadow:(UIView *)view color:(UIColor *)color;
+ (void)showAlert:(NSString *)title  content:(NSString *)content  btns:(NSArray *)btns callBack:(AlertCallback)callBack;
+ (void)addGradintBg:(UIButton *)btn;
+ (void)addRoundCornerAnBorder:(UIButton *)btn;



@end

NS_ASSUME_NONNULL_END
