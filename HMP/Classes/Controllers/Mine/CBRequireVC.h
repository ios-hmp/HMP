//
//  CBRequireVC.h
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBRequireTabCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (weak, nonatomic) IBOutlet UITextField *minAgeTF;
@property (weak, nonatomic) IBOutlet UITextField *maxAgeTF;

@end

@interface CBRequireVC : CBBaseVc
@property (weak, nonatomic) IBOutlet UITableView *myTabView;
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@end

NS_ASSUME_NONNULL_END
