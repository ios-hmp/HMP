//
//  CBRegisterVc.h
//  QHBPRO
//
//  Created by mac on 2017/7/16.
//  Copyright © 2017年 hcb All rights reserved.
//


#import "CBBaseVc.h"

@interface CBRegisterVc : CBBaseVc
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *verifycode;
@property (weak, nonatomic) IBOutlet UITextField *inviteField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField2;
- (IBAction)codeAction:(UIButton *)sender;
- (IBAction)registerBtnAct:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

- (IBAction)userProtcolAct:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *findPwd;
@property (nonatomic,assign)BOOL isFroget;
@property (nonatomic,assign)BOOL isBind;
- (IBAction)findPwdAct:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sureBind;
- (IBAction)bindAction:(UIButton *)sender;

@end
