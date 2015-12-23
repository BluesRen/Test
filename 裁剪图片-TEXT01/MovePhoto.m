//
//  MovePhoto.m
//  裁剪图片-TEXT01
//
//  Created by Apple on 15/12/21.
//  Copyright © 2015年 Sayimo. All rights reserved.
//

#import "MovePhoto.h"
#import "ToolClass.h"
#import "mainViewController.h"
#define BIG_SIZE [UIScreen mainScreen].bounds
#define K_NUM 90
@interface MovePhoto ()
{
    UIImageView * _showImg;
    UIImageView * _colorImg;
    UIImageView * _colorIMG2;
}
@end

@implementation MovePhoto

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{

    _showImg                                     = [ToolClass createImageViewWithFrame:CGRectMake(0,  BIG_SIZE.size.height, BIG_SIZE.size.width, BIG_SIZE.size.height) andImage:nil andIsRadio:NO];
    _showImg.image                               = _TellImage;
    _showImg.contentMode                         = UIViewContentModeScaleAspectFit;

    UIButton * bbbb                              = [ToolClass createBtnWithFrame:CGRectMake(0, BIG_SIZE.size.height-30, 60, 30) image:nil target:self action:@selector(back:) title:@"返回" backimge:nil];
    [bbbb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIButton * aaaa                              = [ToolClass createBtnWithFrame:CGRectMake(260, BIG_SIZE.size.height-30, 60, 30) image:nil target:self action:@selector(clickok:) title:@"确定" backimge:nil];
    [aaaa setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    UIScrollView * scrollViewImg                 = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollViewImg.contentSize                    = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*3);
    scrollViewImg.contentOffset                  = CGPointMake(0, BIG_SIZE.size.height);
    scrollViewImg.showsVerticalScrollIndicator   = NO;
    scrollViewImg.showsHorizontalScrollIndicator = NO;
    scrollViewImg.backgroundColor=[UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets    = NO;


    _colorImg                                    = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, BIG_SIZE.size.height/2-K_NUM/2)];
    _colorImg.backgroundColor=[UIColor blackColor];
    _colorImg.alpha                              = 0.6;


    _colorIMG2                                   = [[UIImageView alloc]initWithFrame:CGRectMake(0,BIG_SIZE.size.height/2+K_NUM/2, [UIScreen mainScreen].bounds.size.width, BIG_SIZE.size.height/2-K_NUM/2)];
    _colorIMG2.backgroundColor=[UIColor blackColor];
    _colorIMG2.alpha                             = 0.6;


    [self.view addSubview:bbbb];
    [self.view addSubview:aaaa];
    [self.view addSubview:scrollViewImg];
    [self.view sendSubviewToBack:scrollViewImg];
    [scrollViewImg addSubview:_showImg];
    [self.view addSubview:_colorImg];
    [self.view addSubview:_colorIMG2];
//    [self.view insertSubview:aaaa aboveSubview:scrollViewImg];
//    [self.view insertSubview:bbbb aboveSubview:scrollViewImg];

}

- (void)back:(UIButton *)bbb{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickok:(UIButton*)btc{
    UIImage * newImg                             = [self captureScreen];
    //保存到相册
    UIImageWriteToSavedPhotosAlbum([self captureScreen], nil, nil, nil);
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    UIImage * okimg                              = [MovePhoto imageWithImageSimple:newImg scaledToSize:CGSizeMake(320, 90)];
    UIImageView * img                            = [[UIImageView alloc]initWithFrame:CGRectMake(0, 400, 320, 90)];
    img.image                                    = okimg;
    NSLog(@"newImg                               = %@",okimg);
    UIButton * bbbb                              = [ToolClass createBtnWithFrame:CGRectMake(0, BIG_SIZE.size.height-30, 60, 30) image:nil target:self action:@selector(backaaa:) title:@"返回" backimge:nil];
    [self.view addSubview:img];
    [self.view addSubview:bbbb];
}

- (UIImage *) captureScreen {
    CGRect rect                                  = self.view.frame;
    //这里只能改变高度。。。其它的。。无能为力
//    CGRect newRect = CGRectMake(0, 220, [UIScreen mainScreen].bounds.size.width, 90);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context                         = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *img                                 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGRect rect1                                 = CGRectMake(0, BIG_SIZE.size.height/2-K_NUM/2, [UIScreen mainScreen].bounds.size.width, 90);
    UIImage * imgeee                             = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([img CGImage], rect1)];
    return imgeee;
}


- (void)backaaa:(UIButton*)btn{
    mainViewController * vc                      = [[mainViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);

    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

    UIImage* newImage                            = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

@end
