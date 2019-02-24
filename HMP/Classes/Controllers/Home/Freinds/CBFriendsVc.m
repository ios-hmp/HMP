//
//  CBFriendsVc.m
//  HMP
//
//  Created by hcb on 2019/2/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBFriendsVc.h"
#import "FriendCell.h"
#import "GroupModel.h"
#import <objc/runtime.h>
char* const buttonKey = "buttonKey";



#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface CBFriendsVc ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView     *expandTable;
    NSMutableArray  *dataSource;
    
}

@end

@implementation CBFriendsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataSource];
    [self initTable];
    self.tableview = expandTable;
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
    self.tableview.backgroundColor = [UIColor clearColor];
}

- (void)initDataSource
{
//
    NSString *url = @"friends/index/friendList";
    dataSource = [[NSMutableArray alloc]init];
    [CBBaseModel request:url par:nil callback:^(id data, NSString *msg) {
        if (data) {
            self->dataSource = [GroupModel mj_objectArrayWithKeyValuesArray:data];
        }
    }];
}

-(void)initTable{
    expandTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    expandTable.dataSource = self;
    expandTable.delegate =  self;
    expandTable.rowHeight = UITableViewAutomaticDimension;
    expandTable.estimatedRowHeight = 81;
    expandTable.tableFooterView = [UIView new];
    
    [expandTable registerNib:[UINib nibWithNibName:@"FriendCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:expandTable];
}

#pragma mark -
#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GroupModel *groupModel = dataSource[section];
    NSInteger count = groupModel.isOpened?groupModel.friend_list.count:0;
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    GroupModel *groupModel = dataSource[indexPath.section];
    CBFriends *fr = groupModel.friend_list[indexPath.row];
    cell.nameLabel.text = fr.name;
    [cell.avatarIV sd_setImageWithURL:[NSURL URLWithString:fr.avatar?:@""]];
    [cell.qmd setTitle:fr.intimacy?:@"--" forState:UIControlStateNormal];
    [cell.hyd setTitle:fr.matching_rate?:@"--" forState:UIControlStateNormal];
    cell.star.text = fr.constellation?:@"--";
    cell.vip.hidden = fr.vip;
    [cell.nameLabel sizeToFit];
    cell.vip.left = cell.nameLabel.right+5;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    int top = 0;
    if (section==0) {
        top = 35;
    }
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60+top)];
    sectionView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];

    GroupModel *groupModel = dataSource[section];
    if (section==0) {
        sectionView.backgroundColor = [UIColor whiteColor];
        if (![CBUser share].needExchange) {
            
            //添加切换按钮
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
            [button setImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
            [sectionView addSubview:button];
            button.top = 12;
            button.right = sectionView.width - 10;
        }
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:sectionView.bounds];
    button.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    button.top = 10+top;
    button.height = 50;
    [button setTag:section];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:groupModel.grop_name forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 27, 0, 0)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:button];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-1, button.frame.size.width, 1)];
    [line setImage:[UIImage imageNamed:@"line_real"]];
    [sectionView addSubview:line];
    if (groupModel.isOpened) {
        UIImageView * _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, button.top + (50-13)/2, 7, 13)];
        [_imgView setImage:[UIImage imageNamed:@"arrow_close"]];
        [sectionView addSubview:_imgView];
        CGAffineTransform currentTransform = _imgView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2); // 在现在的基础上旋转指定角度
        _imgView.transform = newTransform;
        objc_setAssociatedObject(button, buttonKey, _imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }else{
        UIImageView * _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10,  button.top + (50-13)/2, 7, 13)];
        [_imgView setImage:[UIImage imageNamed:@"arrow_close"]];
        [sectionView addSubview:_imgView];
        objc_setAssociatedObject(button, buttonKey, _imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    //有爱人以后，组右侧显示加锁

    
    return sectionView;
}
#pragma mark
#pragma mark  -select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupModel *groupModel = dataSource[indexPath.section];
    CBFriends *friendInfoDic = groupModel.friend_list[indexPath.row];
}

- (void)buttonPress:(UIButton *)sender//headButton点击
{
    GroupModel *groupModel = dataSource[sender.tag];
    UIImageView *imageView =  objc_getAssociatedObject(sender,buttonKey);
    
    
    if (groupModel.isOpened) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
            CGAffineTransform currentTransform = imageView.transform;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, -M_PI/2); // 在现在的基础上旋转指定角度
            imageView.transform = newTransform;
            
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
        
    }else{
        
        [UIView animateWithDuration:0.3 delay:0.0 options: UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionCurveLinear animations:^{
            
            CGAffineTransform currentTransform = imageView.transform;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2); // 在现在的基础上旋转指定角度
            imageView.transform = newTransform;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    groupModel.isOpened = !groupModel.isOpened;
    
    [expandTable reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    int top = 0;
    if (section==0) {
        top = 35;
    }
    return 60+top;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        GroupModel *groupModel = dataSource[indexPath.section];
        CBFriends *friendInfoDic = groupModel.friend_list[indexPath.row];
        [self deleteFriends:friendInfoDic.uid];
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


- (void)deleteFriends:(NSString *)uid{
    [CBBaseModel request:@"friends/index/delFriend" par:@{@"uid":uid} callback:^(id  _Nonnull data, NSString * _Nonnull msg) {
        [LoadingView showAMessage:msg];
    }];
}
@end

