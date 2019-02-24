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

- (void)loadNetData{
//    "worktime": "8：00～18：00（节假日除外）",
//    "telphone": "12345678"
    [CBBaseModel request:@"/service/index/index" par:nil callback:^(id  _Nonnull data, NSString * _Nonnull msg) {
        if (data) {
            self.time.text = [NSString stringWithFormat:@"工作时间：%@",data[@"worktime"]];
            self.call.text = [NSString stringWithFormat:@"%@",data[@"telphone"]];
        }
    }];
}

-(void)sendContent{
    if (_field.text.length<5 || [_field.text hasPrefix:orgTxt]) {
        [LoadingView showAMessage:orgTxt];
        return;
    }
    [LoadingView showLoading];
    [CBBaseModel request:@"/service/index/addQuestion" par:@{@"content":_field.text} callback:^(id  _Nonnull data, NSString * _Nonnull msg) {
        
        [LoadingView showAMessage:msg];
        if ([msg containsString:@"成功"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                POP;
            });
        }
    }];
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
