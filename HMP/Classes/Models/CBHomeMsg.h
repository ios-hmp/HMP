//
//  CBHomeMsg.h
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBHomeMsg : CBBaseVc
@property (nonatomic,assign)int type;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *detail;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *image;

@end

NS_ASSUME_NONNULL_END
