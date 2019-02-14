
//
//  CBWebVc.m
//  CBWorkFlow
//
//  Created by hcb on 2018/12/23.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CBWebVc.h"

@interface CBWebVc ()<WKNavigationDelegate>

@end

@implementation CBWebVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    //添加状态栏视图
//    UIView *v = [[UIView alloc]initWithFrame:self.view.frame];
//    v.height = 20;
//    [self.view bringSubviewToFront:v];

    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.url) {
        @try {
            if ([self.url.absoluteString containsString:@"file://"]) {
                
                [self.webView loadFileURL:self.url allowingReadAccessToURL:self.url];
            }else{
                [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
}
- (WKWebView *)webView {
    if (!_webView) {
        //以下代码适配大小
//        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
//        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//        wkWebConfig.userContentController = wkUController;
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:wkWebConfig];
        [self.view addSubview:_webView];
        self.webView.allowsBackForwardNavigationGestures = YES;
        _webView.navigationDelegate = self;
        [self.view addSubview:self.webView];
    }
    return _webView;
}


-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    __weak typeof(self) weakSelf = self;
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadWeb];
    }];
}

- (void)reloadWeb{
    [self.webView reload];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView.scrollView.mj_header endRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.webView.scrollView.mj_header = nil;
        });
    });
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
