//
//  CBUserInfoVc.m
//  HMP
//
//  Created by hcb on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBUserInfoVc.h"
#import "HXTagsView.h"
#import "HXTagAttribute.h"

@interface CBUserInfoVc ()<UIScrollViewDelegate>
{
    NSArray *titleArr;
    NSArray *hobbyArr;
    NSArray *characterArr;
    NSArray *weaknessArr;
    NSInteger h1;
    NSInteger h2;
    NSInteger h3;


}
@property (weak, nonatomic) IBOutlet UILabel *infoLable;
@property (nonatomic,retain)UIScrollView *bgScrollView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *userType;
@property (weak, nonatomic) IBOutlet UILabel *sexL;
@property (weak, nonatomic) IBOutlet UIButton *chongzhi;
- (IBAction)chongzhiAct:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
- (IBAction)editAct:(UIButton *)sender;
- (IBAction)chooseType:(UIButton *)sender;
- (IBAction)chooseSex:(UIButton *)sender;
@property (nonatomic,strong) HXTagsView *firstTagsView;
@property (nonatomic,strong) HXTagsView *firstTagsView2;
@property (nonatomic,strong) HXTagsView *firstTagsView3;


@end

@implementation CBUserInfoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isMy = 1;
    hobbyArr = @[@"读书",@"做饭",@"看电影",@"旅游",@"爬山",@"球类运1动",@"听音2乐",@"读书3",@"做4饭",@"看电5影",@"旅6游",@"爬7山",@"球8类运动",@"听音9乐"];
    characterArr = @[@"外向",@"内向",@"重细节",@"重大局",@"稳重",@"活波",@"成熟",@"好奇"];
    weaknessArr = @[@"慢热",@"急躁",@"易冲动"];
    titleArr = @[@"昵称",@"姓名",@"出生年月",@"户籍地区",@"民族",@"宗教",@"血型",@"星座",@"自我评价",@"购房地区",@"常住地址",@"工作",@"工作性质",@"职业",@"综合月收入",@"最高毕业学历",@"最高毕业学历院校",@"婚姻状况",@"身高",@"体型",@"健康状况",@"日吸烟状况",@"住房情况",@"汽车情况",@"入赘情况",@"彩礼情况",@"兴趣爱好",@"性格",@"自身缺点"];
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarH, CB_SCREENWIDTH, CB_SCREENHIGH-kNavBarH)];
    [self.view addSubview:_bgScrollView];
    self.topView.frame = CGRectMake(10, 10, SWIDTH-20, self.topView.height);
    self.bgScrollView.delegate = self;
    [self.bgScrollView addSubview:self.topView];
    [self.bgScrollView addSubview:self.tableview];
    _bgScrollView.showsVerticalScrollIndicator = NO;

}

- (void)configUI{
    [CBFastUI addGradintBg:self.chongzhi];
    [CBFastUI addGradintBg:self.editBtn];
    [CBFastUI addShadow:self.topView color:[UIColor colorWithWhite:0 alpha:0.5]];
    [CBFastUI addShadow:self.tableview color:[UIColor colorWithWhite:0 alpha:0.5]];

//    self.tableview.rowHeight = UITableViewAutomaticDimension;
//    self.tableview.estimatedRowHeight = 44;
    if (self.isMy) {
        self.title = @"个人资料";
        self.topView.top = 10;
        self.tableview.frame = CGRectMake(10, self.topView.bottom+10 , SWIDTH-20, (titleArr.count+1)*44);
        
        //底部说明信息lable
        self.infoLable.hidden = NO;
        [self.infoLable sizeToFit];
        [self.bgScrollView addSubview:self.infoLable];
        self.infoLable.width = SWIDTH-20;
        self.infoLable.top = self.tableview.bottom+10;
        self.infoLable.left = 10;

    }else{
        self.title = @"用户昵称";
        self.topView.hidden = YES;
        self.tableview.frame = CGRectMake(10, 10, SWIDTH-20, _bgScrollView.height - 20);
    }
    [self updateContentSize];
}

-(void)updateContentSize{
    if (self.isMy) {
//        self.tableview.frame = CGRectMake(10, self.topView.bottom+10 , SWIDTH-20, (titleArr.count+1)*44);
        self.tableview.height = self.tableview.contentSize.height;
        self.infoLable.top = self.tableview.bottom+10;
        self.bgScrollView.contentSize = CGSizeMake(SWIDTH, self.infoLable.bottom+10);
    }else{
        self.bgScrollView.contentSize = CGSizeMake(SWIDTH, self.tableview.bottom+10);
    }
}


- (IBAction)chongzhiAct:(UIButton *)sender {
}
- (IBAction)editAct:(UIButton *)sender {
}

