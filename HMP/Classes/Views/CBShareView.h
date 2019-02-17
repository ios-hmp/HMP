//
//  CBShareView.h
//  HMP
//
//  Created by Jason_zyl on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBShareView : UIView
/** 分享到朋友 */
@property (nonatomic,copy) dispatch_block_t shareFriendBlock;
/** 分享到朋友圈 */
@property (nonatomic,copy) dispatch_block_t shareFriendCircleBlock;
@end

NS_ASSUME_NONNULL_END
