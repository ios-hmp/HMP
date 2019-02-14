//
//  CBBaseModel.h
//  CBWorkFlow
//
//  Created by hcb on 2018/12/22.
//  Copyright © 2018 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NetCallback)(BOOL succs,id value,NSError *error);

@interface CBBaseModel : NSObject

+ (instancetype)share;

- (void)request:(NSString *)url par:(nullable NSDictionary *)dic callback:(nullable NetCallback)callback;

@end

NS_ASSUME_NONNULL_END
