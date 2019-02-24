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
#import "CBBaseTabbarVc.h"
#import "WXApi.h"

typedef void (^returnObject)(id obj);
typedef void (^returnError)(id error);



@interface CBLoginVc ()<WXApiDelegate>
{
    BOOL canLogin;
    NSString *showmsg;
    NSInteger retry;
    NSString *openid;
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
    _accountField.text = @"18629450667";
    _pwdField.text = @"18629450667";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (!TARGET_OS_SIMULATOR && ![WXApi isWXAppInstalled]) {
        self.wxImg.hidden = YES;
        self.wxlable.hidden = YES;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(wxcbk:) name:@"wxcbk" object:nil];
}

-(void)doLogin{
    
    NSString *url = @"user/public/login";
    
    NSDictionary *par = @{
                          @"username":_accountField.text,
                          @"password":_pwdField.text,
                          @"device_type":@"ios",
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        if (ISDIC(obj) && ISDIC(obj[@"data"]) && obj[@"data"][@"token"]) {
            [self judgeLoginRes:obj];
        }
    } andError:^(id error) {
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)configUI{
    NSString *path = [[AppManager documentDirectoryPath] stringByAppendingPathComponent:@"info.archive"];
    NSString *info = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    _accountField.text = [info componentsSeparatedByString:@"|"].firstObject;
    _pwdField.text = [info componentsSeparatedByString:@"|"].lastObject;
    
    [CBFastUI addGradintBg:self.login];
    
    [CBFastUI addRoundCornerAnBorder:self.registerBn];

    //使其可以滑动
    UIScrollView *bg = [[UIScrollView alloc]initWithFrame:self.view.frame];
    UIView *last ;
    for (UIView *v  in self.view.subviews) {
        if (v.tag==1) {
            continue;
        }
        last = v;
        [bg addSubview:v];
    }
    bg.contentSize = CGSizeMake(SWIDTH, MAX(SHEIGHT+1, last.bottom+40));
    [self.view addSubview:bg];
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
    
    
    [self doLogin];

}

-(void)goBind{
    CBRegisterVc *vc = (CBRegisterVc *)[AppManager getVCInBoard:@"Login" ID:@"BindPhone"];
    vc.isBind = YES;
    SHOW(vc);
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

#pragma mark - 第三方登录

- (IBAction)thirdPartLogin:(UIButton *)sender {
    if (sender.tag==1) {
        
    }else if(sender.tag==2){
        //构造SendAuthReq结构体
        SendAuthReq* req = [[SendAuthReq alloc]init];
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];
    }
}

-(void)fastLogin:(int)type{
//    1:QQ，2:微信，3：支付宝
    [LoadingView showLoading];
    __weak typeof(self) weakSelf = self;
    [CBBaseModel request:@"user/public/oauth_login" par:@{@"openid":openid?:@"",@"oauth_type":@(type),@"user_nickname":@"测试第三方",@"avatar":@""} callback:^(id  _Nonnull data, NSString * _Nonnull msg) {
        if (data) {
            [weakSelf judgeLoginRes:data];
        }
    }];
}

-(void)wxcbk:(NSNotification *)noti{
    SendAuthResp *resp = noti.object;
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",KWXAPPID,KWXSECRET,resp.code];
    openid = resp.code;
    [self fastLogin:2];
    [[Httprequest share] postObjectByParameters:nil andUrl:url  showLoading:YES showMsg:NO isFullUrk:YES andComplain:^(id obj) {
        if (obj) {
            /*
             {
             "access_token":"ACCESS_TOKEN",
             "expires_in":7200,
             "refresh_token":"REFRESH_TOKEN",
             "openid":"OPENID",
             "scope":"SCOPE",
             "unionid":"o6_bmasdasdsad6_2sgVt7hMZOPfL"
             }
             */
            
        }
    } andError:^(id error) {
        
    }];
}



- (void)judgeLoginRes:(NSDictionary *)obj{
    CBUser *u = [CBUser share];
    u.token = obj[@"data"][@"token"];
    [u setValuesForKeysWithDictionary:obj[@"data"][@"user"]];
    [u save];
    [[Httprequest share].manager.requestSerializer setValue:[CBUser share].token forHTTPHeaderField:@"Marriage-Love-Token"];
    [[Httprequest share].manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Marriage-Love-Device-Type"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginEM" object:u.uid];
    
    [self presentViewController:[[CBBaseTabbarVc alloc]init] animated:YES completion:nil];
}
@end