- (IBAction)chooseType:(UIButton *)sender {
}

- (IBAction)chooseSex:(UIButton *)sender {
}

- (HXTagsView *)firstTagsView {
    if (!_firstTagsView) {
        _firstTagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(30, 35, self.view.frame.size.width-50, 0)];
        _firstTagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _firstTagsView.tagAttribute.normalBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _firstTagsView.tagAttribute.selectedBackgroundColor = MainColor;
        _firstTagsView.isMultiSelect = YES;
        _firstTagsView.tags = hobbyArr;
        _firstTagsView.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
            NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        };
    }
    return _firstTagsView;
}

- (HXTagsView *)firstTagsView2 {
    if (!_firstTagsView2) {
        _firstTagsView2 = [[HXTagsView alloc] initWithFrame:CGRectMake(30, 35, self.view.frame.size.width-50, 0)];
        _firstTagsView2.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _firstTagsView2.tagAttribute.normalBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _firstTagsView2.tagAttribute.selectedBackgroundColor = MainColor;
        _firstTagsView2.isMultiSelect = YES;
        _firstTagsView2.tags = characterArr;
        _firstTagsView2.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
            NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        };
    }
    return _firstTagsView2;
}

- (HXTagsView *)firstTagsView3 {
    if (!_firstTagsView3) {
        _firstTagsView3 = [[HXTagsView alloc] initWithFrame:CGRectMake(30, 35, self.view.frame.size.width-50, 0)];
        _firstTagsView3.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _firstTagsView3.tagAttribute.normalBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _firstTagsView3.tagAttribute.selectedBackgroundColor = MainColor;
        _firstTagsView3.isMultiSelect = YES;
        _firstTagsView3.tags = weaknessArr;
        _firstTagsView3.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
            NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        };
    }
    return _firstTagsView3;
}
- (HXTagsView *)newTag {
    
    HXTagsView *_firstTagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(30, 35, self.view.frame.size.width-50, 0)];
    _firstTagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _firstTagsView.tagAttribute.normalBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    _firstTagsView.tagAttribute.selectedBackgroundColor = MainColor;
    _firstTagsView.isMultiSelect = YES;
    _firstTagsView.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
        NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
    };
    
    return _firstTagsView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isInput = NO;
    if (indexPath.row==13||indexPath.row==16) {
        isInput = YES;
    }
    //txt View
    if (indexPath.row==8) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"info3"];
        UILabel *l = [cell.contentView viewWithTag:1];
        l.text = titleArr[indexPath.row];
        
        return cell;
    }
    //tag View
    if (indexPath.row>=titleArr.count-3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"info4"];
        UILabel *l = [cell.contentView viewWithTag:1];
        l.text = titleArr[indexPath.row];
        [[cell.contentView viewWithTag:6] removeFromSuperview];
        
        HXTagsView *v ;
        if (indexPath.row==titleArr.count-3) {
            v = self.firstTagsView;
        }
        if (indexPath.row==titleArr.count-2) {
            v = self.firstTagsView2;
        }
        if (indexPath.row==titleArr.count-1) {
            v = self.firstTagsView3;
        }
        v.tag = 6;
        [cell.contentView addSubview:v];
        CGFloat h = [HXTagsView getHeightWithTags:v.tags layout:v.layout tagAttribute:v.tagAttribute width:SWIDTH];
        NSInteger lh = 40;
        if (indexPath.row==titleArr.count-3) {
            h1 = h + lh;
        }
        if (indexPath.row==titleArr.count-2) {
            h2 = h + lh;
        }
        if (indexPath.row==titleArr.count-1) {
            h3 = h + lh;
        }
        v.frame = CGRectMake(0, 35, SWIDTH-20, h);
        
        return cell;
    }
    //choose view
    if (!isInput) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"info1"];
        UILabel *l = [cell.contentView viewWithTag:1];
        l.text = titleArr[indexPath.row];
        
        if (!self.isMy) {
            cell.accessoryType=UITableViewCellAccessoryNone;
            UIView *v = [cell.contentView viewWithTag:2];
            v.right -= 10;            
        }
        return cell;
    }
    //input view
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"info2"];
        UILabel *l = [cell.contentView viewWithTag:1];
        l.text = titleArr[indexPath.row];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==8) {
        return 85;
    }
    //兴趣爱好
    if (indexPath.row==titleArr.count-3) {
        return h1?:95;
    }
    //性格
    if (indexPath.row==titleArr.count-2) {
        return h2?:95;
    }
    //自身缺点
    if (indexPath.row==titleArr.count-1) {
        return h3?:95;
    }
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateContentSize];
}

@end
