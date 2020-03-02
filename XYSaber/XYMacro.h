//
//  XYHeader.h
//  XYSaber
//
//  Created by lxy on 2019/12/19.
//  Copyright © 2019 ios. All rights reserved.
//

#ifndef XYMacro_h
#define XYMacro_h

#define xy_kwidth [UIScreen mainScreen].bounds.size.width
#define xy_kheight [UIScreen mainScreen].bounds.size.height

#define setWeakSelf  __weak typeof(self) weakSelf = self;

#define NSStringFromInt(A) [NSString stringWithFormat:@"%d",A]
#define NSStringFromInteger(A) [NSString stringWithFormat:@"%ld",A]
#define NSStringFromFloat(A) [NSString stringWithFormat:@"%f",A]


#endif /* XYHeader_h */
