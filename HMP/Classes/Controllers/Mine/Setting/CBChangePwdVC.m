//
//  CBChangePwdVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBChangePwdVC.h"

@interface CBChangePwdVC ()

@end

@implementation CBChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [CBFastUI addGradintBg:self.changePwdBtn];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changePwdAction:(UIButton *)sender {
}
@end
