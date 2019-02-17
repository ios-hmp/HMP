//
//  CBReplySecretWordVC.h
//  HMP
//
//  Created by Jason_zyl on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBReplySecretWordVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UITextView *replyContentTV;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
- (IBAction)replyBtnAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
