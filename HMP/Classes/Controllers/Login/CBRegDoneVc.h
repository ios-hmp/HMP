//
//  CBRegDoneVc.h
//  HMP
//
//  Created by hcb on 2019/1/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBRegDoneVc : CBBaseVc
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
