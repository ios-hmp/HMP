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

    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isFroget) {
        self.navigationController.navigationBar.hidden = NO;
    }
    
}


//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    if (self.isFroget) {
//        self.navigationController.navigationBar.hidden = YES;
//    }
//}

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
    [LoadingView showLoading];
    [[CBBaseModel share] request:@"" par:nil callback:^(BOOL succs, id  _Nonnull value, NSError * _Nonnull error) {
        [LoadingView stopLoading];
        
        [self registerDone];
        if (error) {
            NSLog(@"%@",error);
           
                [LoadingView showAMessage:error.description];
            
        }else{
            [LoadingView showAMessage:@"注册成功"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                if (self.backEvent) {
//                    self.backEvent(@{@"acc":self.phone.text,@"pwd":self.pwdField2.text});
//                }
//                POP;
//            });
        }
    }];
}

-(void)registerDone{
    CBRegDoneVc *vc = (CBRegDoneVc *)[AppManager getVCInBoard:@"Login" ID:@"CBRegDoneVc"];
    PUSH(vc);
}

- (IBAction)userProtcolAct:(id)sender {
    CBWebVc *web = [[CBWebVc alloc]init];
    web.title = @"用户使用协议";
    SHOW(web);
}
-(void)codeAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    [[CBBaseModel share] request:@"" par:nil callback:^(BOOL succs, id  _Nonnull value, NSError * _Nonnull error) {
        [LoadingView stopLoading];
        
        if (error) {
            sender.userInteractionEnabled = YES;
            NSLog(@"%@",error);
            
            [LoadingView showAMessage:error.description];
            
        }else{
            NSDictionary *info = value;
            if (ISDIC(info) && [info[@"code"] integerValue]==1) {
                [LoadingView showAMessage:@"验证码发送成功"];
                
                [weakSelf countDown];
            }else if(ISDIC(info)){
                [LoadingView showAMessage:info[@"msg"]];
            }
            
        }
    }];
}

- (void)countDown{
    curTime = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cutTime) userInfo:nil repeats:YES];
}

- (void)cutTime{
    self.codeBtn.title = [NSString stringWithFormat:@"%d",curTime];
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
}
@end
