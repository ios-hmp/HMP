//
//  CBHomeVc.m
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBHomeVc.h"
#import "CBHomeMsg.h"
#import "CBBaseInfoVc.h"
#import "SDCycleScrollView.h"


@interface CBHomeVc ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
{
    long tag;//1 2 3信息，婚恋圈，问答
    UIView *hunlianquanView;
    BOOL hasConfig;
    NSMutableArray *askTableDatas;
    NSMutableArray *slideDatas;
    NSDictionary *askDatas;
    SDCycleScrollView *bannerScrollView;
    
}
@end

@implementation AskCommentCell



@end

@implementation CBHomeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillInfo) name:@"fillInfo" object:nil];
    tag = 1;
//    [self testData];
    
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)fillInfo{
    CBBaseInfoVc *vc = (CBBaseInfoVc *)[AppManager getVCInBoard:@"Login" ID:@"CBBaseInfoVc"];
    vc.isFromSearch = YES;
    PUSH(vc);
}

- (void)loadNetData{
    //获取轮播图
    {
        NSString *url = @"/slide/index/index";
        __weak typeof(self) weakSelf = self;
        [[Httprequest share] postObjectByParameters:nil andUrl:url showLoading:NO showMsg:NO isFullUrk:NO andComplain:^(id obj) {
            if (obj[@"data"] && [obj[@"data"] isKindOfClass:NSArray.class]) {
                self->slideDatas = obj[@"data"];
                [weakSelf updateSlideView];
            }
        } andError:^(id error) {
            
        }];
    }
    //获取问答
    {
        NSString *url = @"/question/index/index";
        __weak typeof(self) weakSelf = self;
        [[Httprequest share] postObjectByParameters:nil andUrl:url showLoading:NO showMsg:NO isFullUrk:NO andComplain:^(id obj) {
            if (obj[@"data"] && [obj[@"data"] isKindOfClass:NSDictionary.class]) {
                self->askDatas = obj[@"data"];
                [weakSelf updateAskView];
            }
        } andError:^(id error) {
            
        }];
    }
    
    
    if ([self.tableview.mj_header isRefreshing]) {
        [self.tableview.mj_header endRefreshing];
    }
    if ([self.tableview.mj_footer isRefreshing]) {
        [self.tableview.mj_footer endRefreshing];
    }
    //统一处理方案
    /*
     if (self.isrefresh) {
     [self.tableDatas removeAllObjects];
     }
     if (value) {
     NSArray *new = [CBHomeMsg mj_objectArrayWithKeyValuesArray:value];
     
     [self.tableDatas addObjectsFromArray:new];
     }
     if ([self.tableview.mj_header isRefreshing]) {
     [self.tableview.mj_header endRefreshing];
     }
     if ([self.tableview.mj_footer isRefreshing]) {
     [self.tableview.mj_footer endRefreshing];
     }
     [self.tableview reloadData];
     [LoadingView stopLoading];
     
     */
}

-(void)updateAskView{
    [self.askImage sd_setImageWithURL:[NSURL URLWithString:askDatas[@"imgae"]?:@""]];
    self.askTitle.text = askDatas[@"title"];
    //获取问答回答列表
    
    NSString *url = @"/question/index/getReplyList";
    __weak typeof(self) weakSelf = self;
    [[Httprequest share] postObjectByParameters:@{@"qid":askDatas[@"id"]?:@""} andUrl:url showLoading:NO showMsg:NO isFullUrk:NO andComplain:^(id obj) {
        if (obj[@"data"] && [obj[@"data"][@"list"] isKindOfClass:NSArray.class]) {
            self->askTableDatas = obj[@"data"][@"list"];
            [weakSelf.askTableview reloadData];
        }
    } andError:^(id error) {
        
    }];
    
}
-(void)setupBanner{
    bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.topView.bounds imageURLStringsGroup:nil];
    
    bannerScrollView.delegate = self;
    bannerScrollView.currentPageDotColor = [UIColor darkGrayColor]; //分页控件小圆标颜色
    bannerScrollView.pageDotColor = [UIColor colorWithWhite:0.7 alpha:1.0]; //分页控件小圆标颜色
    bannerScrollView.pageControlDotSize = CGSizeMake(5, 5); //分页控件小圆标大小
    bannerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    bannerScrollView.autoScrollTimeInterval = 6;
    bannerScrollView.backgroundColor = [UIColor colorWithRed:0.9207 green:0.9158 blue:0.9255 alpha:1.0];
    bannerScrollView.placeholderImage = [UIImage imageNamed:@"placeH"];
    bannerScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.topView addSubview:bannerScrollView];
    
}

