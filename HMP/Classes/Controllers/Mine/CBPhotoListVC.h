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
@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;

@end

@interface CBPhotoListVC : CBBaseVc

@end

NS_ASSUME_NONNULL_END
