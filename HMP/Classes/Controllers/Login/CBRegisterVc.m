//
//  CBRegisterVc.m
//  QHBPRO
//
//  Created by mac on 2017/7/16.
//  Copyright © 2017年 hcb All rights reserved.
//

#import "CBRegisterVc.h"
#import "CBRegDoneVc.h"

@interface CBRegisterVc ()
{
    int smsNum;
    int curTime;
    NSTimer *timer;
}
@end

@implementation CBRegisterVc

- (void)viewDidLoad {
    [super viewDidLoad];
    smsNum = 0;
    self.title = @"注册";
    [CBFastUI addGradintBg:self.registerBtn];
    if (self.isFroget) {
        [CBFastUI addGradintBg:self.findPwd];
        self.title = @"找回密码";

    }
    if (self.isBind) {
        self.title = @"绑定手机号";
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isFroget) {
        self.navigationController.navigationBar.hidden = NO;
    }
    
}

- (IBAction)backAct:(id)sender {
    GOBACK;
}

-(void)registerBtnAct:(UIButton *)sender{
    if (_phone.text.length<1) {
        return;
    }
    if (_verifycode.text.length<1) {
        return;
    }
    if (_pwdField.text.length<1) {
        return;
    }
    if (_pwdField2.text.length<1) {
        return;
    }
    if (![_pwdField.text isEqualToString:_pwdField2.text]) {
        [LoadingView showAMessage:@"两次密码输入不一致"];
        return;
    }
    
    
    NSString *url = @"user/public/register";
    
    NSDictionary *par = @{
                          @"username":_phone.text,
                          @"password":_pwdField2.text,
                          @"verification_code":_verifycode.text,
                          @"device_type":@"ios",
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        [LoadingView stopLoading];
        //注册完成后，直接进入完善信息页面，
        if (ISDIC(obj) && obj[@"data"] && obj[@"data"][@"token"]) {
            CBUser *u = [CBUser share];
            u.token = obj[@"data"][@"token"];
            [u setValuesForKeysWithDictionary:obj[@"data"][@"user"]];
            [u save];
            [[Httprequest share].manager.requestSerializer setValue:[CBUser share].token forHTTPHeaderField:@"Marriage-Love-Token"];
            [[Httprequest share].manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Marriage-Love-Device-Type"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginEM" object:u.uid];
            [self registerDone];
        }
        /*
        if ([obj[@"code"] integerValue]==0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.backEvent) {
                    self.backEvent(@{@"acc":self.phone.text,@"pwd":self.pwdField2.text});
                }
                POP;
            });
        }
         */
    } andError:^(id error) {
        
    }];
}

-(void)registerDone{
    CBRegDoneVc *vc = (CBRegDoneVc *)[AppManager getVCInBoard:@"Login" ID:@"CBRegDoneVc"];
    PUSH(vc);
}

- (IBAction)userProtcolAct:(id)sender {
    CBWebVc *web = [[CBWebVc alloc]init];
    web.title = @"用户使用协议";
    web.url = [NSURL URLWithString:@"http://love.test2.yikeapp.cn/html/single_article/2.html"];
    SHOW(web);
}
-(void)codeAction:(UIButton *)sender{
    if (_phone.text.length<11) {
        [LoadingView showAMessage:@"请输入正确手机号"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    
    NSString *url = @"user/verification_code/send";
    
    NSDictionary *par = @{
                          @"username":_phone.text,
                          @"is_register":self.isFroget?@0:@1,
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        
        if ([obj[@"code"] integerValue]==0) {
            NSDictionary *info = obj;
            if (ISDIC(info) && [info[@"code"] integerValue]==0) {
                [LoadingView showAMessage:@"验证码发送成功"];
                [self->_verifycode becomeFirstResponder];
                [weakSelf countDown];
            }else{
                sender.userInteractionEnabled = YES;
            }
        }else{
            sender.userInteractionEnabled = YES;
        }
    } andError:^(id error) {
        sender.userInteractionEnabled = YES;

    }];
}

- (void)countDown{
    curTime = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cutTime) userInfo:nil repeats:YES];
}

- (void)cutTime{
    self.codeBtn.title = [NSString stringWithFormat:@"%ds",curTime];
    curTime -= 1;
    if (curTime<0) {
        self.codeBtn.userInteractionEnabled = YES;
        self.codeBtn.title = @"获取验证码";
        [timer invalidate];
    }
}

-(void)dealloc{
    [timer invalidate];
}
- (IBAction)findPwdAct:(id)sender {
    if (_phone.text.length<5) {
        return;
    }
    if (_verifycode.text.length<4) {
        return;
    }
    if (_pwdField.text.length<1) {
        return;
    }
    if (_pwdField2.text.length<1) {
        return;
    }
    if (![_pwdField.text isEqualToString:_pwdField2.text]) {
        [LoadingView showAMessage:@"两次密码输入不一致"];
        return;
    }
    NSString *url = @"user/public/passwordReset";
    
    NSDictionary *par = @{
                          @"username":_phone.text,
                          @"password":_pwdField2.text ,
                          @"verification_code":_verifycode.text,
                          
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        if (obj && [obj[@"msg"] containsString:@"成功"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                POP;
            });
        }
    } andError:^(id error) {
        
    }];
    
    
}


- (IBAction)bindAction:(UIButton *)sender {
    if (_phone.text.length<5) {
        return;
    }
    if (_verifycode.text.length<4) {
        return;
    }
   
    NSString *url = @"user/public/bindPhone";
    
    NSDictionary *par = @{
                          @"username":_phone.text,
                          @"verification_code":_verifycode.text,
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        if (obj && [obj[@"msg"] containsString:@"成功"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                POP;
            });
        }
    } andError:^(id error) {
        
    }];
    
    
}
@end
