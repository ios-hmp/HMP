//
//  CBHomeVc.h
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBHomeVc : CBBaseVc
//信息UI
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UILabel *msgLable;
@property (weak, nonatomic) IBOutlet UIButton *msgBtn;
@property (weak, nonatomic) IBOutlet UIView *indicateView;
@property (weak, nonatomic) IBOutlet UIButton *hunlianquanBtn;
@property (weak, nonatomic) IBOutlet UIButton *askBtn;
- (IBAction)askAction:(UIButton *)sender;

//问答UI
@property (weak, nonatomic) IBOutlet UIView *askTop;
@property (weak, nonatomic) IBOutlet UIView *askBottom;
@property (weak, nonatomic) IBOutlet UIImageView *askImage;
@property (weak, nonatomic) IBOutlet UILabel *askTitle;
@property (weak, nonatomic) IBOutlet UIButton *askAnswerBtn;
- (IBAction)askAnswerAct:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *askCommentField;
@property (weak, nonatomic) IBOutlet UIButton *askCommentSend;
- (IBAction)askCommentSendAct:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *askTableview;
@end

@interface AskCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UILabel *nick;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *like;
@property (weak, nonatomic) IBOutlet UIButton *hate;



@end

NS_ASSUME_NONNULL_END
