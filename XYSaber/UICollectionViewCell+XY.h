//
//  UICollectionViewCell+XY.h
//  XYKit
//
//  Created by lxy on 2019/1/16.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XYCollectionCellTransBlock)(id parameter);

@interface UICollectionViewCell (XY)
@property (nonatomic,copy) XYCollectionCellTransBlock dataBlock;
@property (nonatomic,copy) XYCollectionCellTransBlock backBlock;

@end


