//
//  CBChangePhoneVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBChangePhoneVC.h"

@interface CBChangePhoneVC ()

@end

@implementation CBChangePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换手机号";
    }

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [CBFastUI addGradintBg:self.changePhoneBtn];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getOldPhoneCodeAction:(UIButton *)sender {
}
- (IBAction)getNewPhoneCodeAction:(UIButton *)sender {
}
- (IBAction)changePhoneAction:(UIButton *)sender {
}
@end
