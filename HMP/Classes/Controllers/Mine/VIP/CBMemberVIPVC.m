//
//  CBMemberVIPVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBMemberVIPVC.h"

#define Count 3
#define TEACHERNUM 1

@interface CBMemberVIPVC ()
{
    NSInteger count;
    NSArray *iconNameArr;
    NSArray *vipArr;
    NSArray *priceArr;
}
@end

@implementation CBMemberVIPVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员";
    // Do any additional setup after loading the view.
}

-(void)configUI {
    count = 2;
    iconNameArr = @[@"members_pt",@"members_vip"];
    vipArr = @[@"普通会员",@"VIP会员"];
    priceArr = @[@"¥500",@"¥999"];
    if (_meVipType) {
        count = 1;
    }
    CGFloat contentWidth = 0;
    CGFloat leftSpace = 15;
    for (NSInteger index = 0; index <count; index++) {
        UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"VipView" owner:self options:nil]firstObject];
        CGFloat viewWidth = CB_SCREENWIDTH-80;
        view.left = leftSpace+viewWidth*index;
        view.top = 20;
        view.width = viewWidth;
        if (count==1||_meVipType) {
            view.width = CB_SCREENWIDTH-30;
        }
        [_bgScrollView addSubview:view];
        UIImageView *bgImgView = [view viewWithTag:1000];
        bgImgView.image = [UIImage imageNamed:iconNameArr[index]];
        UILabel *vipLab = [view viewWithTag:1001];
        vipLab.text = vipArr[index];
        UILabel *priceLab = [view viewWithTag:1004];
        priceLab.text = priceArr[index];
        UILabel *contentLab = [view viewWithTag:1002];
        UIButton *updateBtn = [view viewWithTag:1003];
        [updateBtn setTitle:@"立即申请"];
        if (_meVipType) {
            [updateBtn setTitle:@"升级VIP"];
        }
        contentWidth = view.right;
    }
    _bgScrollView.contentSize = CGSizeMake(contentWidth+leftSpace, 0);
}

@end
