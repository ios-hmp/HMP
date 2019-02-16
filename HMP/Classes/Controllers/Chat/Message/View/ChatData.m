//
//  ChatData.m
//  LALANote
//
//  Created by hcb on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ChatData.h"

@implementation ChatData
-(BOOL)isMe{
    NSString *myid = @"";
    if ([self.from_suer isEqualToString:myid]) {
        return YES;
    }
    return NO;
}
@end
