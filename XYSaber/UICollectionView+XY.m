//
//  UICollectionView+XY.m
//  XYKit
//
//  Created by lxy on 2019/1/16.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "UICollectionView+XY.h"
#import "XYMacro.h"
#import <UIView+XY.h>
#import <objc/runtime.h>

@implementation XYCollectionHeaderView
-(instancetype)initWithHeight:(CGFloat)height reuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithFrame:CGRectMake(0, 0, xy_kwidth, height)];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}
@end

@implementation XYCollectionFooterView
-(instancetype)initWithHeight:(CGFloat)height reuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithFrame:CGRectMake(0, 0, xy_kwidth, height)];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}
@end

@interface UICollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@end

static XYCollectionSectionNumBlock numOfSectionBlock_id = nil;
static XYCollectionHeaderBlock headerBlock_id = nil;
static XYCollectionHeaderHeightBlock headerHeightBlock_id = nil;
static XYCollectionFooterHeightBlock footerHeightBlock_id = nil;
static XYCollectionFooterBlock footerBlock_id = nil;
static XYCollectionItemNumBlock numOfItemBlock_id = nil;
static XYCollectionMinimumLineSpacingBlock minimumLineSpacingBlock_id = nil;
static XYCollectionMinimumInteritemSpacingBlock minimumInteritemSpacingBlock_id = nil;
static XYCollectionItemSizeBlock itemSizeBlock_id = nil;
static XYCollectionCellBlock cellBlock_id = nil;
static XYCollectionDidSelectBlock didSelectBlock_id = nil;

static NSMutableArray *headerViewArray_id = nil;
static NSMutableArray *footerViewArray_id = nil;


@implementation UICollectionView (XY)

-(void)xy_setDelegateWithHeaderHeight:(CGFloat)headerHeight registerCellClassArray:(NSArray*)registerCellClassArray registerCellIdArray:(NSArray*)registerCellIdArray numOfSectionBlock:(XYCollectionSectionNumBlock)numOfSectionBlock headerBlock:(XYCollectionHeaderBlock)headerBlock footerBlock:(XYCollectionFooterBlock)footerBlock numOfItemsBlock:(XYCollectionItemNumBlock)numOfItemBlock minimumInteritemSpacingBlock:(XYCollectionMinimumInteritemSpacingBlock)minimumInteritemSpacingBlock minimumLineSpacingBlock:(XYCollectionMinimumLineSpacingBlock)minimumLineSpacingBlock itemSizeBlock:(XYCollectionItemSizeBlock)itemSizeBlock cellBlock:(XYCollectionCellBlock)cellBlock didSelectBlock:(XYCollectionDidSelectBlock)didSelectBlock{
    
    for (int i = 0; i < registerCellIdArray.count;i++ ) {
        NSString *cellId = registerCellIdArray[i];
        [self registerClass:registerCellClassArray[i] forCellWithReuseIdentifier:cellId];
    }
    
    
    
    self.contentInset = UIEdgeInsetsMake(headerHeight, 0, 0, 0);//设置头视图高度
    
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    objc_setAssociatedObject(self, &numOfSectionBlock_id, numOfSectionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &headerBlock_id, headerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &footerBlock_id, footerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &numOfItemBlock_id, numOfItemBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &minimumLineSpacingBlock_id, minimumLineSpacingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &minimumInteritemSpacingBlock_id, minimumInteritemSpacingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &itemSizeBlock_id, itemSizeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &cellBlock_id, cellBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &didSelectBlock_id, didSelectBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    self.delegate = self;
    self.dataSource = self;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {

        NSMutableArray *headerArray = objc_getAssociatedObject(self, &headerViewArray_id);
        XYCollectionHeaderView *headerView = headerArray[indexPath.section];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerView.reuseIdentifier];
        
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerView.reuseIdentifier forIndexPath:indexPath];
        [header xy_removeAllSubViews];
//        headerView.frame = CGRectMake(0, 0, header.width, header.height);
        [header addSubview:headerView];
        return header;
    }else{

        NSMutableArray *footerArray = objc_getAssociatedObject(self, &footerViewArray_id);
        XYCollectionFooterView *footerView = footerArray[indexPath.section];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerView.reuseIdentifier];
        
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerView.reuseIdentifier forIndexPath:indexPath];
        [footer xy_removeAllSubViews];
//        footerView.frame = CGRectMake(0, 0, footer.width, footer.height);
        [footer addSubview:footerView];
        return footer;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    NSMutableArray *headerArray = objc_getAssociatedObject(self, &headerViewArray_id);
    if (!headerArray) {
        headerArray = [NSMutableArray array];
        objc_setAssociatedObject(self, &headerViewArray_id, headerArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    XYCollectionHeaderBlock headerBl = objc_getAssociatedObject(self, &headerBlock_id);
    if (!headerBl) {
        return CGSizeMake(0, 0);
    }
    XYCollectionHeaderView *headerView = headerBl(collectionView,section);
    [headerArray addObject:headerView];

    return CGSizeMake(1, headerView.height);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    NSMutableArray *footerArray = objc_getAssociatedObject(self, &footerViewArray_id);
    if (!footerArray) {
        footerArray = [NSMutableArray array];
        objc_setAssociatedObject(self, &footerViewArray_id, footerArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    XYCollectionFooterBlock footerBl = objc_getAssociatedObject(self, &footerBlock_id);
    if (!footerBl) {
        return CGSizeMake(0, 0);
    }
    XYCollectionFooterView *footerView = footerBl(collectionView,section);
    [footerArray addObject:footerView];

    return CGSizeMake(1, footerView.height);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    XYCollectionItemNumBlock bl = objc_getAssociatedObject(self, &numOfItemBlock_id);
    return bl(collectionView,section);
}
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    XYCollectionSectionNumBlock bl = objc_getAssociatedObject(self, &numOfSectionBlock_id);
    return bl(collectionView);
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    XYCollectionMinimumLineSpacingBlock bl = objc_getAssociatedObject(self, &minimumLineSpacingBlock_id);
    return bl(collectionView,collectionViewLayout,section);
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    XYCollectionMinimumInteritemSpacingBlock bl = objc_getAssociatedObject(self, &minimumInteritemSpacingBlock_id);
    return bl(collectionView,collectionViewLayout,section);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYCollectionItemSizeBlock bl = objc_getAssociatedObject(self, &itemSizeBlock_id);
    CGSize size = bl(collectionView,collectionViewLayout,indexPath);
    return size;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYCollectionCellBlock cellBl = objc_getAssociatedObject(self, &cellBlock_id);
    UICollectionViewCell *cell = cellBl(collectionView,indexPath);
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XYCollectionDidSelectBlock bl = objc_getAssociatedObject(self, &didSelectBlock_id);
    bl(collectionView,indexPath);
}


@end
