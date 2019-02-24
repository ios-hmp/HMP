//
//  CBLoginVc.h
//  QHBPRO
//
//  Created by mac on 2017/7/16.
//  Copyright © 2017年 hcb All rights reserved.
//

#import "CBBaseVc.h"


@interface CBLoginVc : CBBaseVc
- (IBAction)forget:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *thirdLable;
@property (weak, nonatomic) IBOutlet UIButton *wxImg;
@property (weak, nonatomic) IBOutlet UILabel *wxlable;
@property (weak, nonatomic) IBOutlet UIButton *qqImg;
@property (weak, nonatomic) IBOutlet UIButton *alipayImg;
@property (weak, nonatomic) IBOutlet UILabel *alipayLable;

@property (weak, nonatomic) IBOutlet UILabel *qqLable;
@end
