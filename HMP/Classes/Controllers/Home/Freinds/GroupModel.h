//
//  GroupModel.h
//  ExpandTableView
//
//  Created by 郑文明 on 16/1/8.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBFriends;

@interface GroupModel : NSObject
@property (nonatomic, assign)BOOL isOpened;
@property (nonatomic, retain)NSString *grop_name;
@property (nonatomic, assign)NSInteger limit_number;

@property (nonatomic, retain)NSArray <CBFriends *>*friend_list;
@end
@interface CBFriends : CBBaseModel
@property (nonatomic, assign)BOOL vip;
@property (nonatomic, copy)NSString *uid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *user_nickname;
@property (nonatomic, copy)NSString *avatar;
@property (nonatomic, copy)NSString *birthday;
@property (nonatomic, copy)NSString *intimacy;
@property (nonatomic, copy)NSString *matching_rate;
@property (nonatomic, copy)NSString *user_level;
@property (nonatomic, copy)NSString *constellation;

@end
