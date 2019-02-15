//
//  CBBaseInfoVc.m
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseInfoVc.h"
#import "CBBaseTabbarVc.h"


@interface CBBaseInfoVc ()
{
    NSInteger utype;
    BOOL needNoSameSex;
}
@end

@implementation CBBaseInfoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [CBFastUI addGradintBg:self.sureBtn];
    utype = 1;
    needNoSameSex = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sureAction:(UIButton *)sender {
    if (_nickNameField.text.length<2) {
        [LoadingView showAMessage:@"请输入昵称"];
        return;
    }
    NSString *url = @"user/profile/completeInfo";
    
    
    NSDictionary *par = @{
                          @"user_nickname":_nickNameField.text,
                          @"sex":@(_man.selected),
                          @"user_type":@(utype),
                          @"accept_opposite_sex":@(needNoSameSex),
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        
    } andError:^(id error) {
        
    }];
    if (!self.isFromSearch) {
        CBBaseTabbarVc *vc = [[CBBaseTabbarVc alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        POP;
    }
}

- (IBAction)userTypeAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    if (sender.tag==3) {
        [CBFastUI showAlert:@"是否需要异性婚姻推荐服务" content:@"(我们将把同性用户中的具有相同婚姻需求的异性用户推荐给您，以避免对普通用户的干扰)" btns:@[@"需要",@"不需要"] callBack:^(NSString * _Nonnull title) {
            NSLog(@"点击了：%@",title);
            if ([title isEqualToString:@"需要"]) {
                self->needNoSameSex = YES;
            }
        }];
    }
    self.normalUser.selected = NO;
    self.sexUser.selected = NO;
    self.nochildUser.selected = NO;
    self.specialUser.selected = NO;
    sender.selected = YES;
    utype = sender.tag;
    needNoSameSex = NO;
}

- (IBAction)sexAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    self.man.selected = NO;
    self.woman.selected = NO;
    sender.selected = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
@end
