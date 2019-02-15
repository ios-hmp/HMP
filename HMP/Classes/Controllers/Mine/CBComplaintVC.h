//
//  CBComplaintVC.h
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBComplaintTabCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;

@end

@interface CBComplaintVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIButton *titleLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *titleRightBtn;
@property (weak, nonatomic) IBOutlet UIView *titleLineView;
- (IBAction)titleAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
