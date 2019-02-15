//
//  CBChangePwdVC.h
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBChangePwdVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTF;
@property (weak, nonatomic) IBOutlet UIButton *pwdNew1TF;
@property (weak, nonatomic) IBOutlet UITextField *pwdNew2TF;
@property (weak, nonatomic) IBOutlet UIButton *changePwdBtn;
- (IBAction)changePwdAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
