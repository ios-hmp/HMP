//
//  CBBaseVc.m
//  CBWorkFlow
//
//  Created by hcb on 2018/12/22.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CBBaseVc.h"
#import "CBBaseModel.h"

@interface CBBaseVc ()
{
    BOOL hasConfigUI;
}
@end

@implementation CBBaseVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //只显示图片
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"backh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];

   
    if (self.tableview) {
        __weak typeof(self) weakSelf = self;
        self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.isrefresh = YES;
            [weakSelf loadNetData];
            self.isrefresh = NO;
        }];
        
        self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadNetData];
        }];
        self.tableview.tableFooterView = [[UIView alloc]init];

    }
    [self loadNetData];
}

-(void)viewDidLayoutSubviews{
    if (!hasConfigUI) {
        hasConfigUI = YES;
        [self configUI];
    }
}
- (void)loadNetData{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSMutableArray *)tableDatas{
    if (!_tableDatas) {
        _tableDatas = [NSMutableArray array];
    }
    return _tableDatas;
}

- (NSMutableArray *)subDatas{
    if (!_subDatas) {
        _subDatas = [NSMutableArray array];
    }
    return _subDatas;
}

-(void)dealloc{
    NSLog(@"释放了--%@",self.class);
}

-(void)configUI{
    
}
@end
