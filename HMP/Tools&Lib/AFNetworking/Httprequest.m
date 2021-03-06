//
//  Httprequest.h
//  CommonProject
//
//  Created by hcb on 16-12-21.
//  Copyright (c) 2016年 zrgg. All rights reserved.
//

#import "Httprequest.h"
#import "LoadingView.h"
#import "MJExtension.h"
#import "AppManager.h"

#import "AppDelegate.h"

static Httprequest* _request;
static AFHTTPSessionManager *manager;

@implementation Httprequest
+(id)share{
    if (!_request) {
        _request = [[Httprequest alloc]init];
        
        
    }
    return _request;
}
+(AFHTTPSessionManager *)shareSessionManger{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
    });
    return manager;
    
}
//get请求
-(void)getObjectByUrl:(NSString *)string andComplain:(returnObject)complain andError:(returnError)Error{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.manager = [Httprequest shareSessionManger];
    //第二步，设置头文件
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString* url = [NSString stringWithFormat:@"%@",(string)];
    //    NSString* urlString = [self getURLByString:url];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        complain(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //状态栏旁边的菊花停止
        Error(error);
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
}

//post请求 
-(void)postObjectByParameters:(id)parameters andUrl:(NSString *)urlString showLoading:(BOOL)showLoading showMsg:(BOOL)showMsg isFullUrk:(BOOL)isFull andComplain:(returnObject)complain andError:(returnError)Error{
    //状态栏旁边的菊花转动
    NSString *uuSTRing = [NSString stringWithFormat:@"%@",isFull?urlString: BASE_URL(urlString)];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.manager = [Httprequest shareSessionManger];
    self.manager.requestSerializer.timeoutInterval = 10;
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",@"application/javascript", nil];//
    NSLog(@"请求地址：%@ ,\n请求参数：%@",uuSTRing,parameters);
    
    
    if (showLoading) {
        [LoadingView showLoading];
    }
    NSMutableDictionary *dic = parameters;
    [self.manager POST:uuSTRing parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [LoadingView stopLoading];
                //状态栏旁边的菊花停止
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        //向loger视图打印log
        NSDictionary *dd = responseObject;
        if (dd) {
            
            NSLog(@"【%@】返回结果：",urlString);
            [AppManager formatJsonStr:[dd mj_JSONString]];
            NSString *mmsg = dd[@"msg"];
            if (showMsg && ![mmsg isEqual:[NSNull null]] && mmsg.length>0) {
                [LoadingView showAMessage:mmsg];
            }
        }
        
        if ([dd isKindOfClass:[NSDictionary class]]) {
            [self handleServerMsg:dd];
            complain(responseObject);
        }else{
            Error(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code==3840) {
            NSLog(@"Json解析出错");
        }else{
            NSLog(@"其他错误：%@",error);
        }
        if (Error) {
            Error(error);
        }
        [LoadingView stopLoading];
        [LoadingView showAMessage:[NSString stringWithFormat:@"出错了：%ld",(long)error.code]];
        
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
    
    
}

- (void)handleServerMsg:(NSDictionary *)info{
    //登录失效，清楚信息，退出环信
    NSString *msg = info[@"msg"];
    if ([msg containsString:@"失效"]) {
        [[CBUser share] logout];
    }else if([msg containsString:@"请先补充信息"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"fillInfo" object:nil];
    }
}

//post上传文件
-(void)postFileKey:(NSString *)fileKey file:(id)file andUrl:(NSString *)urlString showLoading:(BOOL)showLoading showMsg:(BOOL)showMsg isFullUrk:(BOOL)isFull andComplain:(returnObject)complain andError:(returnError)Error{
    //状态栏旁边的菊花转动
    NSString *uuSTRing = [NSString stringWithFormat:@"%@",isFull?urlString: BASE_URL(urlString)];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.manager = [Httprequest shareSessionManger];
    self.manager.requestSerializer.timeoutInterval = 10;
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",@"application/javascript", nil];//
    NSLog(@"请求地址：%@ ,\n请求参数：%@",uuSTRing,fileKey);
    if (showLoading) {
        [LoadingView showLoading];
    }
    [self.manager POST:uuSTRing parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if(file==nil) ;else{
            
            NSString *timeStr = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
            
            NSString *name = [NSString stringWithFormat:@"%@.png",timeStr];
            [formData appendPartWithFileData:file name:fileKey fileName:name mimeType:@"image/png"];//picurl
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //向loger视图打印log
        NSDictionary *dd = responseObject;
        
        NSLog(@"【%@】返回结果：",urlString);
        [AppManager formatJsonStr:[dd mj_JSONString]];
        NSString *mmsg = dd[@"msg"];
        if (showMsg && ![mmsg isEqual:[NSNull null]] && mmsg.length>0) {
            [LoadingView showAMessage:mmsg];
        }
        if ([dd isKindOfClass:[NSDictionary class]]) {
            complain(responseObject);
        }else{
            Error(responseObject);
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LoadingView stopLoading];
            //状态栏旁边的菊花停止
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (Error) {
            Error(error);
        }
        [LoadingView stopLoading];
        [LoadingView showAMessage:[NSString stringWithFormat:@"网络错误：%ld",(long)error.code]];
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

-(void)handleStr:(NSString *)str{
    NSArray *larr = [str componentsSeparatedByString:@"{"];
    NSMutableString *tmpstr = [NSMutableString string];
    for (NSString *sstr  in larr) {
        NSMutableString *lls = [NSMutableString stringWithString:sstr];
        [lls insertString:@"\n\t" atIndex:0];
        
        [tmpstr appendString:lls];
    }
    NSLog(@"%@",tmpstr);
    
    for (NSString *sstr  in larr) {
        NSRange r1 = [sstr rangeOfString:@"}"];
        if (r1.location != NSNotFound) {
            
        }
    }
}
//上传图片
-(void)postImageByUrl:(NSString*)url withParameters:(NSDictionary*)parameters andImageData:(NSData*)imageData imageKey:(NSString *)imageKey andComplain:(returnObject)complain andError:(returnError)Error{
    //状态栏旁边的菊花指示器转动
    dispatch_async(dispatch_get_main_queue(), ^{
        [LoadingView showLoading];
    });
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString* url2 = [NSString stringWithFormat:@"%@",BASE_URL(url)];
    [self.manager POST:url2 parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if(imageData==nil) ;else{
            
            NSString *timeStr = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
            
            NSString *name = [NSString stringWithFormat:@"%@.png",timeStr];
            [formData appendPartWithFileData:imageData name:imageKey fileName:name mimeType:@"image/png"];//picurl
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complain(responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            [LoadingView stopLoading];
        });
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Error(error);
        NSLog(@"%@",error);
        
        [LoadingView stopLoading];
        if (error.code==-1009) {
            [LoadingView showAMessage:@"网络连接似乎不太好"];
        }else{
            [LoadingView showAMessage:@"请求失败"];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

//取消请求
-(void)cancelRequest{
    
    [self.manager.operationQueue cancelAllOperations];
}

-(void)postMany:(NSDictionary *)argvs andUrl:(NSString *)url andComplain:(void (^)(id obj, NSError *error))block minetype:(NSString *)mtype{
    
    [Httprequest shareSessionManger];
    
    [LoadingView showLoading];
    NSString* urlSstring = [NSString stringWithFormat:@"%@",BASE_URL(url)];
    
    //NSLog(@" %@   %@",urlSstring,argvs);
    //状态栏旁边的菊花指示器转动
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //将数据处理及网络请求放在后台执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
        NSMutableDictionary *images = [[NSMutableDictionary alloc] initWithCapacity:0];
        for(NSString *key in [argvs allKeys]){
            
            id obj = [argvs objectForKey:key];
            if(![obj isKindOfClass:[NSArray class]]){
                [parameters setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }else{
                NSArray *arr = obj;
                for (int i = 0; i < arr.count; i ++) {
                    [images setObject:arr[i] forKey:[@(i) stringValue]];
                }
            }
            
        }
        
        NSLog(@"%@",parameters);
        
        
        [self.manager POST:urlSstring parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            int theidnexx = 1;
            
            
            for(NSString *key in [images allKeys]){
                NSData* obj = [images objectForKey:key];
                
                
                NSString *timeStr = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
                
                NSString *fix = [mtype componentsSeparatedByString:@"/"].lastObject;
                if (fix.length<1) {
                    fix = @"png";
                }
                NSString *name = [NSString stringWithFormat:@"%@-%d.%@",timeStr,theidnexx,fix];
                [formData appendPartWithFileData:obj name:@"file" fileName:name mimeType:@"multipart/form-data"];//picurl
                //                @"image/png"
                
                theidnexx++;
                
            }
            
            
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            block(responseObject,nil);
            NSLog(@"%@",responseObject);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [LoadingView stopLoading];
            });
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(nil,error);
            NSLog(@"%@",error);
            
            [LoadingView stopLoading];
            if (error.code==-1009) {
                [LoadingView showAMessage:@"网络连接似乎不太好"];
            }else{
                [LoadingView showAMessage:@"请求失败"];
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }];
        
        
        
        
    });
}




+ (NSString *)postRequestWithURL: (NSString *)url  // IN
                      postParems: (NSMutableDictionary *)postParems // IN
                     picFilePath: (NSString *)picFilePath  // IN
                     picFileName: (NSString *)picFileName;  // IN
{
    
    
    NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BASE_URL(url)]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //得到图片的data
    NSData* data;
    if(picFilePath){
        
        UIImage *image=[UIImage imageWithContentsOfFile:picFilePath];
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            data = UIImagePNGRepresentation(image);
        }else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(image, 1.0);
        }
    }
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [postParems allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[postParems objectForKey:key]];
        
        //NSLog(@"添加字段的值==%@",[postParems objectForKey:key]);
    }
    
    if(picFilePath){
        ////添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        
        //声明pic字段，文件名为boris.png
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=%@\r\n",@"pic[]",picFileName];
        //声明上传文件的格式
        [body appendFormat:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
    }
    
    
    
    
    {
        
        NSMutableDictionary *images = [[NSMutableDictionary alloc] initWithCapacity:0];
        for(NSString *key in [postParems allKeys]){
            
            id obj = [postParems objectForKey:key];
            if(![obj isKindOfClass:[NSArray class]]){
                
            }else{
                NSArray *arr = obj;
                for (int i = 0; i < arr.count; i ++) {
                    [images setObject:arr[i] forKey:key];
                }
            }
            
        }
        int theidnexx;
        for(NSString *key in [images allKeys]){
            //            NSData* obj = [images objectForKey:key];
            
            
            NSString *timeStr = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
            
            NSString *name = [NSString stringWithFormat:@"%@-%d.png",timeStr,theidnexx];
            
            
            ////添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            
            //声明pic字段，文件名为boris.png
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=%@\r\n",@"file[]",name];
            //声明上传文件的格式
            [body appendFormat:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
            
            theidnexx++;
            
        }
        
    }
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    if(picFilePath){
        //将image的data加入
        [myRequestData appendData:data];
    }
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    
    NSHTTPURLResponse *urlResponese = nil;
    NSError *error = [[NSError alloc]init];
    NSData* resultData = [NSURLConnection sendSynchronousRequest:request   returningResponse:&urlResponese error:&error];
    NSString* result= [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    //        if([urlResponese statusCode] >=200&&[urlResponese statusCode]<<span style="margin: 0px; padding: 0px; font-family: 'Courier New'; color: rgb(128, 0, 128);">300){
    //                 //NSLog(@"返回结果=====%@",result);
    return result;
    //            }
    return nil;
}



@end
