//
//  CBReplySecretWordVC.m
//  HMP
//
//  Created by Jason_zyl on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBReplySecretWordVC.h"
#define MaxLength 60

@implementation CBReplySecretWordVC
-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [CBFastUI addGradintBg:self.replyBtn];

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
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
        self.countLab.text = [NSString stringWithFormat:@"%ld/%d",(long)existTextNum,MaxLength];
        return YES;
        
    }
    
}

- (IBAction)replyBtnAction:(UIButton *)sender {
}
@end
