//
//  ChatDetailVc.h
//  LALANote
//
//  Created by hcb on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "ChatData.h"

@interface ChatDetailVc : ViewController
@property (nonatomic,copy)NSString *from_user;
@property (nonatomic,copy)NSString *to_user;
@property (nonatomic,strong)EMConversation *conver;
@end

