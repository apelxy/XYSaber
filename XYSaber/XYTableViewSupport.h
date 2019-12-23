//
//  UITableViewSupport.h
//  XYKit
//
//  Created by ios on 2019/4/18.
//  Copyright © 2019 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef CGFloat(^XYTableViewHeightOfSectionHeaderBlock)(UITableView *tableView,NSInteger section);//section头视图高度
typedef CGFloat(^XYTableViewHeightOfSectionFooterBlock)(UITableView *tableView,NSInteger section);//section尾视图高度
typedef UIView*(^XYTableViewSectionHeaderBlock)(UITableView *tableView,NSInteger section);//section头视图
typedef UIView*(^XYTableViewSectionFooterBlock)(UITableView *tableView,NSInteger section);//section尾视图
typedef NSInteger(^XYTableViewRowNumBlock)(UITableView *tableView,NSInteger section);//行数
typedef CGFloat(^XYTableViewHeightForRowBlock)(UITableView *tableView,NSIndexPath *indexPath);//行高
typedef UITableViewCell*(^XYTableViewCellBlock)(UITableView *tableView,NSIndexPath *indexPath);//cell
typedef void(^XYTableViewSelectedBlock)(UITableView *tableView,NSIndexPath *indexPath);//触发点击


@interface XYTableViewSupport : NSObject
@property (nonatomic,assign) NSInteger numOfSection;
@property (nonatomic,copy) XYTableViewHeightOfSectionHeaderBlock heightOfSectionHeaderHandler;
@property (nonatomic,copy) XYTableViewHeightOfSectionFooterBlock heightOfSectionFooterHandler;
@property (nonatomic,copy) XYTableViewSectionHeaderBlock sectionHeaderHandler;
@property (nonatomic,copy) XYTableViewSectionFooterBlock sectionFooterHandler;
@property (nonatomic,copy) XYTableViewRowNumBlock numOfRowsHandler;
@property (nonatomic,copy) XYTableViewHeightForRowBlock heightForRowHandler;
@property (nonatomic,copy) XYTableViewCellBlock cellHandler;
@property (nonatomic,copy) XYTableViewSelectedBlock selectedHandler;

-(CGFloat)indexPathHeight:(NSIndexPath*)indexPath;

@end


