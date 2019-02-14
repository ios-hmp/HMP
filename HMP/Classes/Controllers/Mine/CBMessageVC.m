//
//  CBMessageVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBMessageVC.h"

@interface CBMessageVC ()

@end

@implementation CBMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTabCell"];
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

@implementation MessageTabCell

@end
