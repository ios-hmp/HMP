//
//  CBBlackOperateVC.h
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBBlackOperateVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *useVipImgView;
@property (weak, nonatomic) IBOutlet UIButton *removeBlackBtn;
@property (weak, nonatomic) IBOutlet UIButton *addFriendBtn;
- (IBAction)removeBlackAction:(UIButton *)sender;
- (IBAction)addFriendAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headWConstraint;

@end

NS_ASSUME_NONNULL_END
