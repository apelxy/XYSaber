//
//  UITableViewSupport.m
//  XYKit
//
//  Created by ios on 2019/4/18.
//  Copyright © 2019 lxy. All rights reserved.
//

#import "XYTableViewSupport.h"

@interface XYTableViewSupport ()
@property (nonatomic,strong) NSMutableDictionary *heightOfIndexPathDictionary;
@end

@implementation XYTableViewSupport


-(NSMutableDictionary*)heightOfIndexPathDictionary{
    if (!_heightOfIndexPathDictionary) {
        _heightOfIndexPathDictionary = [NSMutableDictionary dictionary];
    }
    return _heightOfIndexPathDictionary;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.numOfSection;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    XYTableViewRowNumBlock bl = self.numOfRowsHandler;
    return bl(tableView,section);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *heightString = self.heightOfIndexPathDictionary[[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
    return [heightString floatValue];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYTableViewHeightForRowBlock heightBl = _heightForRowHandler;
    CGFloat height = heightBl(tableView,indexPath);
    [self.heightOfIndexPathDictionary setObject:[NSString stringWithFormat:@"%f",height] forKey:[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
    
    
    XYTableViewCellBlock bl = self.cellHandler;
    return bl(tableView,indexPath);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYTableViewSelectedBlock bl = self.selectedHandler;
    if (bl) {
        bl(tableView,indexPath);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    XYTableViewHeightOfSectionHeaderBlock bl = self.heightOfSectionHeaderHandler;
    if (bl) {
        return bl(tableView,section);
    }
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    XYTableViewHeightOfSectionFooterBlock bl = self.heightOfSectionFooterHandler;
    if (bl) {
        return bl(tableView,section);
    }
    return 0.0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    XYTableViewSectionHeaderBlock bl = self.sectionHeaderHandler;
    if (bl) {
        return bl(tableView,section);
    }
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    XYTableViewSectionFooterBlock bl = self.sectionFooterHandler;
    if (bl) {
        return bl(tableView,section);
    }
    return nil;
}



-(CGFloat)indexPathHeight:(NSIndexPath*)indexPath{
    NSString *heightString = self.heightOfIndexPathDictionary[[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
    return [heightString floatValue];
}
@end
