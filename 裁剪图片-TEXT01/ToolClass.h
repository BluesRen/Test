//
//  ToolClass.h
//  裁剪图片-TEXT01
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 Sayimo. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ToolClass : NSObject

+ (void)createAlertViewWithTitle:(NSString*)title Message:(NSString *)messgae andDelegate:(UIViewController *)delegate;


+ (UIButton *)createBtnWithFrame:(CGRect)frame image:(UIImage*)image target:(id)target action:(SEL)action title:(NSString*)title backimge:(UIImage*)backimage;

+ (UILabel *)createLaberWithFrame:(CGRect)frame fonSize:(CGFloat)size text:(NSString *)text textColor:(UIColor *)color aliment:(NSTextAlignment)aliment;

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame andImage:(NSString*)image andIsRadio:(BOOL)isRadius;
@end
