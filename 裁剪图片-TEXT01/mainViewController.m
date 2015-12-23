//
//  mainViewController.m
//  裁剪图片-TEXT01
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 Sayimo. All rights reserved.
//

#import "mainViewController.h"
#import "ToolClass.h"
#import "MovePhoto.h"
#define BIG_SIZE [UIScreen mainScreen].bounds.size
@interface mainViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView * _Photoimg;
    UIImageView * handFaceImgView;
    NSString * imagePathStr;
}
@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    UIButton * b                             = [ToolClass createBtnWithFrame:CGRectMake(BIG_SIZE.width/2-40, 400, 80, 40) image:nil target:self action:@selector(choicePhoto:) title:@"选择图片" backimge:nil];
    [self.view addSubview:b];
    b.backgroundColor                        = [UIColor lightGrayColor];
    b.alpha                                  = 0.7;


//    _Photoimg = [ToolClass createImageViewWithFrame:CGRectMake(0, 64, 320, 80) andImage:nil andIsRadio:NO];
//    _Photoimg.backgroundColor=[UIColor lightGrayColor];
//    _Photoimg.alpha=0.7;
//    [self.view addSubview:_Photoimg];



}

- (void)choicePhoto:(UIButton*)btn{
    UIActionSheet* actionSheet               = [[UIActionSheet alloc]
                                            initWithTitle:nil
                                            delegate:self
                                            cancelButtonTitle:@"取消"
                                            destructiveButtonTitle:nil
                                            otherButtonTitles:@"从手机相册选择",nil];
    [actionSheet showInView:self.view];

}

- (UIImageView*)frontView{

    CGSize winSize                           = CGSizeMake(1024, 768);
    UIImageView * Fview                      = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, winSize.width, winSize.height)];

    return Fview;
}


#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
    {   UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate                     = self;
    imagePicker.allowsEditing                = NO;
            //选择是否截取正方形
    imagePicker.sourceType                   = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];

        }
            break;
        default:
            break;
    }
}

#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image                          = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if ((picker.sourceType==UIImagePickerControllerSourceTypeCamera)) {
    NSLog(@"dic                              = %@",info);
    }
//    UIImage * newImage                   = [mainViewController imageWithImageSimple:image scaledToSize:CGSizeMake(BIG_SIZE.width, BIG_SIZE.height)];
//    NSLog(@"newImage = %@",newImage);

//    handFaceImgView.image                = newImage;
//    _Photoimg.image=newImage;





    NSInteger  headImageName                 = 112234;
    NSString * headImageNameStr              = [NSString stringWithFormat:@"/%zd.png",headImageName];
    NSUserDefaults * userDefaults            = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    [userDefaults setObject:headImageNameStr forKey:@"headImageNamePath"];
    imagePathStr                             = headImageNameStr;
    NSString * pathImg                       = [self saveImage:image WithName:headImageNameStr];



    [picker dismissViewControllerAnimated:YES completion:nil];
    MovePhoto * vc                           = [[MovePhoto alloc]init];

    vc.imagePathStr                          = pathImg;
    vc.TellImage                             = image;
    [self presentViewController:vc animated:NO completion:nil];

}
//
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);

    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

    UIImage* newImage                        = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}


#pragma mark 保存图片到document
- (NSString * )saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData                        = UIImagePNGRepresentation(tempImage);
    NSArray* paths                           = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory             = [paths lastObject];
    //  NSString* documentsDirectory         = [paths objectAtIndex:0];
    NSString* fullPathToFile                 = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
    return fullPathToFile;
//    HeaderImgIsChange = YES;
}

@end
