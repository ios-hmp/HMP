//
//  CBInAppPurchase.h
//  HMP
//
//  Created by hcb on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBInAppPurchase : CBBaseModel

- (void)requestAppleProduct;

- (void)buy:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
