//
//  CBAddComplaint.m
//  HMP
//
//  Created by hcb on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBAddComplaint.h"

@interface CBAddComplaint ()
{
    NSString *orgTxt;
}
@property (weak, nonatomic) IBOutlet UITextView *field;

@end

@implementation CBAddComplaint

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请投诉";
    orgTxt = _field.text;
    // Do any additional setup after loading the view.
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
