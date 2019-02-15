//
//  CBRedBagVC.m
//  HMP
//
//  Created by Jason_zyl on 2019/2/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBRedBagVC.h"

@interface CBRedBagVC ()
@property (weak, nonatomic) IBOutlet UIButton *navRightBtn;

@end

@implementation CBRedBagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"红包";
    [self configUI];
}

-(void)configUI{
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:_navRightBtn];
    self.navigationItem.rightBarButtonItem = item1;
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
