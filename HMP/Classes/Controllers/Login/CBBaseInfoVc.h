//
//  CBBaseInfoVc.h
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBBaseInfoVc : CBBaseVc
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet UIButton *man;
@property (weak, nonatomic) IBOutlet UIButton *woman;
@property (weak, nonatomic) IBOutlet UIButton *normalUser;
@property (weak, nonatomic) IBOutlet UIButton *nochildUser;
@property (weak, nonatomic) IBOutlet UIButton *sexUser;
@property (weak, nonatomic) IBOutlet UIButton *specialUser;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureAction:(UIButton *)sender;
- (IBAction)userTypeAction:(UIButton *)sender;
- (IBAction)sexAction:(UIButton *)sender;
@property (nonatomic,assign)BOOL isFromSearch;
@end

NS_ASSUME_NONNULL_END
