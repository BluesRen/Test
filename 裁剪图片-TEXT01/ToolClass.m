
//
//  ToolClass.m
//  裁剪图片-TEXT01
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 Sayimo. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass

+ (void)createAlertViewWithTitle:(NSString*)title Message:(NSString *)messgae andDelegate:(UIViewController *)delegate{
    UIAlertView * av =[ [UIAlertView alloc]initWithTitle:title message:messgae delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [av show];
}

+ (UILabel *)createLaberWithFrame:(CGRect)frame fonSize:(CGFloat)size text:(NSString *)text textColor:(UIColor *)color aliment:(NSTextAlignment)aliment
{
    UILabel * lab = [[UILabel alloc]initWithFrame:frame];
    lab.font=[UIFont systemFontOfSize:size];
    lab.text=text;
    lab.textColor=color;
    lab.textAlignment=aliment;
    return lab;
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame image:(UIImage *)image target:(id)target action:(SEL)action title:(NSString *)title backimge:(UIImage *)backimage{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


+ (UIImageView *)createImageViewWithFrame:(CGRect)frame andImage:(NSString *)image andIsRadio:(BOOL)isRadius

{
    UIImageView * i  =[[UIImageView alloc]initWithFrame:frame];
    i.image = [UIImage imageNamed:image];
    if (isRadius) {
        i.layer.masksToBounds = YES;
        i.layer.cornerRadius = frame.size.width/2;
    }
    
    return i;
}


@end
