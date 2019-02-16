//
//  CBSecretWordVC.h
//  HMP
//
//  Created by Jason_zyl on 2019/2/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN
@interface CBSecretWordVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIButton *titleLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *titleRightBtn;
@property (weak, nonatomic) IBOutlet UIButton *navRightBtn;

- (IBAction)titleBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *titleLineView;
@end
@interface SecretTabCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;

@end
NS_ASSUME_NONNULL_END