-(void)updateSlideView{
    NSMutableArray *urls = [NSMutableArray array];
    for (NSDictionary *obj in slideDatas) {
        NSString *img = [obj objectForKey:@"image"];
        [urls addObject:img?img:@""];
    }
    bannerScrollView.imageURLStringsGroup = urls;
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (slideDatas.count>0) {
        NSMutableArray *urls = [NSMutableArray array];
        for (NSDictionary *obj in slideDatas) {
            NSString *link = [obj objectForKey:@"url"];
            [urls addObject:link?link:@""];
        }
        NSString *clickUrl = urls[index];
        NSLog(@"%@",clickUrl);
        CBWebVc *vc = [[CBWebVc alloc]init];
        vc.url = [NSURL URLWithString:clickUrl];
        PUSH(vc);
    }
}

-(void)testAPI{
    //    [self testSendCode];
    
    //    [self testPasswordReset];
    //    [self testUser_attribute];
    
    //    [self testGetVersion];
    
    //    [self testGetNationality];
    //    [self testUsercompleteInfo];
    //    [self testSlideIndex];
    //    [self testAPI:@"user/list/index" par:nil];
    //    [self testAPI:@"user/profile/changePassword" par:@{@"old_password":@"18629450667",@"password":@"new_pwd",@"confirm_password":@"new_pwd"}];
    
    //    [self testAPI:@"user/profile/completeInfo" par:@{
    //                                                     @"user_nickname":@"猪事顺利",
    //                                                     @"sex":@0,
    //                                                     @"user_type":@2,
    //                                                     @"accept_opposite_sex":@1,
    //                                                     }];
    
    //    [self testAPI:@"/user/profile/getUserInfoBase" par:@{@"uid":@"27"}];
    
    /*
     [self testAPI:@"/user/profile/userBaseInfo" par:@{
     @"birthday":@"    是    string    用户生日",
     @"name":@"    是    string    用户姓名",
     @"user_nickname":@"    是    string    用户昵称",
     @"nationality":@"1",
     @"constellation":@"1",
     @"gf_provinces":@"1",
     @"gf_city":@"1",
     @"gf_area":@"1",
     @"cz_provinces":@"1",
     @"cz_city":@"1",
     @"cz_area":@"1",
     @"cr_provinces":@"1",
     @"cr_city":@"1",
     @"cr_area":@"1",
     @"work":@"1",
     @"work_nature":@"1",
     @"profession":@"    是    string    职业",
     @"income":@"1",
     @"max_education":@"1",
     @"top_school":@"    是    string    最高毕业学历院校",
     @"marital_status":@"1",
     @"height":@"1",
     @"body_type":@"1",
     @"blood_type":@"1",
     @"religion":@"1",
     @"physical_condition":@"1",
     @"smoking_status":@"1",
     @"fertility_status":@1,
     @"anaphylaxis":@"1状况",
     @"housing_conditions":@"1",
     @"car_status":@"1",
     @"matrilocal_residence":@1,
     @"betrothal_money":@"1",
     @"hobbies":@"    是    string    兴趣爱好,拼接",
     @"character":@"    是    string    性格,拼接",
     @"shortcomings":@"本人太优秀,找不到任何缺点"
     }];
     */
    //    [self testAPI:@"user/profile/editLoveWord" par:@{@"love_words":@"This is my love_words"}];
    //    [self testUploadOne];
    
    //    [self testAPI:@"user/profile/addPhotos" par:@{
    //                            @"pics":@[@"http://love.test2.yikeapp.cn/upload/20190213/03c0377b36a4b2bb1848b993b4cf3fd5.png"]
    //                            }];
    //    [self testAPI:@"user/profile/getPhotos" par:nil];
    [self testAPI:@"user/share/getList" par:nil];
    //    [self testAPI:@"/user/cryptolalia/send" par:@{@"rev_uids":@"5,27",@"content":@"这里是谜语内容"}];
    
    
    
}

-(void)testAPI:(NSString *)url par:(NSDictionary *)par{
    
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        
    } andError:^(id error) {
        
    }];
}


-(void)testSendCode{
    NSString *url = @"user/verification_code/send";
    
    NSDictionary *par = @{
                          @"username":@"18629450667",
                          @"is_register":@0,
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:NO showMsg:NO isFullUrk:NO andComplain:^(id obj) {
        
    } andError:^(id error) {
        
    }];
    
}



