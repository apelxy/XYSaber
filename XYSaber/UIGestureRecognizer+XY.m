//
//  UIGestureRecognizer+XY.m
//  XYKit
//
//  Created by lxy on 2020/3/10.
//  Copyright © 2020 ios. All rights reserved.
//

#import "UIGestureRecognizer+XY.h"
#import <objc/runtime.h>
static NSString *tag_id = nil;
@implementation UIGestureRecognizer (XY)
-(void)setTag:(NSString *)tag{
    objc_setAssociatedObject(self, &tag_id, tag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)tag{
    return objc_getAssociatedObject(self, &tag_id);
}
@end
