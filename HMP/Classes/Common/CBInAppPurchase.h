//
//  CBInAppPurchase.h
//  HMP
//
//  Created by hcb on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

//    类型1普通会员充值2vip充值3vip差价4修改资料5同方申请解除爱人关系普通6同方申请解除爱人关系vip
typedef NS_ENUM(NSUInteger, HMPOrderType) {
    HMPOrderTypeNormal=1,
    HMPOrderTypeVIP,
    HMPOrderTypeVIPCha,
    HMPOrderTypeChangeInfo,
    HMPOrderTypeJiechuNormal,
    HMPOrderTypeJiechuVIP,
};

@interface CBInAppPurchase : CBBaseModel

- (void)requestAppleProduct;

- (void)buy:(NSString *)type;

- (void)createOrder:(HMPOrderType)type jiechuId:(NSString *)uid;
@end

NS_ASSUME_NONNULL_END
