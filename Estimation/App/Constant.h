//
//  Constant.h
//  Estimation
//
//  Created by zhanghong on 16/4/21.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject

#define RGBColor(r ,g ,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0f]
#define RandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0f]

@end
