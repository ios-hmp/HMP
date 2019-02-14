//
//  CBBaseTabbarVc.m
//  CBWorkFlow
//
//  Created by hcb on 2018/12/22.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CBBaseTabbarVc.h"
#import "CBBaseNaviVc.h"

@interface CBBaseTabbarVc ()

@end

@implementation CBBaseTabbarVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTabBar];
}
//创建tabbar
- (void)createTabBar
{
    
    //视图数组
    NSArray* controllerArr = @[@"CBHomeVc",@"CBChatVc",@"CBSearchVc",@"CBMineVc"];
    //标题数组
    NSArray* titleArr = @[@"首页",@"聊天",@"搜索",@"我的"];
    //图片数组
    NSArray* picArr = @[@"nav_home",@"nav_chat",@"nav_search",@"nav_mine"];
    //storyboard name 数组
    NSArray* storyArr = @[@"Main",@"Chat",@"Search",@"Mine"];

    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    for(int i=0; i<picArr.count; i++)
    {
        UIViewController* controller = [[UIStoryboard storyboardWithName:storyArr[i] bundle:nil] instantiateViewControllerWithIdentifier:controllerArr[i]];
        CBBaseNaviVc *nv = [[CBBaseNaviVc alloc]initWithRootViewController:controller];
        
        controller.title = titleArr[i];
        
        nv.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",picArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //设置选中时的图片
        nv.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_pre",picArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //设置选中时字体的颜色(也可更改字体大小)
        [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MainColor} forState:UIControlStateSelected];
        [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateNormal];
        [array addObject:nv];
        
    }
    self.viewControllers = array;
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
