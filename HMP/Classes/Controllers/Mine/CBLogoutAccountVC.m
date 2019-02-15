//
//  CBLogoutAccountVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBLogoutAccountVC.h"

@interface CBLogoutAccountVC ()

@end

@implementation CBLogoutAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注销账号";
    self.logoutBtn.layer.shadowColor = self.logoutBtn.backgroundColor.CGColor;

    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getCodeBtnAction:(UIButton *)sender {
}
- (IBAction)logouBtnAction:(UIButton *)sender {
}
@end
