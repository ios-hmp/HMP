//
//  AppManager.h
//  CommonProject
//
//  Created by mac on 2016/12/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ISDIC(par) [par isKindOfClass:[NSDictionary class]]
#define ISSTR(par) [par isKindOfClass:[NSString class]]


@interface AppManager : NSObject

typedef void(^TouchEvent)(id value);

+(UIViewController *)getVCInBoard:(NSString *)bord ID:(NSString *)idd;
+(NSString *)getCurrentTimeStrWithformat:(NSString *)format;
+(BOOL)writeObject:(id)object toDocDirWithName:(NSString *)name;
+ (NSString*)documentDirectoryPath;
+(NSDate *)dateFromString:(NSString *)str format:(NSString *)format;
+(NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

+(void)logJsonStr:(NSDictionary *)dic;
+(void)formatJsonStr:(NSString *)jsonStr;
+(void)outputProperty:(NSDictionary *)dic;
+(NSString *)md5To16:(NSString *)md5str;
+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString ;
+(NSString *)costTimeStrWithMinute:(NSInteger)minute;

@end
