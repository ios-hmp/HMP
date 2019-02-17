//
//  CBApplyInputVc.m
//  HMP
//
//  Created by hcb on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBApplyInputVc.h"

@interface CBApplyInputVc ()
{
    NSString *orgTxt;
}
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UITextView *field;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation CBApplyInputVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendContent)];
    self.title = @"婚恋关系申请升级";
    //申请恋人关系提醒
    if (1) {
        self.info.text = @"申请恋人关系提醒：您与对方申请成为恋人关系，成为恋人关系才能有权申请发展爱人关系。如果您们没有达成恋人关系，则您们之间的关系会降低为朋友关系。申请时效为15天。";
    }
    //爱人关系
    self.info.text = @"申请爱人关系提醒：在申请爱人关系前您已完成线下用户身份和个人资料的认证，若与对方成功达成的爱人关系将会受到平台保护，您们将拥有封闭的聊天交流空间。在爱人关系期间，您们的信息及关系将不被其他用户干扰，同时您们也不能与其他用户进行任何交流。您们也停止缴纳服务年费直至您们其中一人申请解除爱人关系。如果您们没有达成爱人关系，则您们之间的关系会降低为好友关系。申请时效为15天。";
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
