//
//  UITextField+XY.m
//  XYKit
//
//  Created by ios on 2019/5/8.
//  Copyright © 2019 lxy. All rights reserved.
//

#import "UITextField+XY.h"

@implementation UITextField (XY)
-(void)setLeftGap:(CGFloat)leftGap{
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftGap, 0)];
    self.leftViewMode = UITextFieldViewModeAlways;
}
@end
