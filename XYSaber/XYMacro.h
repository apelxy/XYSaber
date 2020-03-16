//
//  XYKit.h
//  XYKit
//
//  Created by lxy on 2019/12/16.
//  Copyright © 2019 ios. All rights reserved.
//

#ifndef XYHeader_h
#define XYHeader_h

#define xy_kWidth [UIScreen mainScreen].bounds.size.width
#define xy_kHeight [UIScreen mainScreen].bounds.size.height

#define setWeakSelf  __weak typeof(self) weakSelf = self;

#define NSStringFromInt(A) [NSString stringWithFormat:@"%d",A]
#define NSStringFromInteger(A) [NSString stringWithFormat:@"%ld",A]
#define NSStringFromFloat(A) [NSString stringWithFormat:@"%f",A]

//typedef struct _Device{
//    CGFloat screenWidth;
//    CGFloat screenHeight;
//} Device;
//
//NS_INLINE Device device(){
//    Device d;
//    d.screenWidth = [UIScreen mainScreen].bounds.size.width;
//    d.screenHeight = [UIScreen mainScreen].bounds.size.height;
//    return d;
//}

#define XYLog(frmt, ...)   \
do {  \
NSLog(@"【XYKit】%@", [NSString stringWithFormat:frmt,##__VA_ARGS__]);  \
} while(0)

#endif /* XYHeader_h */
