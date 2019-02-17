//
//  CBAddComplaint.m
//  HMP
//
//  Created by hcb on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBAddComplaint.h"
#import "HXTagsView.h"
#import "HXTagAttribute.h"

@interface CBAddComplaint ()<UITextViewDelegate>
{
    NSString *orgTxt;
    NSArray *all_tags;
}
@property (weak, nonatomic) IBOutlet UIButton *tousuBtn;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITextView *field;
@property (weak, nonatomic) IBOutlet UIView *mdView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;
@property (weak, nonatomic) IBOutlet UILabel *txtCountL;
@property (nonatomic,strong) HXTagsView *firstTagsView;
@end

@implementation CBAddComplaint

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请投诉";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.tousuBtn];
    orgTxt = _field.text;
    _field.delegate = self;
    all_tags = [[NSUserDefaults standardUserDefaults] objectForKey:@"all_tags"];
}

- (void)loadNetData{
    NSString *url = @"user/complaint/getFlags";
    __weak typeof(self) weakSelf = self;
    [[Httprequest share] postObjectByParameters:nil andUrl:url showLoading:NO showMsg:NO isFullUrk:NO andComplain:^(id obj) {
        if (([obj[@"data"] isKindOfClass:NSArray.class])) {
            self->all_tags = obj[@"data"];
            [weakSelf configUI];
        }
    } andError:^(id error) {
        
    }];
}

-(void)configUI{
    if (!all_tags) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:all_tags forKey:@"all_tags"];
    NSMutableArray *tagss = [NSMutableArray array];
    [all_tags enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        [tagss addObject:dic[@"name"]];
    }];
    self.firstTagsView.tags = tagss;
    CGFloat h = [HXTagsView getHeightWithTags:tagss layout:self.firstTagsView.layout tagAttribute:self.firstTagsView.tagAttribute width:SWIDTH];
    self.topH.constant = h;
    self.firstTagsView.frame = CGRectMake(0, 0, SWIDTH, h);
    [self.topView addSubview:self.firstTagsView];
}
- (IBAction)sendAction:(id)sender {
}
- (HXTagsView *)firstTagsView {
    if (!_firstTagsView) {
        _firstTagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(30, 35, self.view.frame.size.width-50, 0)];
        _firstTagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _firstTagsView.tagAttribute.normalBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _firstTagsView.tagAttribute.selectedBackgroundColor = MainColor;
        _firstTagsView.isMultiSelect = YES;
        _firstTagsView.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
            NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        };
    }
    return _firstTagsView;
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *temp = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger remainTextNum = 60;
    //计算剩下多少文字可以输入
    if(range.location>= 60 ) {
        remainTextNum = 0;
        return NO;
    }
    else {
        NSString * nsTextContent = temp;
        NSInteger existTextNum = [nsTextContent length];
        remainTextNum =10-existTextNum;
        self.txtCountL.text = [NSString stringWithFormat:@"%ld/%d",(long)existTextNum,60];
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
