//
//  CBUser.m
//  HMP
//
//  Created by hcb on 2019/2/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBUser.h"

CBUser *_user;
@implementation CBUser


+(instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[self alloc]init];
    });
    
    return _user;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _uid = value;
    }
}


@end
