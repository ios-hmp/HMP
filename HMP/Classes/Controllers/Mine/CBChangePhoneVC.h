//
//  CBChangePhoneVC.h
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBChangePhoneVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UILabel *oldPhoneLab;
@property (weak, nonatomic) IBOutlet UITextField *oldCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *getOldCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *nePhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *nCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *getNewCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *changePhoneBtn;
- (IBAction)getOldPhoneCodeAction:(UIButton *)sender;
- (IBAction)getNewPhoneCodeAction:(UIButton *)sender;
- (IBAction)changePhoneAction:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
