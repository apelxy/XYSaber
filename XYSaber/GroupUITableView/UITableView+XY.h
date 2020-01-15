//
//  UITableView+XY.h
//  XYUserTool
//
//  Created by lxy on 2019/1/11.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (XY)
-(void)xy_setDelegateHandlerNumOfSections:(NSInteger)numOfSection heightOfSectionHeaderHandler:(CGFloat(^)(UITableView *tableView,NSInteger section))heightOfSectionHeaderHandler heightOfSectionFooterHandler:(CGFloat(^)(UITableView *tableView,NSInteger section))heightOfSectionFooterHandler sectionHeaderHandler:(UIView*(^)(UITableView *tableView,NSInteger section))sectionHeaderHandler sectionFooterHandler:(UIView*(^)(UITableView *tableView,NSInteger section))sectionFooterHandler numOfRowsHandler:(NSInteger(^)(UITableView *tableView,NSInteger section))numOfRowsHandler heightForRowHandler:(CGFloat(^)(UITableView *tableView,NSIndexPath *indexPath))heightForRowHandler cellHandler:(UITableViewCell*(^)(UITableView *tableView,NSIndexPath *indexPath))cellHandler selectedHandler:(void(^)(UITableView *tableView,NSIndexPath *indexPath))selectedHandler;


-(CGFloat)xy_heightOfIndexPath:(NSIndexPath*)indexPath;

-(void)xy_scrollToBottomWithAnimated:(BOOL)animated;

@end


