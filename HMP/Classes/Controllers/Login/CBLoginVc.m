//
//  CBLoginVc.m
//  QHBPRO
//
//  Created by mac on 2017/7/16.
//  Copyright © 2017年 hcb All rights reserved.
//

#import "CBLoginVc.h"
#import "AppManager.h"
#import "AppDelegate.h"
#import "CBRegisterVc.h"
#import "CBWebVc.h"


typedef void (^returnObject)(id obj);
typedef void (^returnError)(id error);



@interface CBLoginVc ()
{
    BOOL canLogin;
    NSString *showmsg;
    NSInteger retry;
   
    
}
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
- (IBAction)loginAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *registerBn;

@end

@implementation CBLoginVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)thirdPartLogin:(id)sender {
}

- (void)configUI{
    NSString *path = [[AppManager documentDirectoryPath] stringByAppendingPathComponent:@"info.archive"];
    NSString *info = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    _accountField.text = [info componentsSeparatedByString:@"|"].firstObject;
    _pwdField.text = [info componentsSeparatedByString:@"|"].lastObject;
    
    [CBFastUI addGradintBg:self.login];
    
    [CBFastUI addRoundCornerAnBorder:self.registerBn];
    
    
}


- (IBAction)yinsi:(id)sender {
    CBWebVc *vc = (CBWebVc *)[AppManager getVCInBoard:@"Main" ID:@"CBWebVc"];
    vc.title = @"隐私政策";
    vc.url = [NSURL URLWithString:@"https://m.baidu.com"];
    SHOW(vc);
}

- (void)showInfoAndExit:(NSString *)msg{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:act1];
    
    
    [self presentViewController:alertVc animated:YES completion:nil];
}
- (void)savePwd{
    NSString *info = [NSString stringWithFormat:@"%@|%@",_accountField.text,_pwdField.text];
    NSString *path = [[AppManager documentDirectoryPath] stringByAppendingPathComponent:@"info.archive"];
    [NSKeyedArchiver archiveRootObject:info toFile:path];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)loginAction:(UIButton *)sender {
  
    if (self.accountField.text.length<1) {
        [LoadingView showAMessage:@"请输入正确的用户名"];
        return;
    }
    if (self.pwdField.text.length<1) {
        [LoadingView showAMessage:@"请输入密码"];
        return;
    }
    [self.view endEditing:YES];

    [self savePwd];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    [LoadingView showLoading];
    [[CBBaseModel share] request:@"" par:nil callback:^(BOOL succs, id  _Nonnull value, NSError * _Nonnull error) {
    
        if ([AppManager isCurrentViewControllerVisible:self]) {
            
            if (!error) {
//                UITabBarController *bar = (UITabBarController *)[AppManager getVCInBoard:@"Main" ID:@"barvc"];
//
//                [self presentViewController:bar animated:YES completion:nil];
                if (self.backEvent) {
                    self.backEvent(@1);
                }
                POP;
                
            }else{
                if (error.code==101) {
                    [LoadingView showAMessage:@"用户名或密码错误"];
                    
                }else
                    [LoadingView showAMessage:@"登录失败,请检查网络"];
                
            }
        }
        [LoadingView stopLoading];

    }];
    
}
- (IBAction)forget:(UIButton *)sender {
    
    CBRegisterVc *vc = (CBRegisterVc *)[AppManager getVCInBoard:@"Login" ID:@"CBFrogetVc"];
    vc.isFroget = YES;
    SHOW(vc);
}
- (IBAction)goReg:(id)sender {
    CBRegisterVc *vc = (CBRegisterVc *)[AppManager getVCInBoard:@"Login" ID:@"CBRegisterVc"];
    vc.backEvent = ^(id value) {
        NSDictionary *dic = value;
        if (dic) {
            self.accountField.text = dic[@"acc"];
            self.pwdField.text = dic[@"pwd"];
            
            [self loginAction:nil];
        }
    };
    SHOW(vc);
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.prefersLargeTitles = NO;
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.prefersLargeTitles = YES;
//}
@end
