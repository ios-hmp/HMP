//
//  CBApplyInputVc.h
//  HMP
//
//  Created by hcb on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBApplyInputVc : CBBaseVc
@property (nonatomic,strong)NSDictionary *applyInfo;
@property (nonatomic,assign)int type;//1 升级好友 2恋人  3爱人
@end

NS_ASSUME_NONNULL_END
