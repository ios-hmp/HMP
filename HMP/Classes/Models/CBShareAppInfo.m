//
//  CBShareAppInfo.m
//  CBWorkFlow
//
//  Created by hcb on 2018/12/23.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CBShareAppInfo.h"

CBShareAppInfo *_info;

@implementation CBShareAppInfo

+(instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _info = [[self alloc]init];
    });
    
    return _info;
}

@end
