//
//  CBUser.m
//  HMP
//
//  Created by hcb on 2019/2/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBUser.h"

@implementation CBUser

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _uid = value;
    }
}


@end
