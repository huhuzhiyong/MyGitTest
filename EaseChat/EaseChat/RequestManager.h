//
//  RequestManager.h
//  EaseChat
//
//  Created by 常彪 on 16/3/17.
//  Copyright © 2016年 0xcb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

//管理所有的请求
//处理响应数据（做解析）
@interface RequestManager : NSObject
@property (nonatomic,copy)   NSString *token;
+ (instancetype)sharedManager;

//创建请求，把传参交给调用者，并且把响应之后的数据解析后交给调用者，进行UI的刷新
- (void)formRequest:(void(^)(ASIFormDataRequest *formRequest))setupRequest completionHandler:(void(^)(id json, NSError *reqErr))completion;
//上传头像，url改变了，需要把参数放在URL里面
//post的body是完整的图片数据
- (void)uploadHeadImage:(UIImage *)image ompletionHandler:(void(^)(id json, NSError *reqErr))completion;



@end
