//
//  CBCusService.m
//  HMP
//
//  Created by hcb on 2019/2/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBCusService.h"

@interface CBCusService ()<UITextViewDelegate>
{
    NSString *orgTxt;
}
@property (weak, nonatomic) IBOutlet UITextView *field;
@property (weak, nonatomic) IBOutlet UILabel *call;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation CBCusService

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendContent)];
    self.title = @"客服";
    orgTxt = _field.text;
}

-(void)sendContent{
    if (_field.text.length<10 && [_field.text hasPrefix:orgTxt]) {
        [LoadingView showAMessage:orgTxt];
        return;
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([_field.text isEqualToString:orgTxt]) {
        textView.text = @"";
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (_field.text.length<1) {
        textView.text = orgTxt;
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
