//
//  XYButtonSupport.h
//  XYKit
//
//  Created by ios on 2019/4/23.
//  Copyright © 2019 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XYButtonSupport : NSObject
@property (nonatomic,copy) void(^action)(UIButton *button);
@end


