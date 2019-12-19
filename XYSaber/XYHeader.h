//
//  XYHeader.h
//  XYSaber
//
//  Created by lxy on 2019/12/19.
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

#endif /* XYHeader_h */
