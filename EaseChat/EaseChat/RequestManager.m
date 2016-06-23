
//
//  RequestManager.m
//  EaseChat
//
//  Created by 常彪 on 16/3/17.
//  Copyright © 2016年 0xcb. All rights reserved.
//

#import "RequestManager.h"

//1. 发请求
//2. 接收数据
//3. 解析数据
//4. 更新UI

static RequestManager *gSharedRequestManager = nil;

@interface RequestManager ()
{
    NSString *_servIp;
    NSString *_servPort;
//    NSOperationQueue *_queue;
}
@end


@implementation RequestManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gSharedRequestManager = [[[self class] alloc] init];
    });
    return gSharedRequestManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _servIp = @"127.0.0.1";
        _servPort = @"8080";
//  限制带宽，每秒钟的字节数
//        [ASIFormDataRequest setMaxBandwidthPerSecond:1024*2];
    }
    return self;
}

- (void)formRequest:(void(^)(ASIFormDataRequest *formRequest))setupRequest completionHandler:(void(^)(id json, NSError *reqErr))completion;
{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@:%@/st/s", _servIp, _servPort];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIFormDataRequest *form = [ASIFormDataRequest requestWithURL:url];
    //把创建的form请求传给调用者，设置参数
    setupRequest(form);
    
    __weak ASIFormDataRequest *weakForm = form;
    //设置请求完成时的block
    [form setCompletionBlock:^{
        //解析数据
        NSError *err = nil;
        id json = [NSJSONSerialization JSONObjectWithData:weakForm.responseData options:NSJSONReadingMutableContainers error:&err];
        //解析完成传回给调用者
        completion(json, err);
    }];
    //请求失败也要处理
    [form setFailedBlock:^{
        completion(nil, weakForm.error);
        
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            <#code to be executed once#>
//        });
    }];
    //发请求
    [form startAsynchronous];
    
}

- (void)uploadHeadImage:(UIImage *)image ompletionHandler:(void(^)(id json, NSError *reqErr))completion;
{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@:%@/st/s?command=ST_H&access_token=", _servIp, _servPort];
    urlStr = [urlStr stringByAppendingString:self.token];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.postBody = [UIImageJPEGRepresentation(image, 0.7f)mutableCopy];
   
    __weak ASIFormDataRequest *weakForm = request;
    [request setCompletionBlock:^{
        //解析数据
        NSError *err = nil;
        id json = [NSJSONSerialization JSONObjectWithData:weakForm.responseData options:NSJSONReadingMutableContainers error:&err];
        //解析完成传回给调用者
        completion(json, err);
    }];
    //请求失败也要处理
    [request setFailedBlock:^{
        completion(nil, weakForm.error);
        
        //        static dispatch_once_t onceToken;
        //        dispatch_once(&onceToken, ^{
        //            <#code to be executed once#>
        //        });
    }];
    
    [request startAsynchronous];
}





@end
