//
//  CBPhotoListVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBPhotoListVC.h"

// 多少列
#define CB_BRANDSECTION 2
// 列表间隔距离
#define CB_BRANDDEV 10
// cell宽度
#define CB_LIST1CELLWIDTH (CB_SCREENWIDTH - (CB_BRANDSECTION + 1)*CB_BRANDDEV) / CB_BRANDSECTION


@interface CBPhotoListVC ()
{
    NSArray *dataSource;
}
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollView;
@property (weak, nonatomic) IBOutlet UIButton *navRightBtn;
@end

@implementation CBPhotoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    dataSource = @[@"test",@"test",@"test",@"test",@"test"];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:_navRightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataSource.count+1;;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollViewCell" forIndexPath:indexPath];
    if (indexPath.row<dataSource.count) {
        cell.photoImgView.image = [UIImage imageNamed:dataSource[indexPath.row]];
        cell.photoImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    else {
        cell.photoImgView.image = [UIImage imageNamed:@"photo_add"];
        cell.photoImgView.contentMode = UIViewContentModeCenter;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==dataSource.count) {
        NSLog(@"添加照片");
    }
}


#pragma mark ---- UICollectionViewDelegateFlowLayout
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation PhotoCollViewCell

@end
