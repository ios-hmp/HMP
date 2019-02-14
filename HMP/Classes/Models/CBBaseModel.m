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

-(void)request:(NSString *)url par:(NSDictionary *)dic callback:(NetCallback)callback{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        callback(1,@"",nil);
//    });
}
@end
