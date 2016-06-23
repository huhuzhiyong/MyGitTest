//
//  LoginViewController.m
//  EaseChat
//
//  Created by 常彪 on 16/3/17.
//  Copyright © 2016年 0xcb. All rights reserved.
//

#import "LoginViewController.h"
#import "RequestManager.h"
#import "MBProgressHUD.h"
#import "NSString-Hash-master/NSString+Hash.h"
#define KEY_ACCESS_TOKEN @"access_token"

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    self.title = @"登 录";

//    [self.navigationItem setHidesBackButton:YES animated:NO];

}
- (IBAction)login:(id)sender {
    
    NSString *user = self.usernaem.text;
    NSString *pw = self.mima.text;
//    if (user == nil || user.length<1) {
////        TODO: Alert
//        return;
//    }
//    if (pw == nil || pw.length<1) {
//        //        TODO: Alert
//        return;
//    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RequestManager sharedManager]formRequest:^(ASIFormDataRequest *formRequest) {
         [formRequest  addPostValue:@"ST_L" forKey:@"command"];
        [formRequest addPostValue:user forKey:@"name" ];
//          TODO: sha1加密
        [formRequest addPostValue:[pw md5String] forKey:@"psw"];
    } completionHandler:^(id json, NSError *reqErr) {
        NSLog(@"json == %@",json);
        NSLog(@"error == %@",reqErr);
        NSString *access_token = [json objectForKey:KEY_ACCESS_TOKEN];
          NSLog(@"====%@",access_token);
        if (access_token) {
            NSUserDefaults *ud =   [NSUserDefaults standardUserDefaults];
            [ ud  setObject:access_token forKey:KEY_ACCESS_TOKEN];
            [ud synchronize];
            [RequestManager sharedManager].token =access_token;
        }
          [MBProgressHUD hideHUDForView:self.view animated:YES];
       // [self performSegueWithIdentifier:@"gotohead" sender:self];

    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
}


@end
