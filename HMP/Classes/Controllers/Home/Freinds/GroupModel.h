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
@property (nonatomic, retain)NSString *groupName;
@property (nonatomic, assign)NSInteger groupCount;

@property (nonatomic, retain)NSArray <CBFriends *>*groupFriends;
@end
@interface CBFriends : CBBaseModel
@property (nonatomic, assign)BOOL vip;
@property (nonatomic, assign)BOOL decrease;
@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *star;
@property (nonatomic, copy)NSString *qmd;
@property (nonatomic, copy)NSString *hyd;
@property (nonatomic, copy)NSString *head;

@end
