//
//  CBBlackOperateVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBlackOperateVC.h"

@interface CBBlackOperateVC ()

@end

@implementation CBBlackOperateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [CBFastUI addRoundCornerAnBorder:self.removeBlackBtn];
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
