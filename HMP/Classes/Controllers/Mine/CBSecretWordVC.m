//
//  CBSecretWordVC.m
//  HMP
//
//  Created by Jason_zyl on 2019/2/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBSecretWordVC.h"
#import "CBMessageVC.h"

@interface CBSecretWordVC ()

@end

@implementation CBSecretWordVC

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
        return cell;
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
