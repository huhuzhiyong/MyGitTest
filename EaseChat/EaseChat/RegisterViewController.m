//
//  RegisterViewController.m
//  EaseChat
//
//  Created by 常彪 on 16/3/17.
//  Copyright © 2016年 0xcb. All rights reserved.
//

#import "RegisterViewController.h"
//#import "ASIFormDataRequest.h"
#import "RequestManager.h"
#import "MBProgressHUD.h"
#import "NSString+Hash.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextFeild;

@end

@implementation RegisterViewController

- (IBAction)registerButtonClick:(UIButton *)sender
{
    //验证用户名是否填写
    NSString *user = self.usernameTextField.text;
    if (user==nil || user.length<1) {
//        Alert
        return;
    }
    //验证两次输入的密码是否相同
    NSString *pw = self.passwordTextFeild.text;
    NSString *rePw = self.rePasswordTextFeild.text;
    if (pw==nil || rePw==nil || pw.length<1 || rePw.length<1) {
        //Alert
        return;
    }
    if (![pw isEqualToString:rePw]) {
        //Alert
        return;
    }
//    显示进度
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    
  MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:win animated:YES];
    hud.labelText = @"正在注册";
    hud.labelColor = [UIColor redColor];
    hud.detailsLabelText = @"请稍等等...";
    //请求
    [[RequestManager sharedManager] formRequest:^(ASIFormDataRequest *formRequest) {
        //设置请求参数
        [formRequest addPostValue:@"ST_R" forKey:@"command"];
        [formRequest addPostValue:user forKey:@"name"];
                //          TODO: sha1加密
        [formRequest addPostValue:[pw md5String] forKey:@"psw"];
    } completionHandler:^(id json, NSError *reqErr) {
        //处理解析好的json，和可能的错误
        NSLog(@"json === %@", json);
        NSLog(@"error === %@", reqErr);
        NSString *result = [json objectForKey:@"result"];
        if (result && [result isEqualToString:@"1"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            
        }
//        隐藏指示器
        [MBProgressHUD hideHUDForView:win animated:YES];
//        [MBProgressHUD HUDForView:win];
        
//        [self performSegueWithIdentifier:@"gotohead" sender:self];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
