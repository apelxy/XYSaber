//
//  UIView+MASAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "XYMASUtilities.h"
#import "XYMASConstraintMaker.h"
#import "XYMASViewAttribute.h"

/**
 *	Provides constraint maker block
 *  and convience methods for creating MASViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface MAS_VIEW (XYMASAdditions)

/**
 *	following properties return a new MASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_left;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_top;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_right;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_bottom;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_leading;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_trailing;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_width;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_height;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_centerX;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_centerY;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_baseline;
@property (nonatomic, strong, readonly) XYMASViewAttribute *(^mas_attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_firstBaseline;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_leftMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_rightMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_topMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_bottomMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_leadingMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_trailingMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_centerXWithinMargins;
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_centerYWithinMargins;

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_safeAreaLayoutGuide API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) XYMASViewAttribute *mas_safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0),tvos(11.0));

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic, strong) id mas_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view;

/**
 *  Creates a XYMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)mas_makeConstraints:(void(NS_NOESCAPE ^)(XYMASConstraintMaker *make))block;

/**
 *  Creates a XYMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_updateConstraints:(void(NS_NOESCAPE ^)(XYMASConstraintMaker *make))block;

/**
 *  Creates a XYMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_remakeConstraints:(void(NS_NOESCAPE ^)(XYMASConstraintMaker *make))block;

@end
