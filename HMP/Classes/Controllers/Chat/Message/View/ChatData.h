//
//  ChatData.h
//  LALANote
//
//  Created by hcb on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ChatData:NSObject
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *created_at;
@property (nonatomic,copy)NSString *message;

@property (nonatomic,copy)NSString *to_suer;
@property (nonatomic,copy)NSString *to_avatar;

@property (nonatomic,copy)NSString *from_suer;
@property (nonatomic,copy)NSString *from_avatar;

@property (nonatomic,assign,getter=isMe)BOOL isme;


@end
