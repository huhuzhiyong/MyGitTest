//
//  ViewController.m
//  EaseChat
//
//  Created by 常彪 on 16/3/17.
//  Copyright © 2016年 0xcb. All rights reserved.
//
/*
  清楚编译过程中产生的数据
  打开xcode,找到xcode的偏好设置，location＝》Derived Data,找到xcode打开工程后衍生的路径，把Derived Data文件夹删除
 base64 ：是用基本的64个字符来表示所有的特殊的字符，为了传输中方便，
          ios7之后NSData有Base64相关的编码方法
          ios7之前，就要自己实现，关键字：From: http://www.cocoadev.com/index.pl?BaseSixtyFour
 
 URL编码： 是处理url中包含的中文，特殊字符，和保留的一些符号。当作参数传给服务器时，要做的编码。
 
 ViewController之间不要addSubview
   1：最好不要使用ViewController之间的addSubView这样的方式
   2：把ViewController之间建立联系，让subview的ViewController作为childviewcontroller
    UIViewController *childVC = nil;
    [self.view addSubview:childVC.view];
    [self addChildViewController:childVC];
    [childVC didMoveToParentViewController:self];
 图片上传
 登录token
   为了让服务器识别是哪一个用户操作
 
 密码需要做不可旅的加密处理：md5.sha1；
 
 
 //  限制带宽，每秒钟的字节数，模拟不同网速
 [ASIFormDataRequest setMaxBandwidthPerSecond:8];
 
 头像上传
 */


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //在代码中执行指定的过渡效果
    [self performSegueWithIdentifier:@"gotoLogin" sender:self];
    
    NSString *str = @"hello world";
    //base64编码,需要先转成nsdata
   NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
   NSString *base64EncodeStr = [data base64Encoding];
    NSLog(@"base64编码后的结果%@",base64EncodeStr);
    
//    解码base64字符串
    NSData *base64DecodeData = [[NSData alloc]initWithBase64Encoding:base64EncodeStr];
    
    NSLog(@"解码后的结果%@",base64DecodeData);
    NSString *decodeStr = [[NSString alloc]initWithData:base64DecodeData encoding:NSUTF8StringEncoding];
    NSLog(@"解码后的结果转成字符串%@",decodeStr);
    
    NSString *urlStr = @"http://www.baidu.com/s?q=<>:/?中=文";
//    要做 URL 编码
//    如果只是去除中文是比较简单的
   // urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    不能对整个url做全面的url编码
//    只能支队参数的value进行url编码
//  NSString *paremValue = @"<>:/?中=文";
//    第三个参数：要保留不被编码的字符
//    第四个参数：要处理进行url编码
   urlStr = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlStr, CFSTR("要保留的字符"), CFSTR("要做转换的字符 <>:/?="), kCFStringEncodingUTF8));
    
//   urlStr = [urlStr ]
   NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"url == %@",url);
    
//    UIViewController *childVC = nil;
//    [self.view addSubview:childVC.view];
//    [self addChildViewController:childVC];
//    [childVC didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
