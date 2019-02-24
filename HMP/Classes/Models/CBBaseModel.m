//
//  CBBaseModel.m
//  CBWorkFlow
//
//  Created by hcb on 2018/12/22.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CBBaseModel.h"
CBBaseModel *_md;
@implementation CBBaseModel
+(instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _md = [[self alloc]init];
    });
    
    return _md;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(void)request:(NSString *)url par:(NSDictionary *)dic callback:(APICallback)callback{

    [[Httprequest share] postObjectByParameters:dic andUrl:url showLoading:NO showMsg:NO isFullUrk:NO andComplain:^(id obj) {
        NSString *msg = obj[@"msg"];
        if ([obj[@"data"] isKindOfClass:[NSArray class]] || ISDIC(obj[@"data"])) {
            NSDictionary *info = [obj[@"data"] mutableCopy];
            callback(info,msg);
        }else{
            callback(nil,msg);
        }
    } andError:^(NSError *error) {
        callback(nil,[NSString stringWithFormat:@"出错了：%ld",(long)error.code]);
    }];
    
}
@end
