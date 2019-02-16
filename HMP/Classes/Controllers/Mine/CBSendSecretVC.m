//
//  CBSendSecretVC.m
//  HMP
//
//  Created by Jason_zyl on 2019/2/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBSendSecretVC.h"
#define MaxLength 100

@interface CBSendSecretVC ()

@end

@implementation CBSendSecretVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发密语";
    self.countLab.text = [NSString stringWithFormat:@"%ld/%ld",self.contentTV.text.length,MaxLength];
    NSLog(@"设置前%f",self.sendScrectBtn.width);
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [CBFastUI addGradintBg:self.sendScrectBtn];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"设置后%f",self.sendScrectBtn.width);

}

- (void)configUI{
    [CBFastUI addGradintBg:self.sendScrectBtn];
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

- (IBAction)sendScrectAction:(UIButton *)sender {
}
@end
