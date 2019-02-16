//
//  ChatCell.h
//  LALANote
//
//  Created by hcb on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatData.h"

@interface ChatCell : UITableViewCell
@property (nonatomic, strong) id data;

@property (weak, nonatomic) IBOutlet UIButton *head;

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *lbbg;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end
