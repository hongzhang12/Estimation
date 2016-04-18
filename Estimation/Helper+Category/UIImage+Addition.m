//
//  UIImage+Addition.m
//  Estimation
//
//  Created by zhanghong on 16/4/18.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, RGBColor(60, 176, 247).CGColor);
    
    CGRect rect = CGRectZero;
    rect.size = size;
    CGContextFillRect(ctx, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
