//
//  HeadViewController.m
//  EaseChat
//
//  Created by peter on 16/3/18.
//  Copyright © 2016年 0xcb. All rights reserved.
//

#import "HeadViewController.h"
#import "RequestManager.h"

@interface HeadViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation HeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)upbtn:(id)sender {
    
    NSLog(@"上传头像");
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    //[self presentModalViewController:picker animated:YES];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    self.imageview.image = image;

    
    [[RequestManager sharedManager ]uploadHeadImage:image ompletionHandler:^(id json, NSError *reqErr) {
        NSLog(@"json == %@",json);
        NSLog(@"error == %@",reqErr);
    }];
   // [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"用户取消");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



@end
