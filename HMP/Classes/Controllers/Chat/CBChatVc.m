//
//  CBChatVc.m
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBChatVc.h"
#import "CBFriendsVc.h"
#import "ChatDetailVc.h"

@interface CBChatVc ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *hunlianquanView;
}
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *titleLineView;
@property (weak, nonatomic) IBOutlet UIButton *titleLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *titleRightBtn;

@end


@interface CBChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UIButton *type;
@property (weak, nonatomic) IBOutlet UILabel *xz;
@property (weak, nonatomic) IBOutlet UIImageView *vip;
@property (weak, nonatomic) IBOutlet UILabel *msg;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation CBChatCell



@end

@implementation CBChatVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    //设置预估行高
    self.tableview.estimatedRowHeight = 100.0f;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
    //test
    [[EMClient sharedClient].chatManager getConversation:@"27" type:EMConversationTypeChat createIfNotExist:YES];
    [self loadNetData];
    
}

- (void)loadNetData{
    NSArray<EMConversation *> *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    //对会话信息匹配对应用户名图像等用户信息
    
    self.tableDatas = conversations;
    
    [self.tableview reloadData];
    if ([self.tableview.mj_header isRefreshing]) {
        [self.tableview.mj_header endRefreshing];
    }
}

                       
-(void)configUI{
    CBFriendsVc *friendVc = [[CBFriendsVc alloc]init];
    
    friendVc.view.frame = self.tableview.frame;
    friendVc.tableview.frame = friendVc.view.bounds;
    [self addChildViewController:friendVc];
    [self.view insertSubview:friendVc.view atIndex:5];
    [friendVc didMoveToParentViewController:self];
    friendVc.view.hidden = YES;
    hunlianquanView = friendVc.view;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _titleView.top = 0;
    _titleView.centerX = CB_SCREENWIDTH/2.0;
    _titleView.hidden = NO;
    [self.navigationController.navigationBar addSubview:_titleView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    _titleView.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CBChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CBChatCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    EMConversation *con = self.tableDatas[indexPath.row];
    cell.name.text = con.conversationId;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EMConversation *con = self.tableDatas[indexPath.row];
    ChatDetailVc *vc = (ChatDetailVc *)[AppManager getVCInBoard:@"Chat" ID:@"ChatDetailVc"];
    vc.conver = con;
    SHOW(vc);
}

- (IBAction)titleAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    sender.selected = YES;
    if ([sender isEqual:weakSelf.titleLeftBtn]) {
        self.tableview.hidden = NO;
        hunlianquanView.hidden = YES;
    }
    else {
        self.tableview.hidden = YES;
        hunlianquanView.hidden = NO;
    }

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
