//
//  CBComplaintVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBComplaintVC.h"

@interface CBComplaintVC ()

@end

@implementation CBComplaintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    //设置预估行高
    self.tableview.estimatedRowHeight = 100.0f;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _titleView.top = 0;
    _titleView.centerX = CB_SCREENWIDTH/2.0;
    [self.navigationController.navigationBar addSubview:_titleView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_titleView removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CBComplaintTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CBComplaintTabCell"];
    cell.statusBtn.layer.shadowColor = cell.statusBtn.backgroundColor.CGColor;
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)titleAction:(UIButton *)sender {
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
}
@end
@implementation CBComplaintTabCell

@end