-(void)testLogin{
    NSString *url = @"user/public/login";
    
    NSDictionary *par = @{
                          @"username":@"18629450667",
                          @"password":@"18629450667",
                          @"device_type":@"ios",
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        CBUser *u = [CBUser share];
        if (ISDIC(obj) && obj[@"data"]) {
            u.token = obj[@"data"][@"token"];
            [u setValuesForKeysWithDictionary:obj[@"data"][@"user"]];
            [u save];
            [[Httprequest share].manager.requestSerializer setValue:[CBUser share].token forHTTPHeaderField:@"Marriage-Love-Token"];
            [[Httprequest share].manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Marriage-Love-Device-Type"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginEM" object:u.uid];
            
        }
    } andError:^(id error) {
        
    }];
    
}

-(void)testPasswordReset{
    NSString *url = @"user/public/passwordReset";
    
    NSDictionary *par = @{
                          @"username":@"18629450667",
                          @"password":@"18629450667",
                          @"verification_code":@"995135",
                          
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        
    } andError:^(id error) {
        
    }];
    
}


-(void)testUploadOne{
    NSString *url = @"user/upload/one";
    NSData *d = UIImageJPEGRepresentation([UIImage imageNamed:@"hate_pre"], 1.0);
    Httprequest *req = [Httprequest share];
    //    [req.manager.requestSerializer setValue:[CBUser share].token forHTTPHeaderField:@"Marriage-Love-Token"];
    //    [req.manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Marriage-Love-Device-Type"];
    
    
    [req postFileKey:@"file" file:d andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        
    } andError:^(id error) {
        
    }];
    
}

-(void)testUser_attribute{
    NSString *url = @"/user/user_attribute/index";
    NSDictionary *par = @{
                          @"id":@"1",
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        CBUser *u = [CBUser share];
        if (ISDIC(obj) && obj[@"data"]) {
            u.token = obj[@"data"][@"token"];
            [u setValuesForKeysWithDictionary:obj[@"data"][@"user"]];
            //            [self testUploadOne];
        }
    } andError:^(id error) {
        
    }];
    
}


-(void)testGetVersion{
    NSString *url = @"/user/user_attribute/getVersion";
    
    [[Httprequest share] postObjectByParameters:nil andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        CBUser *u = [CBUser share];
        if (ISDIC(obj) && obj[@"data"]) {
            u.token = obj[@"data"][@"token"];
            [u setValuesForKeysWithDictionary:obj[@"data"][@"user"]];
            //            [self testUploadOne];
        }
    } andError:^(id error) {
        
    }];
    
}


-(void)testGetNationality{
    NSString *url = @"/user/user_attribute/getNationality";
    
    [[Httprequest share] postObjectByParameters:nil andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        CBUser *u = [CBUser share];
        if (ISDIC(obj) && obj[@"data"]) {
            u.token = obj[@"data"][@"token"];
            [u setValuesForKeysWithDictionary:obj[@"data"][@"user"]];
            //            [self testUploadOne];
        }
    } andError:^(id error) {
        
    }];
    
}

-(void)testUsercompleteInfo{
    NSString *url = @"user/profile/completeInfo";
    
    
    NSDictionary *par = @{
                          @"id":@"1",
                          @"user_nickname":@"猪事顺利",
                          @"sex":@0,
                          @"user_type":@1,
                          @"accept_opposite_sex":@0,
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        
    } andError:^(id error) {
        
    }];
    
}

-(void)testSlideIndex{
    NSString *url = @"/slide/index/index";
    
    
    NSDictionary *par = @{
                          @"id":@"1",
                          @"user_nickname":@"猪事顺利",
                          @"sex":@0,
                          @"user_type":@1,
                          @"accept_opposite_sex":@0,
                          };
    [[Httprequest share] postObjectByParameters:nil andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        
    } andError:^(id error) {
        
    }];
    
}

-(void)viewDidLayoutSubviews{
    if (!hasConfig) {
        hasConfig = YES;
        [self initUI];
        [self setupBanner];
    }
}

-(void) changeTag{
    //依据TAG显示哪个视图
    self.tableview.hidden = YES;
    hunlianquanView.hidden = YES;
    self.askTableview.hidden = YES;
    if (tag==1) {
        self.tableview.hidden = NO;
    }else if (tag==2){
        hunlianquanView.hidden = NO;
    }else if (tag==3){
        self.askTableview.hidden = NO;
        [self.askTableview reloadData];
    }
}

-(void) initUI{
    //切换控制视图,添加阴影
    UIView *view = self.tagView;
    view.layer.shadowOffset = CGSizeMake(0, 4);
    view.layer.shadowRadius = 3;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.06;
    
    //问答视图
    self.askTableview.frame = self.tableview.frame;
    self.askTop.height = 50 + 56 + (SWIDTH - 32)/3.0;
    self.askTableview.top -= 40;
    self.askTableview.height += 40;
    self.askTableview.tableHeaderView = self.askTop;
    self.askTableview.tableFooterView = self.askBottom;
    self.askTableview.delegate = self;
    self.askTableview.dataSource = self;
    
    [CBFastUI addGradintBg:self.askCommentSend];
    [CBFastUI addGradintBg:self.askAnswerBtn];
    [self.view addSubview:self.askTableview];
    [self.view bringSubviewToFront:self.tagView];
    self.askTableview.estimatedRowHeight = 100;
    self.askTableview.rowHeight = UITableViewAutomaticDimension;
    self.askTableview.hidden = YES;
}

