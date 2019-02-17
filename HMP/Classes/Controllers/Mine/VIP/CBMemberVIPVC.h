//
//  CBMemberVIPVC.h
//  HMP
//
//  Created by zhanbing han on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBMemberVIPVC : CBBaseVc
/** VCtype  0:会员介绍 1:我的  */
@property (nonatomic,assign) NSInteger meVipType;
@property (weak, nonatomic) IBOutlet UIView *tabHeadView;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHcontraint;
@end

NS_ASSUME_NONNULL_END
