//
//  CBHomeVc.m
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBHomeVc.h"
#import "CBHomeMsg.h"

@interface CBHomeVc ()<UITableViewDelegate,UITableViewDataSource>
{
    long tag;//1 2 3信息，婚恋圈，问答
    UIView *hunlianquanView;
    BOOL hasConfig;
    NSMutableArray *askTableDatas;
}
@end

@implementation AskCommentCell



@end

@implementation CBHomeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tag = 1;
    [self testData];
//    [self testLogin];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testAPI];
    });
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

-(void)testReg{
    NSString *url = @"user/public/register";
    
    NSDictionary *par = @{
                          @"username":@"18629450667",
                          @"password":@"Test123456",
                          @"verification_code":@"658370",
                          @"device_type":@"android",
                          
                          };
    [[Httprequest share] postObjectByParameters:par andUrl:url showLoading:YES showMsg:YES isFullUrk:NO andComplain:^(id obj) {
        
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

- (void)loadNetData{
    [[CBBaseModel share] request:@"" par:nil callback:^(BOOL succs, id  _Nonnull value, NSError * _Nonnull error) {
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
        
    }];
    
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
        
        cell.nick.text = askTableDatas[indexPath.row];
        cell.time.text = @"test time str";
        NSArray *arr = @[@"test name test name test name test name",@"test name test name test name test name name test name test name test name test name test name test ",@"",@"name test name test name test name test name test name test name test name test name test name test name test name test name test name test name test name test name test name test name test name test name test name test name test name test "];
        cell.content.text = arr[arc4random()%arr.count];
        
        
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
    
}

- (IBAction)askAnswerAct:(UIButton *)sender {
    
}
@end