-(void)testData{
    askTableDatas = [NSMutableArray array];
    
    NSArray *arr = @[@"朋友申请",@"婚恋关系确认",@"降级确认",@"婚恋关系限额提现",@"收费预警",@"其他"];
    NSArray *arr1 = @[@"icon_pysq",@"icon_hlgxqr",@"icon_jjyj",@"icon_xetx",@"icon_sfyj",@"icon_qt"];
    
    [askTableDatas addObject:@"非常有GV户部街你看嘛"];
    [askTableDatas addObject:@"adsasds有GV户部asadsd你看嘛"];
    [askTableDatas addObjectsFromArray:arr];
    
    for (int i=0; i<arr.count; i++) {
        CBHomeMsg *m = [[CBHomeMsg alloc]init];
        m.title = arr[i];
        m.detail = @"意图以偶IPO测试的加班餐莱卡棉";
        m.image = arr1[i];
        m.time = [AppManager getCurrentTimeStrWithformat:@"HH:mm"];
        [self.tableDatas addObject:m];
    }
}

- (IBAction)askAction:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.indicateView.centerX = sender.centerX;
    }];
    tag = sender.tag;
    self.msgBtn.selected = NO;
    self.hunlianquanBtn.selected = NO;
    self.askBtn.selected = NO;
    sender.selected = YES;
    [self changeTag];
}





#pragma mark - TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tag==3) {
        return askTableDatas.count;
    }
    return self.tableDatas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tag==3) {
        return UITableViewAutomaticDimension;
    }
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tag==3) {
        AskCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"askcell"];
        NSDictionary *ask = askTableDatas[indexPath.row];
        cell.nick.text = ISSTR(ask[@"user_nickname"])?ask[@"user_nickname"]:@"";
        NSInteger add_time = [ask[@"add_time"] integerValue];
        NSString *time = [AppManager stringFromDate:[NSDate dateWithTimeIntervalSince1970:add_time] format:@"MM-dd HH:mm"];
        cell.time.text = add_time?time:@"";
        cell.content.text = ask[@"content"];
        [cell.head sd_setImageWithURL:[NSURL URLWithString:ask[@"avatar"]?:@""]];
        [cell.like setTitle:[NSString stringWithFormat:@" %@",ask[@"number_of_agree"]?:@""] forState:UIControlStateNormal];
        [cell.hate setTitle:[NSString stringWithFormat:@" %@",ask[@"number_of_disagree"]?:@""] forState:UIControlStateNormal];
        [cell.like addTarget:self action:@selector(likeAnswer:) forControlEvents:UIControlEventTouchUpInside];
        [cell.hate addTarget:self action:@selector(hateAnswer:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msg"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"msg"];
        UILabel *time = [[UILabel alloc]init];
        time.tag = 222;
        time.textColor = [UIColor lightGrayColor];
        time.font = [UIFont systemFontOfSize:12];
        time.frame = CGRectMake(0, 0, 150, 20);
        [cell.contentView addSubview:time];
        time.textAlignment = NSTextAlignmentRight;
        time.right = SWIDTH - 10;
        time.top = 18;
    }
    CBHomeMsg *m = self.tableDatas[indexPath.row];
    cell.textLabel.text = m.title;
    cell.imageView.image = [UIImage imageNamed:m.image];
    cell.detailTextLabel.text = m.detail;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    UILabel *time = [cell.contentView viewWithTag:222];
    time.text = m.time;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>=self.tableDatas.count) {
        return;
    }
}

- (IBAction)askCommentSendAct:(UIButton *)sender {
    if (_askCommentField.text.length<2) {
        [LoadingView showAMessage:@"说点什么吧！"];
        return;
    }
    [self.view endEditing:YES];
    NSString *url = @"/question/index/reply";
    [[Httprequest share] postObjectByParameters:@{@"qid":askDatas[@"id"]?:@"",@"content":_askCommentField.text} andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        
        self->_askCommentField.text = @"";
        
    } andError:^(id error) {
        
    }];
    
}

-(void)hateAnswer:(UIButton *)btn{
    
}

-(void)likeAnswer:(UIButton *)btn{
    
}

- (IBAction)askAnswerAct:(UIButton *)sender {
    [self.askTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:askTableDatas.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
@end
