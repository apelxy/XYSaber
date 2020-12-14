//
//  XYToast.h
//  XYKit
//
//  Created by lxy on 2020/12/11.
//  Copyright © 2020 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYToast : NSObject
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) int durationTime;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL fullScreen;


- (void)showInView:(UIView *)aView;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
