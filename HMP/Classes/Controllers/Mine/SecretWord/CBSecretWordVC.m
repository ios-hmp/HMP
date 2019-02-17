//
//  CBSecretWordVC.m
//  HMP
//
//  Created by Jason_zyl on 2019/2/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBSecretWordVC.h"
#import "CBMessageVC.h"

@interface CBSecretWordVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CBSecretWordVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    _titleView.top = 0;
    _titleView.centerX = CB_SCREENWIDTH/2.0;
    [self.navigationController.navigationBar addSubview:_titleView];
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.titleView.alpha = 1.0;
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.titleView.alpha = 0.0;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    // Do any additional setup after loading the view.
}

-(void)configUI{
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:_navRightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.titleLeftBtn.selected) {
        MessageTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"screctTabCell1"];
        return cell;
    }
    else {
        SecretTabCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"SecretTabCell2"];
        if (indexPath.row%2==0) {
            cell.stateLab.text = @"回复";
        }else {
            cell.stateLab.text = @"已回复";
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.titleLeftBtn.selected) {
        UIViewController *vc = [AppManager getVCInBoard:@"Mine" ID:@"CBLookReplyVC"];
        PUSH(vc);
    }else {
        if (indexPath.row%2==0) {
            UIViewController *vc = [AppManager getVCInBoard:@"Mine" ID:@"CBReplySecretWordVC"];
            PUSH(vc);
        }else {
            UIViewController *vc = [AppManager getVCInBoard:@"Mine" ID:@"CBLookMineReplyVC"];
            PUSH(vc);
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)titleBtnAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    sender.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.titleLineView.centerX = sender.centerX;
        if ([sender isEqual:weakSelf.titleLeftBtn]) {
            weakSelf.titleRightBtn.selected = NO;
        }
        else {
            weakSelf.titleLeftBtn.selected = NO;
        }
    }];
    [self.tableview reloadData];
}
@end
@implementation SecretTabCell2

@end
