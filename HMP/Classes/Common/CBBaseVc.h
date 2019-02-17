//
//  CBBaseVc.h
//  CBWorkFlow
//
//  Created by hcb on 2018/12/22.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBBaseModel.h"
#import "CBShareAppInfo.h"


NS_ASSUME_NONNULL_BEGIN

@interface CBBaseVc : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *tableDatas;
@property (nonatomic,strong)NSMutableArray *subDatas;
@property (nonatomic,strong)CBBaseModel *prevcData;
@property (nonatomic,assign)BOOL isrefresh;
- (void)loadNetData;
@property (nonatomic,copy)TouchEvent backEvent;
- (void)configUI;
@end

NS_ASSUME_NONNULL_END
