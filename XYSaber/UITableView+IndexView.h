//
//  UITableView+Index.h
//  XYKitDemo
//
//  Created by lxy on 2019/12/23.
//  Copyright © 2019 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (IndexView)
-(void)setIndexViewWithSize:(CGSize)size itemCount:(NSInteger)itemCount  layoutHandler:(void(^)(UIView *indexView,NSArray<UIView*>* items))layoutHandler actionHandler:(void(^)(NSInteger index))actionHandler;
@end

NS_ASSUME_NONNULL_END
