//
//  CBMineVc.m
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBMineVc.h"

@interface CBMineVc ()
{
    NSArray *iconNameArr;
    NSArray *leftTitleArr;
    NSArray *rightTitleArr;
    NSArray *classVCNameArr;
}
@end

@implementation CBMineVc

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    iconNameArr = @[@"icon_mine_grzl",@"icon_mine_zoyq",@"icon_mine_hljy",@"icon_mine_xc",@"icon_mine_myxs",@"icon_mine_zhsz",@"icon_mine_ts",@"icon_mine_share",@"icon_mine_zhsz"];
    leftTitleArr = @[@"个人资料",@"择偶要求",@"婚恋寄语",@"相册",@"密语信使",@"黑名单",@"我的投诉",@"分享",@"账号设置"];
    rightTitleArr = @[@"完善资料让他/她更懂您",@"期待这样的他/她",@"我的婚恋价值观",@"展示我的风采",@"看看他们/她们都怎么回答",@"我不喜欢",@"被投诉多了可能要封号哟",@"",@""];
    classVCNameArr = @[@"CBMarryMessageVC",@"CBMarryMessageVC",@"CBMarryMessageVC",@"CBPhotoListVC",@"CBMarryMessageVC",@"CBBlacklistVC",@"CBMarryMessageVC",@"CBMarryMessageVC",@"CBMarryMessageVC",];
    _mineTabView.tableHeaderView = _tabHeadView;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return iconNameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTabCell"];
    cell.iconImgView.image = [UIImage imageNamed:iconNameArr[indexPath.row]];
    cell.leftLab.text = leftTitleArr[indexPath.row];
    cell.rightLab.text = rightTitleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_mineTabView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc =[AppManager getVCInBoard:@"Mine" ID:classVCNameArr[indexPath.row]];
    PUSH(vc);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
@implementation MineTabCell

@end
