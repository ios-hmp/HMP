//
//  CBBlacklistVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBlacklistVC.h"

// 多少列
#define CB_BRANDSECTION 3.01
// 列表间隔距离
#define CB_BRANDDEV 10
// cell宽度
#define CB_LIST1CELLWIDTH ((CB_SCREENWIDTH - (CB_BRANDSECTION + 1)*CB_BRANDDEV) / CB_BRANDSECTION)


@interface CBBlacklistVC ()

@end

@implementation CBBlacklistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BlacKCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BlacKCollViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [AppManager getVCInBoard:@"Mine" ID:@"CBBlackOperateVC"];
    PUSH(vc);
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

@implementation BlacKCollViewCell
-(void)layoutSubviews {
    [super layoutSubviews];
//    CB_LIST1CELLWIDTH, CB_LIST1CELLWIDTH*1.3
    _headPhotoImgView.frame = CGRectMake(CB_LIST1CELLWIDTH*0.1, (CB_LIST1CELLWIDTH*0.5-30)/2.0, CB_LIST1CELLWIDTH*0.8, CB_LIST1CELLWIDTH*0.8);
    _nameLab.top =_headPhotoImgView.bottom+10;
    _headPhotoImgView.layer.cornerRadius = _headPhotoImgView.width/2.0;
}
@end
