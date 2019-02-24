//
//  CBSearchInputVc.h
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBSearchInputVc : CBBaseVc
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *search;
- (IBAction)searchAct:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *nick;
@property (weak, nonatomic) IBOutlet UIImageView *samllHead;
@property (weak, nonatomic) IBOutlet UIImageView *vip;
@property (weak, nonatomic) IBOutlet UIButton *ziliao;
- (IBAction)ziliaoAct:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *qmd;
@property (weak, nonatomic) IBOutlet UILabel *star;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *pageLable;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *bigHead;
@property (weak, nonatomic) IBOutlet UILabel *seerrLable;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UIView *searchNoResultView;
- (IBAction)addAct:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *resPersonView;

- (IBAction)tousu:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *extView;

@property (strong, nonatomic) IBOutlet UIView *loveView;
@property (weak, nonatomic) IBOutlet UIImageView *love1;
@property (weak, nonatomic) IBOutlet UIImageView *love2;

@property (nonatomic,assign)BOOL isShow;//资料展示页面
@property (nonatomic,assign)BOOL isAddFr;//添加朋友
@property (weak, nonatomic) IBOutlet UILabel *req_msg;
@property (weak, nonatomic) IBOutlet UIButton *jujue;
@property (weak, nonatomic) IBOutlet UIButton *agree;
- (IBAction)agreeFriends:(UIButton *)sender;
@property (nonatomic,strong)NSDictionary *applyInfo;
@end

NS_ASSUME_NONNULL_END
