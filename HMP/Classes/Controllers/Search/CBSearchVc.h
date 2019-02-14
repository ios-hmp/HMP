//
//  CBSearchVc.h
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBSearchVc : CBBaseVc
@property (strong, nonatomic) IBOutlet UIView *fillInfoView;
- (IBAction)goFill:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *fillContentView;
@property (weak, nonatomic) IBOutlet UIButton *fillBtn;

@end

NS_ASSUME_NONNULL_END
