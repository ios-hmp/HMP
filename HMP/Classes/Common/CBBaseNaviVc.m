//
//  CBBaseNaviVc.m
//  CBWorkFlow
//
//  Created by hcb on 2018/12/22.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CBBaseNaviVc.h"

@interface CBBaseNaviVc ()

@end

@implementation CBBaseNaviVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:19 weight:UIFontWeightBold],NSFontAttributeName,  nil]];
    UIImage *backButtonImage = [[UIImage imageNamed:@"backh"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:nil action:nil];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSArray* controllerArr = @[@"CBHomeVc",@"CBChatVc",@"CBSearchVc",@"CBMineVc"];
    if (![controllerArr containsObject:NSStringFromClass(viewController.class)]) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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
