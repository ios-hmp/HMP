
//
//  CBAddFrVc.m
//  HMP
//
//  Created by hcb on 2019/2/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBAddFrVc.h"
#import "CBAddFrCell.h"
#import "CBSearchInputVc.h"

@interface CBAddFrVc ()

@end

@implementation CBAddFrVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加朋友";
    // Do any additional setup after loading the view.
    [self.tableview registerNib:[UINib nibWithNibName:@"CBAddFrCell" bundle:nil] forCellReuseIdentifier:@"frcell"];
}

- (void)loadNetData{
    
    [CBBaseModel request:@"friends/index/applyList" par:@{@"page":@(1)} callback:^(id  _Nonnull data, NSString * _Nonnull msg) {
        if (data) {
            [self.tableDatas addObjectsFromArray:data[@"list"]];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBAddFrCell *cell = [tableView dequeueReusableCellWithIdentifier:@"frcell"];
    NSDictionary *info = self.tableDatas[indexPath.row];
    [cell.avatarIV sd_setImageWithURL: [NSURL URLWithString:info[@"avatar"]]];
    cell.nameLabel.text = info[@"name"]?:@"";
    cell.infoLable.text = info[@"req_message"]?:@"";
    NSInteger st = [info[@"status"] integerValue];
    
    [cell.see addTarget:self action:@selector(see:) forControlEvents:UIControlEventTouchUpInside];
    [CBFastUI addGradintBg:cell.see];
    if (st==1) {
        cell.see.hidden = NO;
        cell.expired.hidden = YES;
    }else{
        cell.see.hidden = YES;
        cell.expired.hidden = NO;
    }
    return cell;
}

- (void)see:(UIButton *)btn{
    NSIndexPath *indexPath = [self.tableview indexPathForCell:btn.superview.superview.superview];
    NSDictionary *info = self.tableDatas[indexPath.row];
    CBSearchInputVc *vc = (CBSearchInputVc *)[AppManager getVCInBoard:@"Search" ID:@"CBFRREQ"];
    vc.isAddFr = YES;
    vc.applyInfo = info;
    SHOW(vc);

}
@end
