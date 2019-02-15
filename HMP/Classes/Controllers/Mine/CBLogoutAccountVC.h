//
//  CBLogoutAccountVC.h
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBLogoutAccountVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
- (IBAction)getCodeBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *logoutTipsLab;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
- (IBAction)logouBtnAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
