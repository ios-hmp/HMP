//
//  CBMarryMessageVC.m
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBMarryMessageVC.h"

#define MaxLength 100

@interface CBMarryMessageVC ()

@end

@implementation CBMarryMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    self.countLab.text = [NSString stringWithFormat:@"%ld/%ld",self.contentTV.text.length,MaxLength];
}

-(void)configUI{
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:_navRightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
        NSString *temp = [textView.text stringByReplacingCharactersInRange:range withString:text];
        NSInteger remainTextNum = MaxLength;
        //计算剩下多少文字可以输入
        if(range.location>= MaxLength ) {
        remainTextNum = 0;
        return NO;
    }
    else {
        NSString * nsTextContent = temp;
        NSInteger existTextNum = [nsTextContent length];
        remainTextNum =10-existTextNum;
        self.countLab.text = [NSString stringWithFormat:@"%ld/%ld",(long)existTextNum,MaxLength];
        return YES;
        
    }
    
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
