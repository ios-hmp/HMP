//
//  CBWebVc.h
//  CBWorkFlow
//
//  Created by hcb on 2018/12/23.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CBBaseVc.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBWebVc : CBBaseVc

@property (nonatomic,strong)NSURL *url;
@property (nonatomic,strong)WKWebView *webView;
@end

NS_ASSUME_NONNULL_END
