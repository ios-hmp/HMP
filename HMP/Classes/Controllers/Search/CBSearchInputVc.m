//
//  CBSearchInputVc.m
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBSearchInputVc.h"

@interface CBSearchInputVc ()

@end

@implementation CBSearchInputVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    // Do any additional setup after loading the view.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [CBFastUI addGradintBg:self.add];
//        [CBFastUI addGradintBg:self.search];
//    });

}

-(void)viewDidLayoutSubviews{
    [CBFastUI addGradintBg:self.add];
    [CBFastUI addGradintBg:self.search];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchAct:(UIButton *)sender {
}
- (IBAction)ziliaoAct:(UIButton *)sender {
}
- (IBAction)addAct:(UIButton *)sender {

    [CBFastUI showAlert:@"申请朋友关系提醒：您与对方申请成为朋友关系，然后才能发展成为好友、恋人及完成唯一的爱人关系。如果您们没有达成朋友关系，则您们会互相除名、申请时效为15天。" content:nil btns:@[@"取消",@"确定申请"] callBack:^(NSString * _Nonnull title) {
        if ([title isEqualToString:@"确定申请"]) {
            [self showApplyAlert];
        }
    }];
    
}

-(void)showApplyAlert{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"" preferredStyle:UIAlertControllerStyleAlert];
    int i = 0;
    __weak typeof(self) weakSelf = self;
    for (NSString *tit in @[@"取消",@"申请"]) {
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:tit style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([act1.title isEqualToString:@"申请"]) {
                
                [weakSelf sendApply];
            }
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
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = [NSString stringWithFormat:@"我是%@，很高兴认识你",[CBShareAppInfo share].nickName?:@""];
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
}


-(void)sendApply{
    
}
@end
