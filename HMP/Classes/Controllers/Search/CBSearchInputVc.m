//
//  CBSearchInputVc.m
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBSearchInputVc.h"
#import "SDCycleScrollView.h"
#import "CBApplyInputVc.h"
#import "CBSendSecretVC.h"
#import "CBAddComplaint.h"

@interface CBSearchInputVc ()<SDCycleScrollViewDelegate>
{
    NSDictionary *cur_res;
    UIView *extBgView;
}

@end

@implementation CBSearchInputVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    NSDictionary *res = @{
                          @"id": @6,
                          @"user_nickname": @"坏小子1",
                          @"name": @"郭学文1",
                          @"constellation": @5,
                          @"end_trial_time": @1550042457,
                          @"end_member_time": @0,
                          @"end_vip_member_time": @0,
                          @"avatar": @"",
                          @"age":@28,
                          @"level": @1,
                          @"photos": @[
                                  @"http://love.test2.yikeapp.cn/upload/20190114/8809e066772d54a93792f2bb97b291a8.jpg",
                                  @"http://love.test2.yikeapp.cn/upload/20190114/8809e066772d54a93792f2bb97b291a8.jpg",
                                  @"http://love.test2.yikeapp.cn/upload/20190114/8809e066772d54a93792f2bb97b291a8.jpg"
                                  ],
                          @"work_nature": @"固定",
                          @"match_percent": @0
                          };
    cur_res = res;
    if (self.isShow) {
//        CBInfowShow id
        self.title = @"资料展示";
        //右上角按钮
//        UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
        UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
        b.title = @"···";
        [b addTarget:self action:@selector(showExt) forControlEvents:UIControlEventTouchUpInside];
        b.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
//        UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithTitle:@"···" style:UIBarButtonItemStylePlain target:self action:@selector(showExt)];
        UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithCustomView:b];
        self.navigationItem.rightBarButtonItem = item3;
        
        for (int i=0; i<self.extView.subviews.count; i++) {
            UIView *view = self.extView.subviews[i];
            if ([view isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)view;
                btn.contentEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0);
            }
        }
        
        [self updateInfo];
        
    }

}

-(void)showLoveUI{
    self.love1.layer.borderColor = [UIColor whiteColor].CGColor;
    self.love2.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:self.loveView];
    self.loveView.frame = self.view.frame;
}

-(void)showExt{
    if (!extBgView) {
        extBgView = [[UIView alloc]initWithFrame:self.view.frame];
        extBgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self.view addSubview:extBgView];
        self.extView.top = kNavBarH;
        self.extView.right =  SWIDTH - 15;
        [extBgView addSubview:self.extView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView:)];
        [extBgView addGestureRecognizer:tap];
    }else{
        extBgView.hidden = NO;
    }
}

-(void)removeView:(UITapGestureRecognizer *)tap{
    extBgView.hidden = YES;
}

-(void)viewDidLayoutSubviews{
    [CBFastUI addGradintBg:self.add];
    [CBFastUI addGradintBg:self.search];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchAct:(UIButton *)sender {
    if (_phone.text.length<5) {
        [LoadingView showAMessage:@"请输入正确手机号"];
        return;
    }
    [self.view endEditing:YES];
    NSString *url = @"user/list/search";
    
    NSDictionary *par = @{
                          @"phone":_phone.text,
                          };
    __weak typeof(self) weakSelf = self;
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        NSString *msg = obj[@"msg"];
        //模拟数据
        self.searchNoResultView.hidden = YES;
#warning to do
        NSDictionary *res = cur_res;
        if (ISDIC(res)) {
            self->cur_res = res;
            [weakSelf updateInfo];
        }else{
            //展示不通信息
            self.searchNoResultView.hidden = NO;
            self.seerrLable.text = msg;
        }
        if (ISSTR(msg)) {
            
        }
    } andError:^(id error) {
        
    }];
   
}

