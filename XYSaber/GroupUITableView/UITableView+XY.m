//
//  UITableView+XY.m
//  XYUserTool
//
//  Created by lxy on 2019/1/11.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "UITableView+XY.h"
#import <objc/runtime.h>
#import "XYTableViewSupport.h"




static XYTableViewSupport *support_id;

@interface UITableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) XYTableViewSupport *support;
@end

@implementation UITableView (XY)
-(void)setSupport:(XYTableViewSupport *)support{
    objc_setAssociatedObject(self, &support_id, support, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(XYTableViewSupport*)support{
    return objc_getAssociatedObject(self, &support_id);
}


-(void)xy_setDelegateHandlerNumOfSections:(NSInteger)numOfSection heightOfSectionHeaderHandler:(XYTableViewHeightOfSectionHeaderBlock)heightOfSectionHeaderHandler heightOfSectionFooterHandler:(XYTableViewHeightOfSectionFooterBlock)heightOfSectionFooterHandler sectionHeaderHandler:(XYTableViewSectionHeaderBlock)sectionHeaderHandler sectionFooterHandler:(XYTableViewSectionFooterBlock)sectionFooterHandler numOfRowsHandler:(XYTableViewRowNumBlock)numOfRowsHandler heightForRowHandler:(XYTableViewHeightForRowBlock)heightForRowHandler cellHandler:(XYTableViewCellBlock)cellHandler selectedHandler:(XYTableViewSelectedBlock)selectedHandler{
    
    
    
    XYTableViewSupport *support = [[XYTableViewSupport alloc]init];
    self.support = support;
    self.delegate = (id)self.support;
    self.dataSource = (id)self.support;
    
    self.support.numOfSection = numOfSection;
    self.support.heightOfSectionHeaderHandler = heightOfSectionHeaderHandler;
    self.support.sectionHeaderHandler = sectionHeaderHandler;
    self.support.heightOfSectionFooterHandler = heightOfSectionFooterHandler;
    self.support.sectionFooterHandler = sectionFooterHandler;
    self.support.numOfRowsHandler = numOfRowsHandler;
    self.support.heightForRowHandler = heightForRowHandler;
    self.support.cellHandler = cellHandler;
    self.support.selectedHandler = selectedHandler;
    
//    objc_setAssociatedObject(self, &sectionNumBlock_id, sectionNumBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    objc_setAssociatedObject(self, &heightOfSectionHeaderHandler_id, heightOfSectionHeaderHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    objc_setAssociatedObject(self, &sectionHeaderHandler_id, sectionHeaderHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    objc_setAssociatedObject(self, &heightOfSectionFooterHandler_id, heightOfSectionFooterHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    objc_setAssociatedObject(self, &sectionFooterHandler_id, sectionFooterHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    objc_setAssociatedObject(self, &rowNumBlock_id, numOfRowsHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    objc_setAssociatedObject(self, &heightForRowBlock_id, heightForRowHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    objc_setAssociatedObject(self, &cellBlock_id, cellHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    objc_setAssociatedObject(self, &selectedBlock_id, selectedHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CGFloat)xy_heightOfIndexPath:(NSIndexPath*)indexPath{
    return [self.support indexPathHeight:indexPath];
}

-(void)xy_scrollToBottomWithAnimated:(BOOL)animated{
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    
    NSInteger sectionNum = [self numberOfSections];
    NSInteger rowsNum = [self numberOfRowsInSection:sectionNum - 1];
    if (!rowsNum || !sectionNum) {
        return;
    }
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rowsNum - 1 inSection:sectionNum - 1] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}
@end
