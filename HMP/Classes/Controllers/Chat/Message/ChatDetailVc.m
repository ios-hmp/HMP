//
//  ChatDetailVc.m
//  LALANote
//
//  Created by hcb on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ChatDetailVc.h"
//#import "MWPhotoBrowser.h"
//#import "TZImagePickerController.h"
#import "ChatCell.h"
//MWPhotoBrowserDelegate
@interface ChatDetailVc ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray <ChatData *>*dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *btmView;
@property (weak, nonatomic) IBOutlet UITextField *field;
@property (weak, nonatomic) IBOutlet UIButton *send;
- (IBAction)send:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *add;
- (IBAction)add:(UIButton *)sender;

@end





@implementation ChatDetailVc
//+ (instancetype)spawn
//{
//    return [ChatDetailVc loadFromStoryBoard:@"chat"];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    //强制刷新布局
//    [self.view layoutIfNeeded];
    // Do any additional setup after loading the view.
    
    [self setupView];
    [self setupdata];
}
-(void)setupdata{
    dataArr = [NSMutableArray array];
 
    
    for (int i=0; i<30; i++) {
        ChatData *data = [[ChatData alloc]init];
        data.from_suer = arc4random()%2?@"hh":@"bb";
        data.type = arc4random()%3?@"text":@"image";
        data.message = [self message];
        data.isme = arc4random()%2;
        data.created_at = @"2018-06-21 15:34";
        [dataArr addObject:data];
    }
    [self.tableView reloadData];
}
-(NSString *)message{
    int c = arc4random()%200+10;
    NSMutableString *s = [NSMutableString string];
    NSArray *a = @[@"你",@"我",@"你好",@"巴德士",@"大市场",@"按说"];
    for (int i=0; i<c ; i++) {
        [s appendString:a[arc4random()%a.count]];
    }
    return s;
}
-(void)setupView{
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatCell" bundle:nil] forCellReuseIdentifier:@"ChatCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"ChatCell2" bundle:nil] forCellReuseIdentifier:@"ChatCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatImgCell" bundle:nil] forCellReuseIdentifier:@"ChatImgCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatImgCell2" bundle:nil] forCellReuseIdentifier:@"ChatImgCell2"];
    self.add.layer.borderWidth = 2;
    self.add.layer.borderColor = self.add.currentTitleColor.CGColor;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatData *data = dataArr[indexPath.row];
    if ([data.type isEqualToString:@"text"]) {
        NSString *reuse = @"ChatCell";
        if (data.isme) {
            reuse = @"ChatCell2";
        }
        ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        cell.data = data;
        return cell;
        
    }else if ([data.type isEqualToString:@"image"]) {
        NSString *reuse = @"ChatImgCell";
        if (data.isme) {
            reuse = @"ChatCell2";
        }
        ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        cell.data = data;
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatData *data = dataArr[indexPath.row];
    if ([data.type isEqualToString:@"image"]) {
        //预览
//       MWPhotoBrowser *browser = [[MWPhotoBrowser alloc]initWithDelegate:self];
//        browser.alwaysShowControls = YES;
//
//
//
//
//        [browser reloadData];
//
//        [browser setCurrentPhotoIndex:0];
//        [self.navigationController showViewController:browser sender:tap.view];
    }
}
//- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
//    return 1;
//}
//
//- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
//    ChatData *data = dataArr[indexPath.row];

//    MWPhoto *p = [MWPhoto photoWithURL:[NSURL URLWithString:data.message]];
//    return p;
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self send:nil];
    return YES;
}
- (IBAction)send:(UIButton *)sender {
    if (_field.text.length>0) {
        [self sendTxt:_field.text img:nil];
        _field.text = @"";
    }
    [self.view endEditing:YES];
}
- (BOOL) imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}
- (NSString *) image2DataURL: (UIImage *) image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 1.0f);
        mimeType = @"image/jpeg";
    }
    
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: 0]];
    
}
-(void)sendTxt:(NSString *)txt img:(UIImage *)img{
    NSString *imgStr = @"";
    if (img) {
        imgStr = [self image2DataURL:img];
    }
    
 
}
- (IBAction)add:(UIButton *)sender {
    [self addImage];
}
-(void)addImage{
//    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
//    __weak typeof(self) weakSelf = self;
//
//
//    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        self->imagesArr = [photos mutableCopy];
//        [weakSelf sendTxt:nil img:photos.firstObject];
//    }];
//    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
@end
