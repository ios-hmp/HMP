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

-(instancetype)init{
    self = [super init];
    if (self) {
        NSString *oldInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"UINFO"];
        NSDictionary *dic = [AppManager parseJSONStringToNSDictionary:oldInfo];
        if (ISDIC(dic)) {
            [self setValuesForKeysWithDictionary:dic];
        }
        if (_token) {
            [Httprequest share].manager = [Httprequest shareSessionManger];
            [[Httprequest share].manager.requestSerializer setValue:_token forHTTPHeaderField:@"Marriage-Love-Token"];
            [[Httprequest share].manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Marriage-Love-Device-Type"];
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _uid = value;
    }
}

-(void)save{
    [[NSUserDefaults standardUserDefaults] setObject:[self mj_JSONString] forKey:@"UINFO"];
}

-(void)logout{
    self.token = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UINFO"];
}

@end
