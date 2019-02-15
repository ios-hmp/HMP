//
//  CBPhotoListVC.h
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollViewCell : UICollectionViewCell

@end

@interface CBPhotoListVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollView;

@end

NS_ASSUME_NONNULL_END
