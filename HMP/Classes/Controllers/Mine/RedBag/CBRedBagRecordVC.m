//
//  CBRedBagRecordVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBRedBagRecordVC.h"

@interface CBRedBagRecordVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CBRedBagRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"红包记录";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CBRedBagRecordTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CBRedBagRecordTabCell"];
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

@end

@implementation CBRedBagRecordTabCell

@end
