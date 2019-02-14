//
//  CBShareAppInfo.h
//  CBWorkFlow
//
//  Created by hcb on 2018/12/23.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBShareAppInfo : CBBaseModel

@property (nonatomic,assign)BOOL needReview;//捷径发布时是否需要审核
@property (nonatomic,assign)BOOL needReLogin;//首次进入APP时是否需要重新登录
@property (nonatomic,assign)BOOL isRepairing;
@property (nonatomic,assign)NSInteger pageSize;//用于各个网络请求时每页大小限制
@property (nonatomic,assign)NSInteger scExpNumber;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *repairString;
@property (nonatomic,copy)NSString *scSubInfo;
//@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,assign)BOOL showFeedback;//显示举报
@property (nonatomic,copy)NSString *about;


@end


NS_ASSUME_NONNULL_END
