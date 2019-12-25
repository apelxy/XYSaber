//
//  UICollectionViewCell+XY.m
//  XYKit
//
//  Created by lxy on 2019/1/16.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "UICollectionViewCell+XY.h"
#import <objc/runtime.h>
static XYCollectionCellTransBlock backBlock_id = nil;
static XYCollectionCellTransBlock dataBlock_id = nil;
@implementation UICollectionViewCell (XY)
-(void)setDataBlock:(XYCollectionCellTransBlock)dataBlock{
    objc_setAssociatedObject(self, &dataBlock_id, dataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(XYCollectionCellTransBlock)dataBlock{
    return objc_getAssociatedObject(self, &dataBlock_id);
}

-(void)setBackBlock:(XYCollectionCellTransBlock)backBlock{
    objc_setAssociatedObject(self, &backBlock_id, backBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(XYCollectionCellTransBlock)backBlock{
    return objc_getAssociatedObject(self, &backBlock_id);
}
@end
