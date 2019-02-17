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


@property (nonatomic,assign)BOOL isShow;//资料展示页面
@end

NS_ASSUME_NONNULL_END
