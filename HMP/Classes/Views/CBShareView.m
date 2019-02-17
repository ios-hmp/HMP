//
//  CBShareView.m
//  HMP
//
//  Created by Jason_zyl on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBShareView.h"

@interface CBShareView ()
{
    UIView *bgView; //模糊弹框背景视图
}

@end

@implementation CBShareView

-(instancetype)initWithFrame:(CGRect)frame {
    CGRect frames = CGRectMake(0, 0, CB_SCREENWIDTH, CB_SCREENHIGH);
  self =  [super initWithFrame:frames];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-170, self.width , 170)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
    CGFloat workSpace = 40;
    CGFloat btnWidth = (self.width-workSpace*3)/2.0;
    
    UIButton *wxFriendBtn = [[UIButton alloc] initWithFrame:CGRectMake(workSpace,0, btnWidth, bgView.height-70)];
    [wxFriendBtn setTitle:@"分享给好友" forState:UIControlStateNormal];
    wxFriendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [wxFriendBtn addTarget:self action:@selector(shareFriendsAction) forControlEvents:UIControlEventTouchUpInside];
    wxFriendBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [wxFriendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    wxFriendBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
    [bgView addSubview:wxFriendBtn];
    
    UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, wxFriendBtn.width, wxFriendBtn.height-30)];
    imgView1.image = [UIImage imageNamed:@"share_wechat"];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    [wxFriendBtn addSubview:imgView1];
    
    UIButton *wxFriendTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(workSpace+wxFriendBtn.right,0, btnWidth, bgView.height-70)];
    [wxFriendTimeBtn setTitle:@"分享到朋友圈" forState:UIControlStateNormal];
    wxFriendTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [wxFriendTimeBtn addTarget:self action:@selector(shareFriendsCircleAction) forControlEvents:UIControlEventTouchUpInside];
    wxFriendTimeBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [wxFriendTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    wxFriendTimeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
    [bgView addSubview:wxFriendTimeBtn];
    
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, wxFriendBtn.width, wxFriendBtn.height-30)];
    imgView2.image = [UIImage imageNamed:@"share_circle"];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    [wxFriendTimeBtn addSubview:imgView2];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, wxFriendBtn.bottom+20, self.width, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgView addSubview:lineView];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,lineView.bottom, self.width, bgView.height-(lineView.bottom))];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font =wxFriendTimeBtn.titleLabel.font;
    [cancleBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bgView addSubview:cancleBtn];
    
}

- (void)shareFriendsAction {
    if (_shareFriendBlock) {
        _shareFriendBlock();
    }
    [self cancleAction];
}

- (void)shareFriendsCircleAction {
    if (_shareFriendCircleBlock) {
        _shareFriendCircleBlock();
    }
    [self cancleAction];
}

- (void)cancleAction {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf removeAllSubviews];
        [weakSelf removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
