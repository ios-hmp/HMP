//
//  AppManager.m
//  CommonProject
//
//  Created by mac on 2016/12/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager
+(UIViewController *)getVCInBoard:(NSString *)bord ID:(NSString *)idd{
    @try {
        if (!bord) {
            bord = @"Main";
        }
        UIStoryboard *story = [UIStoryboard storyboardWithName:bord bundle:nil];
        return [story instantiateViewControllerWithIdentifier:idd];
        
    } @catch (NSException *exception) {
        NSLog(@"无对应的控制器board  %@ ,identify:%@",bord,idd);
        return nil;
    } @finally {
        
    }
    
}


+ (BOOL)createPathIfNecessary:(NSString*)path {
    BOOL succeeded = YES;
    
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        succeeded = [fm createDirectoryAtPath: path
                  withIntermediateDirectories: YES
                                   attributes: nil
                                        error: nil];
    }
    
    return succeeded;
}



+ (NSString*)documentDirectoryPathWithName:(NSString*)name {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* cachesPath = [paths objectAtIndex:0];
    NSString* cachePath = [cachesPath stringByAppendingPathComponent:name];
    
    [AppManager createPathIfNecessary:cachesPath];
    [AppManager createPathIfNecessary:cachePath];
    
    return cachePath;
}

+ (NSString*)documentDirectoryPath {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* cachesPath = [paths objectAtIndex:0];
    
    [AppManager createPathIfNecessary:cachesPath];
    
    return cachesPath;
}


+ (NSString*)cacheDirectoryPathWithName:(NSString*)name {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachesPath = [paths objectAtIndex:0];
    NSString* cachePath = [cachesPath stringByAppendingPathComponent:name];
    
    [AppManager createPathIfNecessary:cachesPath];
    [AppManager createPathIfNecessary:cachePath];
    
    return cachePath;
}

+(BOOL)writeObject:(id)object toDocDirWithName:(NSString *)name{
    NSString *path = [AppManager documentDirectoryPath];
    path = [path stringByAppendingPathComponent:name];
    NSError *error;
    
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)object;
        
        
        if([arr writeToFile:path atomically:YES]){
            return YES;
        }else{
            return NO;
        }
    }
    if ([object isKindOfClass: [NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)object;
        if ([name containsString:@".plist"]) {
            if([dic writeToFile:path atomically:YES]){
                return YES;
            }else{
                return NO;
                
            }
            
        }else
            if([NSKeyedArchiver archiveRootObject:dic toFile:path]){
                return YES;
            }else{
                return NO;
            }
        
        //        if([dic writeToFile:path atomically:YES]){
        //            return YES;
        //        }else{
        //            return NO;
        //        }
        
    }
    if ([object isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)object;
        [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            return NO;
        }else{
            return YES;
        }
    }
    [object writeToFile:path options:NSDataWritingAtomic error:&error];
    if (!error) {
        return YES;
    }else{
        return NO;
    }
}
+(NSDateFormatter *)dateFormater{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSTimeZone* localzone = [NSTimeZone localTimeZone];  
//    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];  
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];  
    
    [dateFormatter setTimeZone:localzone]; 
    return formatter;
}
+(NSDate *)dateFromString:(NSString *)str format:(NSString *)format{
    NSDateFormatter *formatter = [AppManager dateFormater];
    formatter.dateFormat = format;

    NSDate *date = [formatter dateFromString:str];
    
    return date;
}
+(NSString *)stringFromDate:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *formatter = [AppManager dateFormater];
    formatter.dateFormat = format;

    return [formatter stringFromDate:date];
}
+(NSString *)getCurrentTimeStrWithformat:(NSString *)format{
    NSDateFormatter *formatter = [AppManager dateFormater];
    formatter.dateFormat = format;
    
    NSDate *date = [NSDate date];
    return [formatter stringFromDate:date];
    
}

+(void)logJsonStr:(NSDictionary *)dic{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        NSString *str = [dic mj_JSONString];
        printf("\n");

        for (int i=0; i<str.length; i++) {
            NSString *tmp = [str substringWithRange:NSMakeRange(i, 1)];
            
            if ([tmp isEqualToString:@"\""]) {
                printf("\\");
            }
            printf("%s",[tmp cStringUsingEncoding:NSUTF8StringEncoding]);

        }
        printf("\n");
    }
    
}
+(void)formatJsonStr:(NSString *)jsonStr{
    NSInteger depth = 0;
    NSString *space = @"  ";
    NSMutableString *formated = [NSMutableString string];
    [formated appendString:@"\n"];
    for (int i=0; i<jsonStr.length; i++) {
        NSString *c = [NSString stringWithFormat:@"%@",[jsonStr substringWithRange:NSMakeRange(i, 1)]];
        if ([c isEqualToString:@"{"]) {
             depth+=1;
            [formated appendString:c];
            [formated appendString:@"\n"];
            for (int j=0; j<depth; j++) {
                [formated appendString:space];
            }
        }else if ([c isEqualToString:@"}"]) {
            depth-=1;
            [formated appendString:@"\n"];
            for (int j=0; j<depth; j++) {
                [formated appendString:space];
            }
            [formated appendString:c];
        }else if ([c isEqualToString:@","]) {
            [formated appendString:c];
            [formated appendString:@"\n"];
            for (int j=0; j<depth; j++) {
                [formated appendString:space];
            }
        }else if ([c isEqualToString:@"["]) {
            depth+=1;
            [formated appendString:c];
            [formated appendString:@"\n"];
            for (int j=0; j<depth; j++) {
                [formated appendString:space];
            }
        }else if ([c isEqualToString:@"]"]) {
            depth-=1;
            [formated appendString:@"\n"];
            for (int j=0; j<depth; j++) {
                [formated appendString:space];
            }
            [formated appendString:c];
        }else{
            [formated appendString:c];
        }
    }
    NSLog(@"%@",formated);
}
+(void)outputProperty:(NSDictionary *)dic{
    for (NSString *key in dic.allKeys) {
        printf("@property(nonatomic,copy) NSString *%s;\n",[key cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
}
+(NSString *)costTimeStrWithMinute:(NSInteger)minute{
    NSInteger mm = minute;
    NSInteger day = mm/60/24;
    NSInteger hour = 0;
    NSInteger minte = 0;
    if (day>0) {
        hour = (mm-day*24*60)/60;
        if (hour>0) {
            minte = ((mm-day*24*60)/60)%60;
            
        }else{
            minte = mm;
        }
    }else{
        hour = mm/60;
        if (hour>0) {
            minte = (mm/60)%60;
            
        }else{
            minte = mm;
        }
    }
    
    NSString *lishi = @"";
    if (day>0) {
        lishi = [NSString stringWithFormat:@"%ld天%ld时",(long)day,(long)hour];
    }else
        if (day<1 && hour<1) {
            lishi = [NSString stringWithFormat:@"%ld分",(long)minte];
            
        }else
            if (day<1) {
                lishi = [NSString stringWithFormat:@"%ld时%ld分",(long)hour,(long)minte];
            }
    
    return lishi;
}


+(NSString *)md5To16:(NSString *)md5str{
    if (md5str.length==32) {
        
        return [md5str substringWithRange:NSMakeRange(8, 16)];
    }else{
        return md5str;
        
    }
}

+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    if (!JSONString) {
        return nil;
    }
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
@end
