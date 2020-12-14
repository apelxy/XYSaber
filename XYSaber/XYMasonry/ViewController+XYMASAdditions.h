//
//  UIViewController+MASAdditions.h
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "XYMASUtilities.h"
#import "XYMASConstraintMaker.h"
#import "XYMASViewAttribute.h"

#ifdef MAS_VIEW_CONTROLLER

@interface MAS_VIEW_CONTROLLER (XYMASAdditions)

/**
 *	following properties return a new MASViewAttribute with appropriate UILayoutGuide and NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_topLayoutGuide;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_bottomLayoutGuide;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_topLayoutGuideTop;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_topLayoutGuideBottom;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_bottomLayoutGuideTop;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_bottomLayoutGuideBottom;


@end

#endif
