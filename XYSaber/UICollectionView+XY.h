//
//  UICollectionView+XY.h
//  XYKit
//
//  Created by lxy on 2019/1/16.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCollectionHeaderView : UIView
@property (nonatomic,copy) NSString *reuseIdentifier;
-(instancetype)initWithHeight:(CGFloat)height reuseIdentifier:(NSString*)reuseIdentifier;
@end

@interface XYCollectionFooterView : UIView
@property (nonatomic,copy) NSString *reuseIdentifier;
-(instancetype)initWithHeight:(CGFloat)height reuseIdentifier:(NSString*)reuseIdentifier;
@end



typedef NSInteger(^XYCollectionSectionNumBlock)(UICollectionView *collectionView);

typedef XYCollectionHeaderView*(^XYCollectionHeaderBlock)(UICollectionView* collectionView,NSInteger section);
typedef CGFloat(^XYCollectionHeaderHeightBlock)(UICollectionView *collectionView,UICollectionViewLayout *collectionViewLayout,NSInteger section);
typedef XYCollectionFooterView*(^XYCollectionFooterBlock)(UICollectionView* collectionView,NSInteger section);
typedef CGFloat(^XYCollectionFooterHeightBlock)(UICollectionView *collectionView,UICollectionViewLayout *collectionViewLayout,NSInteger section);

typedef NSInteger(^XYCollectionItemNumBlock)(UICollectionView *collectionView,NSInteger section);
typedef CGFloat(^XYCollectionMinimumLineSpacingBlock)(UICollectionView* collectionView,UICollectionViewLayout *layout,NSInteger section);
typedef CGFloat(^XYCollectionMinimumInteritemSpacingBlock)(UICollectionView* collectionView,UICollectionViewLayout *layout,NSInteger section);
typedef CGSize(^XYCollectionItemSizeBlock)(UICollectionView* collectionView,UICollectionViewLayout *layout,NSIndexPath *indexPath);

typedef UICollectionViewCell*(^XYCollectionCellBlock)(UICollectionView* collectionView,NSIndexPath *indexPath);
typedef void(^XYCollectionDidSelectBlock)(UICollectionView* collectionView,NSIndexPath *indexPath);

@interface UICollectionView (XY)
-(void)xy_setDelegateWithHeaderHeight:(CGFloat)headerHeight registerCellIdArray:(NSArray*)registerCellIdArray numOfSectionBlock:(XYCollectionSectionNumBlock)numOfSectionBlock headerBlock:(XYCollectionHeaderBlock)headerBlock footerBlock:(XYCollectionFooterBlock)footerBlock numOfItemsBlock:(XYCollectionItemNumBlock)numOfItemBlock minimumInteritemSpacingBlock:(XYCollectionMinimumInteritemSpacingBlock)minimumInteritemSpacingBlock minimumLineSpacingBlock:(XYCollectionMinimumLineSpacingBlock)minimumLineSpacingBlock itemSizeBlock:(XYCollectionItemSizeBlock)itemSizeBlock cellBlock:(XYCollectionCellBlock)cellBlock didSelectBlock:(XYCollectionDidSelectBlock)didSelectBlock;
@end