-(void)updateInfo{
    if (!cur_res) {
        return;
    }
    self.nick.text = cur_res[@"user_nickname"];
    self.star.text = [cur_res[@"age"] stringValue];
    self.age.text = cur_res[@"hyd"]?:@"";
    self.qmd.title = @"";
    self.pageLable.hidden = YES;
    self.vip.hidden = [cur_res[@"level"] integerValue]==3?0:1;//3为VIP
    [self.nick sizeToFit];
    self.vip.left = self.nick.right+5;
    self.pageControl.hidden = YES;
    NSArray *photos = cur_res[@"photos"];
    if (photos) {
        self.pageLable.hidden = NO;
        self.pageLable.text = [NSString stringWithFormat:@"%d/%ld",1,photos.count];
        [self.bigHead removeAllSubviews];
        SDCycleScrollView *bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bigHead.bounds imageURLStringsGroup:nil];
        bannerScrollView.delegate = self;
        bannerScrollView.currentPageDotColor = [UIColor darkGrayColor]; //分页控件小圆标颜色
        bannerScrollView.pageDotColor = [UIColor colorWithWhite:0.7 alpha:1.0]; //分页控件小圆标颜色
        bannerScrollView.pageControlDotSize = CGSizeMake(5, 5); //分页控件小圆标大小
        bannerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        bannerScrollView.autoScrollTimeInterval = 600000;
        bannerScrollView.backgroundColor = [UIColor colorWithRed:0.9207 green:0.9158 blue:0.9255 alpha:1.0];
        bannerScrollView.placeholderImage = [UIImage imageNamed:@"placeH"];
        bannerScrollView.imageURLStringsGroup = photos;
        bannerScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [self.bigHead addSubview:bannerScrollView];
        
    }
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.pageLable.text = [NSString stringWithFormat:@"%ld/%ld",index+1,cycleScrollView.imageURLStringsGroup.count];

}


- (IBAction)ziliaoAct:(UIButton *)sender {
    
}
- (IBAction)addAct:(UIButton *)sender {
    if (self.isShow) {
        
//        NSString *msg = @"体验期无法升级为恋人";
//        [CBFastUI showAlert:msg content:@"" btns:@[@"取消",@"成为会员"] callBack:^(NSString * _Nonnull title) {
//
//        }];
        //进入申请关系前填写承诺信息页面
        CBApplyInputVc *vc = (CBApplyInputVc *)[AppManager getVCInBoard:@"Search" ID:@"CBApplyInputVc"];
        SHOW(vc);
        return;
    }
    
    [CBFastUI showAlert:@"申请朋友关系提醒：您与对方申请成为朋友关系，然后才能发展成为好友、恋人及完成唯一的爱人关系。如果您们没有达成朋友关系，则您们会互相除名、申请时效为15天。" content:nil btns:@[@"取消",@"确定申请"] callBack:^(NSString * _Nonnull title) {
        if ([title isEqualToString:@"确定申请"]) {
            [self showApplyAlert];
        }
    }];
    
}

-(void)showApplyAlert{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"" preferredStyle:UIAlertControllerStyleAlert];
    int i = 0;
    __weak typeof(self) weakSelf = self;
    for (NSString *tit in @[@"取消",@"申请"]) {
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:tit style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([act1.title isEqualToString:@"申请"]) {
                
                [weakSelf sendApply];
            }
        }];
        [alertVc addAction:act1];
        @try {
            if (i==0) {
                [act1 setValue:[UIColor grayColor] forKey:@"titleTextColor"];
            }else{
                [act1 setValue:MainColor forKey:@"titleTextColor"];
            }
        } @catch (NSException *exception) {
            [LoadingView showAMessage:@"系统错误：100"];
        } @finally {
            
        }
        i+=1;
    }
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = [NSString stringWithFormat:@"我是%@，很高兴认识你",[CBShareAppInfo share].nickName?:@""];
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
}


-(void)sendApply{
    
}
- (IBAction)tousu:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
        {
            //投诉
            CBAddComplaint *vc = (CBAddComplaint *)[AppManager getVCInBoard:@"Search" ID:@"CBAddComplaint"];
            SHOW(vc);
        }
            break;
        case 2:
        {
            //黑名单
            
        }
            break;
        case 3:
        {
            //解除关系
            [CBFastUI showAlert:@"缴纳平台年度服务费" content:@"您将与对方解除爱人关系，达成爱人关系期间不收取费用，因为您是爱人关系申请方且主动提出解除爱人关系，您需要缴纳年度服务费后，才能使用平台功能，然后从爱人关系解除之日重新计算收费周期。" btns:@[@"不同意",@"同意"] callBack:^(NSString * _Nonnull title) {
                if ([title isEqualToString:@"同意"]) {
                    [CBFastUI showAlert:@"您正在与****解除关系，请确认" content:@"" btns:@[@"不解除",@"确认解除"] callBack:^(NSString * _Nonnull title) {
                       
                    }];
                }
            }];
        }
            break;
        case 4:
        {
            //发送密语
            CBSendSecretVC *vc = (CBSendSecretVC *)[AppManager getVCInBoard:@"Mine" ID:@"CBSendSecretVC"];
            SHOW(vc);
        }
            break;
            
        default:
            break;
    }
    extBgView.hidden = YES;
}
@end
