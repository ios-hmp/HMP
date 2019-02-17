//
//  CBBlacklistVC.h
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlacKCollViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headPhotoImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@end
@interface CBBlacklistVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UICollectionView *BlackCollectionView;

@end

NS_ASSUME_NONNULL_END
