//
//  CBMessageVC.h
//  HMP
//
//  Created by zhanbing han on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CBBaseVc.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageTabCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@interface CBMessageVC : CBBaseVc<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *msgTabView;

@end

NS_ASSUME_NONNULL_END
