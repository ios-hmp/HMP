//
//  CBBlackOperateVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBlackOperateVC.h"

// 多少列
#define CB_BRANDSECTION 3.01
// 列表间隔距离
#define CB_BRANDDEV 10
// cell宽度
#define CB_LIST1CELLWIDTH ((CB_SCREENWIDTH - (CB_BRANDSECTION + 1)*CB_BRANDDEV) / CB_BRANDSECTION)


@interface CBBlackOperateVC ()

@end

@implementation CBBlackOperateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [CBFastUI addRoundCornerAnBorder:self.removeBlackBtn];
    _headWConstraint.constant = CB_LIST1CELLWIDTH*0.8;
    _headImgView.layer.cornerRadius = CB_LIST1CELLWIDTH*0.4;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [CBFastUI addGradintBg:self.addFriendBtn];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)removeBlackAction:(UIButton *)sender {
}

- (IBAction)addFriendAction:(UIButton *)sender {
}
@end
