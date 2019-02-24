//
//  CBAddFrCell.h
//  HMP
//
//  Created by hcb on 2019/2/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBAddFrCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLable;
@property (weak, nonatomic) IBOutlet UILabel *expired;
@property (weak, nonatomic) IBOutlet UIButton *see;
@end

NS_ASSUME_NONNULL_END
