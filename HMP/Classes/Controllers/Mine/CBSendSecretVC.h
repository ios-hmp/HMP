//
//  CBSendSecretVC.h
//  HMP
//
//  Created by Jason_zyl on 2019/2/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBSendSecretVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *sendScrectBtn;
- (IBAction)sendScrectAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@end

NS_ASSUME_NONNULL_END
