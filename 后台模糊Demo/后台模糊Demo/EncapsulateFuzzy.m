//
//  EncapsulateFuzzy.m
//  后台模糊Demo
//
//  Created by fangfang on 15/4/17.
//  Copyright (c) 2015年 Fangfang. All rights reserved.
//

#import "EncapsulateFuzzy.h"
#import "UIImage+Fuzzy.h"

#define sW ([UIScreen mainScreen].bounds.size.width)
#define sH ([UIScreen mainScreen].bounds.size.height)
#define sS ([UIScreen mainScreen].scale)

#define effectTag 19999


@implementation EncapsulateFuzzy

+(void)addFuzzy
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.tag = effectTag;
    imageView.image = [self blurImage];
    [[[UIApplication sharedApplication] keyWindow] addSubview:imageView];
}
+(void)removeFuzzy
{
    NSArray *subViews = [[UIApplication sharedApplication] keyWindow].subviews;
    for (id object in subViews) {
        if ([[object class] isSubclassOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)object;
            if(imageView.tag == effectTag)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    imageView.alpha = 0;
                    [imageView removeFromSuperview];
                }];
                
            }
        }
    }
}


//毛玻璃效果
+(UIImage *)blurImage
{
    UIImage *image = [[self screenShot] imageWithFuzzy];
    //保存图片到照片库(test)
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}
//屏幕截屏
+(UIImage *)screenShot
{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sW*sS, sH*sS), YES, 0);
    //设置截屏大小
    [[[[UIApplication sharedApplication] keyWindow] layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, sW*sS,sH*sS);
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    return sendImage;
}


@end
