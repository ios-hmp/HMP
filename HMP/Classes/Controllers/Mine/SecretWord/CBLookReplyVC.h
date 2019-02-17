//
//  CBLookReplyVC.h
//  HMP
//
//  Created by Jason_zyl on 2019/2/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBLookReplyVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UIView *headTabView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end
@interface CBLookReplyTabCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWConstraint;

@end
NS_ASSUME_NONNULL_END
