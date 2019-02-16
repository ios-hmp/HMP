//
//  CBHomeSettings.h
//  HMP
//
//  Created by hcb on 2019/2/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBHomeSettings : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *ind;
@property (weak, nonatomic) IBOutlet UISwitch *sw;
@end

NS_ASSUME_NONNULL_END
