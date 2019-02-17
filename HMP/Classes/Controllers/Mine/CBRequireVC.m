//
//  CBRequireVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBRequireVC.h"

@interface CBRequireVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArr;
}
@end

@implementation CBRequireVC

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArr = @[@"结婚安居地区",@"",@"民族",@"宗教",@"最低学历要求",@"婚姻情况",@"入赘要求",@"收入范围",@"吸烟情况",@"彩礼情况",@"身高"];
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarH, CB_SCREENWIDTH, CB_SCREENHIGH-kNavBarH)];
    [self.view addSubview:_bgScrollView];
    [_bgScrollView addSubview:self.myTabView];
    _bgScrollView.contentSize = CGSizeMake(0, MAX(self.myTabView.height+40, _bgScrollView.height+1));
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==1) {
        CBRequireTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CBRequireTabCell2"];
        return cell;
    }
    else {
        CBRequireTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CBRequireTabCell1"];
        cell.titleLab.text = titleArr[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
@implementation CBRequireTabCell

@end
