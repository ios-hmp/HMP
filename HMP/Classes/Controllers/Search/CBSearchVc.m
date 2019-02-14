//
//  CBSearchVc.m
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBSearchVc.h"
#import "CBBaseInfoVc.h"

#define CB_SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define CB_SCREENHIGH  [UIScreen mainScreen].bounds.size.height
// 多少列
#define CB_BRANDSECTION 2
// 列表间隔距离
#define CB_BRANDDEV 10
// cell宽度
#define CB_LIST1CELLWIDTH (CB_SCREENWIDTH - (CB_BRANDSECTION + 1)*CB_BRANDDEV) / CB_BRANDSECTION




@interface SearchHeadCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *star;
@property (weak, nonatomic) IBOutlet UIImageView *vip;
@property (weak, nonatomic) IBOutlet UIImageView *head;

@end

@implementation SearchHeadCell



@end

@interface CBSearchVc ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CBSearchVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self test];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showFillInfo];
    });
    
    //cell点击后大图显示
    //    左右滑动切换相册其他照片，上下滑动切换人
}

-(void)configUI{
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"sz"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(settings)];
    item1.width = 30;
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"switch"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(exhange)];
    item2.width = 30;
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.leftBarButtonItems = @[item1,item2];
    self.navigationItem.rightBarButtonItem = item3;
    
    
}

-(void)settings{
    
}

-(void)exhange{
    
}

-(void)search{
    UIViewController *vc = [AppManager getVCInBoard:@"Search" ID:@"CBSearchInputVc"];
    PUSH(vc);
}
-(void)showFillInfo{
    self.fillInfoView.hidden = NO;
    self.fillInfoView.alpha = 0;
    self.fillInfoView.frame = self.view.frame;
    self.fillContentView.center = self.view.center;
    [CBFastUI addGradintBg:self.fillBtn];
    [UIView animateWithDuration:0.3 animations:^{
        self.fillInfoView.alpha = 1.0;
    }];
    [self.view addSubview:self.fillInfoView];
    
}

-(void)test{
    [self.tableDatas addObject:@"用户m1"];
    [self.tableDatas addObject:@"用户mdasdsaar1asd"];
    [self.tableDatas addObject:@""];
    [self.tableDatas addObject:@"vnv那你m1"];
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headcell" forIndexPath:indexPath];
    cell.nickName.text = self.tableDatas[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

// 定义每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CB_LIST1CELLWIDTH, CB_LIST1CELLWIDTH*1.3);
}

// 定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(CB_BRANDDEV, CB_BRANDDEV, CB_BRANDDEV, CB_BRANDDEV);
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CB_BRANDDEV;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CB_BRANDDEV;
}
- (IBAction)goFill:(UIButton *)sender {
    
    CBBaseInfoVc *vc = (CBBaseInfoVc *)[AppManager getVCInBoard:@"Login" ID:@"CBBaseInfoVc"];
    vc.isFromSearch = YES;
    PUSH(vc);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.fillInfoView.alpha = 0;
    } completion:^(BOOL finished) {
        self.fillInfoView.hidden = YES;
    }];
}
@end
