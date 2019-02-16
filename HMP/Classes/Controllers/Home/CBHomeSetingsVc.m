//
//  CBHomeSetings.m
//  HMP
//
//  Created by hcb on 2019/2/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBHomeSetingsVc.h"
#import "CBTableViewDataSource.h"
#import "CBHomeSettings.h"
#import "CBCusService.h"

@interface CBHomeSetingsVc ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation CBHomeSetingsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
   self.tableDatas = [@[
               @{@"text":@"公司简介",@"ind":@"1",},
               @{@"text":@"消息提示音",@"ind":@"0",},
               @{@"text":@"使用协议",@"ind":@"1",},
               @{@"text":@"使用说明",@"ind":@"1",},
               @{@"text":@"客服",@"ind":@"1",},
               @{@"text":@"版本检测",@"ind":@"1",},
               ] mutableCopy];
    self.tableview.mj_header = nil;
    [self.tableview registerNib:[UINib nibWithNibName:@"CBHomeSettings" bundle:nil] forCellReuseIdentifier:@"st"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CBHomeSettings *cell = [tableView dequeueReusableCellWithIdentifier:@"st"];
    cell.name.text = self.tableDatas[indexPath.row][@"text"];
    cell.sw.hidden = [self.tableDatas[indexPath.row][@"ind"] integerValue];
    cell.ind.hidden = !cell.sw.hidden;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            CBWebVc *web = [[CBWebVc alloc]init];
            web.title = @"公司简介";
            web.url = [NSURL URLWithString:@"http://love.test2.yikeapp.cn/html/single_article/4.html"];
            SHOW(web);
        }
            break;
        case 2:
        {
            CBWebVc *web = [[CBWebVc alloc]init];
            web.title = @"使用协议";
            web.url = [NSURL URLWithString:@"http://love.test2.yikeapp.cn/html/single_article/2.html"];
            SHOW(web);
        }
            break;
        case 3:
        {
            CBWebVc *web = [[CBWebVc alloc]init];
            web.title = @"使用说明";
            web.url = [NSURL URLWithString:@"http://love.test2.yikeapp.cn/html/single_article/3.html"];
            SHOW(web);
        }
            break;
        case 4:
        {
            CBCusService *vc = (CBCusService *)[AppManager getVCInBoard:@"Main" ID:@"CBCusService"];
            PUSH(vc);
        }
            break;
        case 5:
        {
            [CBFastUI showAlert:@"已是最新版本" content:@"" btns:@[@"确定"] callBack:^(NSString * _Nonnull title) {
                
            }];
        }
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}
@end
